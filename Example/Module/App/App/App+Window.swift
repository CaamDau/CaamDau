//Created  on 2019/7/2 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 *
 */




import Foundation
import TabBarNavigation
import Mine
import Home

class App_VC: CD_AppDelegate {
    var window: UIWindow?
    var tabbar: VC_TabBar?
    init(_ win: UIWindow?) {
        window = win
    }
    var observer:[NSObjectProtocol] = []
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        window?.makeKeyAndVisible()
        
        User.shared.statusNotification = true
        observer.append(User.notice.signIn.add(block: { [weak self](n) in
            self?.makeTabBar()
        }))
        observer.append(User.notice.signOut.add(block: { [weak self](n) in
            self?.makeSign()
        }))
        observer.append(User.notice.signForced.add(block: { [weak self](n) in
            self?.makeSign()
        }))
        let token = User.shared.token
        if token.isEmpty {
            //makeSign()
            makeTabBar()
        }else{
            //makeSign()
            makeTabBar()
        }
        return true
    }
    func makeSign() {
        
    }
    
    func makeTabBar() {
        let vc1 = UINavigationController(rootViewController: R_Home().vc)
        let vc2 = UINavigationController(rootViewController: R_Mine().vc)
        let vc3 = UINavigationController(rootViewController: R_Mine().vc)
        let vc4 = UINavigationController(rootViewController: R_Mine().vc)
        
        tabbar = VC_TabBar().cd
            .viewControllers([vc1,
                              vc2,
                              vc3,
                              vc4
            ])
            .build
        tabbar?.makeTabBar()
        tabbar?.selectedIndex = 3
        window?.rootViewController = tabbar
    }
}
