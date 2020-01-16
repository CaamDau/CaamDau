//Created  on 2019/9/2 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 *
 */




import Foundation


class App_Router: CD_AppDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        CD_Router.shared.routerHandler = { [weak self](r, param, callback) in
            self?.utility(r, param, callback)
            self?.sign(r, param, callback)
        }
        return true
    }
}
