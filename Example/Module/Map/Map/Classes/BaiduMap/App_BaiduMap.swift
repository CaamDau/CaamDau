//Created  on 2020/3/3 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 *
 */




import Foundation


class App_BaiduMap: CD_AppDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        // 初始化定位SDK
        BMKLocationAuth.sharedInstance()?.checkPermision(withKey: "UyjvnHVpKfuQDrpwPqtIyZA69WHeFDRR", authDelegate: self)
        let map = BMKMapManager()
        let res = map.start("UyjvnHVpKfuQDrpwPqtIyZA69WHeFDRR", generalDelegate: self)
        print_cd("百度地图启动引擎：",res)
        CD_LocationBaidu.shared.location()
        
//        BMKLocationAuth.sharedInstance()?.checkPermision(withKey: "aWl33QKO6SpMPfxZQs0hykc9OCVgQHbR", authDelegate: self)
//        let map = BMKMapManager()
//        let res = map.start("aWl33QKO6SpMPfxZQs0hykc9OCVgQHbR", generalDelegate: self)
        return true
    }
}

extension App_BaiduMap:BMKLocationAuthDelegate {
    func onCheckPermissionState(_ iError: BMKLocationAuthErrorCode) {
        print_cd("百度定位授权验证：",iError.rawValue)
    }
}
extension App_BaiduMap:BMKGeneralDelegate {
    func onGetNetworkState(_ iError: Int32) {
        print_cd("百度地图网络：",iError)
    }
    func onGetPermissionState(_ iError: Int32) {
        print_cd("百度地图授权验证：",iError)
    }
}
