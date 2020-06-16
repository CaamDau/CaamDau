//Created  on 2019/7/9 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 *
 */




import UIKit
#if DEBUG
//import Debugging
#endif

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    lazy var composite: AppComposite = {
        var arr:[AppProtocol] = [
            App_Router(),
            App_Net(),
            App_VC(window),
            App_Config()
        ]
        
        #if DEBUG
        //arr.insert(App_Debugging(), at: 0)
        //arr.append(App_NetTest())
        #endif
        
        return AppComposite(arr)
    }()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        composite.application(application, didFinishLaunchingWithOptions:launchOptions)
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return composite.application(app, open: url, options: options)
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
    
    func applicationWillTerminate(_ application: UIApplication) {
        composite.applicationWillTerminate(application)
    }
}

