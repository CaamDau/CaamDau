//Created  on 16/6/8 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 1,在 info.plist里加入定位描述（Value值为空也可以）：
    <key>NSLocationAlwaysUsageDescription</key>
	<string>App需要您的允许，才能访问您的位置；若不允许，App将无法提供精准定位、搜索服务。</string>
	<key>NSLocationWhenInUseUsageDescription</key>
	<string>App需要您的允许，才能在使用期间访问您的位置；若不允许，App将无法提供精准定位、搜索服务。</string>
 
 4,使用：
CD_LocationBaidu.shared.getLocation(.Baidu) { [weak self](bool, coo) in
    if isChange {
        print("位置变更")
    }
}
CD_LocationBaidu.shared.blockCityChange = { [weak self](address) in
    print("城市（省、市、区）变更")
}
 */

import CaamDau
import Foundation


public struct R_LocationBaidu: CD_RouterInterface {
    public static func router(_ param: CD_RouterParameter, callback: CD_RouterCallback) {
        
    }
}


extension CD_LocationBaidu {
    public struct Address {
        public var country = ""
        public var countryCode = ""
        public var province = ""
        public var city = ""
        public var cityCode = ""
        /// 区
        public var district = ""
        /// 乡镇名字
        public var town = ""
        /// 街道名字
        public var street = ""
        /// 街道号码
        public var number = ""
        
        public var address = ""
        /// 行政编码
        public var postalCode = ""
        /// 经纬度
        public var coordinate:(longitude:Double, latitude:Double) = (0,0)
        /// 位置id
        public var locationID = ""
        
        init() {
            
        }
        init(location loc:BMKLocation) {
            country = loc.rgcData?.country ?? ""
            countryCode = loc.rgcData?.countryCode ?? ""
            province = loc.rgcData?.province ?? ""
            city = loc.rgcData?.city ?? ""
            cityCode = loc.rgcData?.cityCode ?? ""
            district = loc.rgcData?.district ?? ""
            town = loc.rgcData?.town ?? ""
            street = loc.rgcData?.street ?? ""
            number = loc.rgcData?.streetNumber ?? ""
            postalCode = loc.rgcData?.adCode ?? ""
            address = country+province+city+district+town+street
            let lon = loc.location?.coordinate.longitude ?? 0
            let lat = loc.location?.coordinate.latitude ?? 0
            coordinate = (lon, lat)
            locationID = loc.locationID ?? ""
            
            Userde.longitude.save(lon)
            Userde.latitude.save(lat)
        }
        
        
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
        case addressChange = "addressChange"
    }
}


public class CD_LocationBaidu:NSObject {
    public static let shared = CD_LocationBaidu()
    private override init() {}
    public var address:Address = Address()
    public var userLocation:BMKUserLocation = BMKUserLocation()
    public var updateLocationCallback:((BMKUserLocation)->Void)?
    
    //MARK:BMKLocationManager
    lazy var locationManager: BMKLocationManager = {
        //初始化BMKLocationManager的实例
        let manager = BMKLocationManager()
        manager.delegate = self
        //设置定位管理类实例的代理
        //设定定位坐标系类型，默认为 BMKLocationCoordinateTypeGCJ02
        manager.coordinateType = BMKLocationCoordinateType.BMK09LL
        //设置距离过滤参数
        manager.distanceFilter = kCLDistanceFilterNone;
        //设定定位精度，默认为 kCLLocationAccuracyBest
        manager.desiredAccuracy = kCLLocationAccuracyBest
        //设定定位类型，默认为 CLActivityTypeAutomotiveNavigation
        manager.activityType = CLActivityType.automotiveNavigation
        //指定定位是否会被系统自动暂停，默认为NO
        manager.pausesLocationUpdatesAutomatically = false
        /*/在IOS8以上系统中，需要使用requestWhenInUseAuthorization方法才能弹窗让用户确认是否允许使用定位服务的窗口
        if #available(iOS 8.0, *) {
            //用户还没有做出选择，弹窗发送授权申请 让用户选择
            if CLLocationManager.authorizationStatus() == .notDetermined {
                manager.allowsBackgroundLocationUpdates = false
                //manager.requestWhenInUseAuthorization()//只在前台定位
                //manager.requestAlwaysAuthorization()//前后台定位
            }
                //用户没有授权，提醒用户授权
            else if(CLLocationManager.authorizationStatus() == .denied){
                openSettings("无法定位，因为您没有授权使用定位，请到系统设置中开启")
            }
        }*/
        /**
         是否允许后台定位，默认为NO。只在iOS 9.0及之后起作用。
         设置为YES的时候必须保证 Background Modes 中的 Location updates 处于选中状态，否则会抛出异常。
         由于iOS系统限制，需要在定位未开始之前或定位停止之后，修改该属性的值才会有效果。
         */
        //manager.allowsBackgroundLocationUpdates = false
        /**
         指定单次定位超时时间,默认为10s，最小值是2s。注意单次定位请求前设置。
         注意: 单次定位超时时间从确定了定位权限(非kCLAuthorizationStatusNotDetermined状态)
         后开始计算。
         */
        manager.locationTimeout = 10
        manager.reGeocodeTimeout = 10
        
        return manager
    }()
    
