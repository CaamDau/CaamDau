//Created  on 2020/3/5 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 *
 */




import UIKit

public struct R_BaiduMapView {
    public var vc: UIViewController {
        return VC_BaiduMapView()
    }
    
    
}

class VC_BaiduMapView: UIViewController {
    
    lazy var mapView: BMKMapView = {
        let map = BMKMapView(frame: self.view.bounds)
        map.delegate = self
        //将当前地图显示缩放等级设置为17级 - 室内地图
        map.zoomLevel = 20
        //显示定位图层
        map.showsUserLocation = true
        // 跟随模式
        map.userTrackingMode = BMKUserTrackingModeFollow
        // 打开室内地图
        map.baseIndoorMapEnabled = true
        // 比例尺
        map.showMapScaleBar = false
        // 实时路况
        map.isTrafficEnabled = false
        
        //精度圈
        map.updateLocationView(with: param)
        return map
    }()
    
    lazy var param: BMKLocationViewDisplayParam = {
        let param = BMKLocationViewDisplayParam()
        //是否显示精度圈
        param.isAccuracyCircleShow = false
        //精度圈 边框颜色
        param.accuracyCircleStrokeColor = UIColor.blue.cd_alpha(0.5)
        //精度圈 填充颜色
        param.accuracyCircleFillColor = UIColor.blue.cd_alpha(0.2)
        return param
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.cd.navigationBar(hidden: true)
        makeBaiduMapView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mapView.viewWillAppear()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        mapView.viewWillDisappear()
    }
}

extension VC_BaiduMapView {
    func makeBaiduMapView() {
        self.view.cd.background(.white).add(mapView)
        mapView.snp.makeConstraints{$0.edges.equalToSuperview()}
        CD_LocationBaidu.shared.updateLocationCallback = { [weak self] loc in
            self?.mapView.updateLocationData(loc)
        }
    }
}

extension VC_BaiduMapView: BMKMapViewDelegate {
    func mapview(_ mapView: BMKMapView!, baseIndoorMapWithIn flag: Bool, baseIndoorMapInfo info: BMKBaseIndoorMapInfo!) {
        if (flag) {//进入室内地图
           
        } else {//移出室内地图
           
        }
    }
    
}
