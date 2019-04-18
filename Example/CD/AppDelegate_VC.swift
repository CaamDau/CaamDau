//Created  on 2019/4/18 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 *
 */




import Foundation
import CD
import TabbarNavigation

class AppDelegate_VC: CD_AppDelegate {
    
    var window: UIWindow?
    
    init(_ win: UIWindow?) {
        window = win
    }
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        //let vc = VC_Tab.show()
        //window?.rootViewController = vc
        //window?.makeKeyAndVisible()
        return true
    }
}

class AppDelegate_UM: CD_AppDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        return true
    }
}
