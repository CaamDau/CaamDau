//Created  on 16/6/8 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 1,在 info.plist里加入定位描述（Value值为空也可以）：
    <key>NSLocationAlwaysUsageDescription</key>
	<string>App需要您的允许，才能访问您的位置；若不允许，App将无法提供精准定位、搜索服务。</string>
	<key>NSLocationWhenInUseUsageDescription</key>
	<string>App需要您的允许，才能在使用期间访问您的位置；若不允许，App将无法提供精准定位、搜索服务。</string>
 2,在桥接文件中添加
   #import "CLLocation+YCLocation.h"
 3,添加CoreLocation.framework
 4,使用：
CD_LocationSys.shared.getLocation(.Baidu) { [weak self](bool, coo) in
    if isChange {
        print("位置变更")
    }
}
CD_LocationSys.shared.blockCityChange = { [weak self](address) in
    print("城市（省、市、区）变更")
}
 */

import CaamDau
import Foundation


public struct R_LocationSys: CD_RouterInterface {
    public static func router(_ param: CD_RouterParameter, callback: CD_RouterCallback) {
        CD_LocationSys.shared.blockCityChange = { a in
            guard let city = a.last else { return }
            callback?(["address":city.toParam()])
        }
        CD_LocationSys.shared.getLocation()
    }
}


extension CD_LocationSys {
    public struct Address {
        public var country = ""
        public var countryCode = ""
        public var province = ""
        public var provinceSub = ""
        public var city = ""
        public var citySub = ""
        public var street = ""
        public var number = ""
        public var address = ""
        public var postalCode = ""
        
        func toParam() -> [String:Any] {
            let structMirror = Mirror(reflecting: self).children
            var param:[String:Any] = [:]
            structMirror
                .filter{$0.label != nil}
                .forEach{ param[$0.label!.stringValue] = $0.value }
            return param
        }
    }
    public enum CoordinateType {
        case Baidu
        case Mars
        case GPS
    }
    
    public enum Userde:String, CaamDauUserDefaultsProtocol {
        public var name: String {
            return CD.appId + "cd.locationSys" + self.rawValue
        }
        case latitude = "latitude"
        case longitude = "longitude"
        case alertOff = "alertOff"
    }
    
    public enum Notice:String, CaamDauNotificationProtocol {
        public var name: Notification.Name {
            return Notification.Name(CD.appId + "cd.locationSys" + self.rawValue)
        }
        case locationChange = "locationChange"
        case locationError = "locationError"
        case cityChange = "cityChange"
    }
}


public class CD_LocationSys:NSObject {
    public static let shared = CD_LocationSys()
    private override init() {}
    /// 用户位置
    open var _currentCoord: CLLocationCoordinate2D {
        set{
            Userde.latitude.save(newValue.latitude)
            Userde.longitude.save(newValue.latitude)
        }
        get{
            let latitude = Userde.latitude.value as? Double ?? 0.0
            let longitude = Userde.longitude.value as? Double ?? 0.0
            
            var currentCoordinate = CLLocationCoordinate2DMake(latitude, longitude)
            if(longitude == 0.0 || longitude == 0.0) {
                Userde.latitude.save(39.0)
                Userde.latitude.save(116.0)
                currentCoordinate = CLLocationCoordinate2DMake(39.0, 116.0)
            }
            return currentCoordinate
        }
    }
    
    //MARK:----------- 定位服务
    ///位置变更回调
    open var blockLocationChange:((Bool, CLLocationCoordinate2D)->Void)?
    ///地址变更回调
    open var blockCityChange:(([Address])->Void)?
    ///定位异常回调
    open var blockLocationError:((Error)->Void)?
    
    
    private var _coordinateType:CoordinateType = .GPS
    private var _locationManager:CLLocationManager!
    
    private func openSettings(_ title:String = "无法定位，因为您的设备没有启用定位服务，请到系统设置中开启") {
        guard !Userde.alertOff.bool else {
            return
        }
        func open(){
            if #available(iOS 10.0, *) {
                UIApplication.shared
                    .open(UIApplication.openSettingsURLString.urlValue, options: [:], completionHandler:nil)
            }else{
                UIApplication.shared.openURL(UIApplication.openSettingsURLString.urlValue)
            }
        }
        