    func locationOnce(_ callback:(([String:Any], String?)->Void)? = nil) {
        locationManager.stopUpdatingLocation()
        locationManager.requestLocation(withReGeocode: true, withNetworkState: true) { [weak self](loc, state, error) in
            if let message = error?.localizedDescription {
                callback?([:], message)
                return
            }
            if let loc = loc{
                let address = Address(location: loc)
                self?.address = address
                callback?(address.toParam(), nil)
            }else{
                callback?([:], "定位失败")
            }
        }
    }
    func location() {
        locationManager.startUpdatingLocation()
    }
}


extension CD_LocationBaidu: BMKLocationManagerDelegate {
    
    /**
     @brief 连续定位回调函数
     @param manager 定位 BMKLocationManager 类
     @param location 定位结果，参考BMKLocation
     @param error 错误信息。
     */
    public func bmkLocationManager(_ manager: BMKLocationManager, didUpdate location: BMKLocation?, orError error: Error?) {
        
        if let message = error?.localizedDescription {
            print_cd("连续定位:定位失败:", message)
            Notice.locationError.post(nil, userInfo: ["message":message])
            return
        }
        if let loc = location {
            print_cd("连续定位:", loc)
            let address = Address(location: loc)
            let addOld = self.address
            self.address = address
            let param = address.toParam()
            if addOld.cityCode != address.cityCode {
                Notice.cityChange.post(nil, userInfo: param)
            }
            if addOld.address != address.address {
                Notice.addressChange.post(nil, userInfo: param)
            }
            if addOld.coordinate != address.coordinate {
                Notice.locationChange.post(nil, userInfo: param)
            }
            userLocation.location = loc.location
            updateLocationCallback?(userLocation)
        }else{
            print_cd("连续定位:定位失败")
            Notice.locationError.post(nil, userInfo: ["message":"定位失败"])
        }
    }
    
    /**
     @brief 当定位发生错误时，会调用代理的此方法
     @param manager 定位 BMKLocationManager 类
     @param error 返回的错误，参考 CLError
     */
    public func bmkLocationManager(_ manager: BMKLocationManager, didFailWithError error: Error?) {
        print_cd("定位失败")
        //如果设备没有开启定位服务
        guard CLLocationManager.locationServicesEnabled() else {
            openSettings()
            return
        }
    }
    
    public func bmkLocationManager(_ manager: BMKLocationManager, didChange status: CLAuthorizationStatus) {
        print_cd("定位权限状态改变：", status.rawValue)
    }
    
    public func bmkLocationManager(_ manager: BMKLocationManager, didUpdate state: BMKLocationNetworkState, orError error: Error?) {
        print_cd("网络状态改变：", state.rawValue)
    }
    
    public func bmkLocationManager(_ manager: BMKLocationManager, doRequestAlwaysAuthorization locationManager: CLLocationManager) {
        print_cd("后台定位")
        locationManager.requestAlwaysAuthorization()
    }
    
    public func bmkLocationManager(_ manager: BMKLocationManager, didUpdate heading: CLHeading?) {
        userLocation.heading = heading
        updateLocationCallback?(userLocation)
    }
    
    public func bmkLocationManagerShouldDisplayHeadingCalibration(_ manager: BMKLocationManager) -> Bool {
        return true
    }
}



extension CD_LocationBaidu {
    private func openSettings(_ title:String = "无法定位，因为您的设备没有启用定位服务，请到系统设置中开启") {
        guard !Userde.alertOff.bool else {
            return
        }
        func open(){
            if #available(iOS 10.0, *) {
                UIApplication.shared
                    .open(UIApplication.openSettingsURLString.urlValue, options: [:], completionHandler:nil)
            }else{
                UIApplication.shared
                    .open("prefs:root=LOCATION_SERVICES".urlValue, options: [:], completionHandler:nil)
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
                .show()
        }
    }
}

