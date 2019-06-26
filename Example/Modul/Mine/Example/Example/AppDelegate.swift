//Created  on 2019/3/12 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 *
 */




import UIKit
import CaamDau

class AppDelegate_VC: CD_AppDelegate {
    
}

class AppDelegate_UM: CD_AppDelegate {
    
}


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    lazy var composite: CD_AppDelegateComposite = {
        return CD_AppDelegateComposite([AppDelegate_VC(),AppDelegate_UM()])
    }()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        return composite.application(application, didFinishLaunchingWithOptions: launchOptions)
    }

    func applicationWillResignActive(_ application: UIApplication) {
        composite.applicationWillResignActive(application)
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        composite.applicationDidEnterBackground(application)
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        composite.applicationWillEnterForeground(application)
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        composite.applicationDidBecomeActive(application)
    }
    
    func applicationDidReceiveMemoryWarning(_ application: UIApplication) {
        composite.applicationDidReceiveMemoryWarning(application)
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        composite.applicationWillTerminate(application)
    }
    
}