        DispatchQueue.main.async{
            UIAlertController.cd_init().cd
                .title(title)
                .action("不再提示", handler: { (a) in
                    Userde.alertOff.save(true)
                })
                .action("知道了")
                .action("开启", handler: { (a) in
                    open()
                })
                .show(CD.visibleVC!)
        }
    }
    
    public func getLocation(_ type:CoordinateType = .GPS, block: ((Bool, CLLocationCoordinate2D)->Void)? = nil){
        self._coordinateType = type
        //如果设备没有开启定位服务
        guard CLLocationManager.locationServicesEnabled() else {
            openSettings()
            return
        }
        _locationManager = CLLocationManager()
        /*
         定位服务管理类CLLocationManager的desiredAccuracy属性表示精准度，有如下6种选择：
         kCLLocationAccuracyBestForNavigation ：精度最高，一般用于导航
         kCLLocationAccuracyBest ： 精确度最佳
         kCLLocationAccuracyNearestTenMeters ：精确度10m以内
         kCLLocationAccuracyHundredMeters ：精确度100m以内
         kCLLocationAccuracyKilometer ：精确度1000m以内
         kCLLocationAccuracyThreeKilometers ：精确度3000m以内
         */
        //设置定位获取成功或者失败后的代理，Class后面要加上CLLocationManagerDelegate协议
        _locationManager.delegate = self
        //设置精确度
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest
        //更新距离
        _locationManager.distanceFilter = 100
        //在IOS8以上系统中，需要使用requestWhenInUseAuthorization方法才能弹窗让用户确认是否允许使用定位服务的窗口
        if #available(iOS 8.0, *) {
            //用户还没有做出选择，弹窗发送授权申请 让用户选择
            if CLLocationManager.authorizationStatus() == .notDetermined {
                _locationManager.requestWhenInUseAuthorization()//只在前台定位
                //_locationManager.requestAlwaysAuthorization()//前后台定位
            }
                //用户没有授权，提醒用户授权
            else if(CLLocationManager.authorizationStatus() == .denied){
                openSettings("无法定位，因为您没有授权使用定位，请到系统设置中开启")
            }
        }
        //开始获取定位信息，异步方式
        _locationManager.startUpdatingLocation()
        blockLocationChange = block
        Notice.locationChange.post()
    }
}


extension CD_LocationSys {
    class Location: NSObject {
        
    }
}

extension CD_LocationSys: CLLocationManagerDelegate {
    
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //获取最新的坐标
        guard locations.count > 0 else { return }
        //  使用last 获取 最后一个最新的位置， 前面是上一次的位置信息
        let currLocation:CLLocation = locations.last!
        // ---  将GPS坐标转换为指定坐标
        let amapcoord:CLLocationCoordinate2D?
        switch _coordinateType {
        case .Baidu:
            amapcoord = currLocation.locationBaiduFromEarth().coordinate
        case .Mars:
            amapcoord = currLocation.locationMarsFromEarth().coordinate
        default:
            amapcoord = currLocation.coordinate
        }
        // 如果坐标变动超过50m就通知
        let locationS = CLLocation(latitude: _currentCoord.latitude, longitude: _currentCoord.longitude)
        let locationE = CLLocation(latitude: amapcoord!.latitude, longitude: amapcoord!.longitude)
        let distance:CLLocationDistance = locationS.distance(from: locationE)
        //代理有时候会连续跑很多次，这里再增加限制
        if distance > 50.0 || distance < -50.0 {
            // --- 将新坐标存起来
            _currentCoord = amapcoord!
            // --- 进行变更
            blockLocationChange?(true, _currentCoord)
            Notice.locationChange.post()
        }else{
            blockLocationChange?(false, _currentCoord)
        }
        //获取定位的城市名字
        let geocoder = CLGeocoder()
        let loc = CLLocation(latitude: currLocation.coordinate.latitude, longitude:currLocation.coordinate.longitude)
        geocoder.reverseGeocodeLocation(loc, completionHandler: { [unowned self](placemarks, error) in
            guard let placemarks = placemarks else{return}
            var adresss:[Address] = []
            for placemark in placemarks {
                //print_SP(placemark.name)//地址
                //print_SP(placemark.thoroughfare)//街道
                //print_SP(placemark.subThoroughfare)//门牌号
                //print_SP(placemark.locality)//城市 、、如果是拼音首字母大写，没有市，Guangzhou
                //print_SP(placemark.subLocality)//城区
                //print_SP(placemark.administrativeArea)//省
                //print_SP(placemark.subAdministrativeArea)
                //print_SP(placemark.postalCode)
                //print_SP(placemark.ISOcountryCode)//国家编码
                //print_SP(placemark.country)//国家
                //print_SP(placemark.inlandWater)
                //print_SP(placemark.ocean)
                var adress = Address()
                adress.country = placemark.country ?? ""
                adress.countryCode = placemark.isoCountryCode ?? ""
                adress.province = placemark.administrativeArea ?? ""
                adress.provinceSub = placemark.subAdministrativeArea ?? ""
                adress.city = placemark.locality ?? ""
                adress.citySub = placemark.subLocality ?? ""
                adress.street = placemark.thoroughfare ?? ""
                adress.number = placemark.subThoroughfare ?? ""
                adress.address = placemark.name ?? ""
                adress.postalCode = placemark.postalCode ?? ""
                adresss.append(adress)
            }
            self.blockCityChange?(adresss)
            Notice.cityChange.post(adresss)
        })
    }
    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        blockLocationError?(error)
        Notice.locationError.post(error)
    }

}
