//Created  on 2019/4/18 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 *
 */




import Foundation
import CD
import TabbarNavigation
import Util

class AppDelegate_VC: CD_AppDelegate {
    var window: UIWindow?
    init(_ win: UIWindow?) {
        window = win
    }
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        let vc = VC_Tab.show()
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
        return true
    }
}
class AppDelegate_Config: CD_AppDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        
        CD_TopBar.Model.color_line = Config.color.line_1
        CD_TopBar.Model.color_normal = Config.color.main_2
        CD_TopBar.Model.back = .title([(CD_IconFont.tback_light(30).text,CD_IconFont.tback(30).font,Config.color.main_3,.normal), (CD_IconFont.tback(30).text,CD_IconFont.tback_light(30).font,.lightGray,.highlighted), (CD_IconFont.tback(30).text,CD_IconFont.tback_light(30).font,.lightGray,.selected)])
        
        return true
    }
}

class AppDelegate_UM: CD_AppDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        return true
    }
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return true
    }
}
class AppDelegate_Notifications: CD_AppDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        return true
    }
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
    }
}
