//Created  on 2019/3/12 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 *
 */




import UIKit
import CaamDau

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    lazy var composite: CD_AppDelegateComposite = {
        var arr:[CD_AppDelegate] = [
            AppDelegate_VC(),
            AppDelegate_UM()
        ]
        #if DEBUG
        arr.append(AppDelegate_Test())
        #endif
        
        return CD_AppDelegateComposite(arr)
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



class AppDelegate_VC: CD_AppDelegate {
    
}

class AppDelegate_UM: CD_AppDelegate {
    
}

class AppDelegate_Test: CD_AppDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        CD_Net.config.baseURL = "https://taobao.com"
        
        
        
        
        do{
            let net = TTNet()
            net.method(.get)
            .parameters(["a":1])
            .success({ (res) in
                
            })
            .failure({ (err) in
                
            })
            .request()
            
            print_cd(net.baseURL, net.parameters, net.method)
        }
        
        do{
            let net = CD_Net()
            
            net
            .method(.post)
            .parameters(["aa":11])
            .success({ (res) in
                
            })
                .failure({ (err) in
                
            })
            .request()
            print_cd(net.baseURL, net.parameters, net.method)
        }
            
        
        
        
        return true
    }
}


class TTNet: CD_Net {
    override init() {
        super.init()
        baseURL = "https://baidu.com"
    }
}
