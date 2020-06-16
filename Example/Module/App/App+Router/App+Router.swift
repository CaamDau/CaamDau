//Created  on 2019/9/2 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 *
 */




import Foundation


class App_Router: CD_AppDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        /*
        CD_Router.shared.routerHandler = { [weak self](r, param, callback) in
            self?.utility(r, param, callback)
            self?.sign(r, param, callback)
            self?.map(r, param, callback)
        }*/
        return true
    }
    
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        
        self.sign(open:url)
        
        return true
    }
}


extension URL {
    public var paths : [String] {
        var paths = self.pathComponents
        paths.removeAll{ $0 == "/"}
        return paths
    }
    
    public var parameters : [String: String]? {
        guard let components = URLComponents(url: self, resolvingAgainstBaseURL: true),
        let queryItems = components.queryItems else { return nil }
        return queryItems.reduce(into: [String: String]()) { (result, item) in
            result[item.name] = item.value
        }
    }
}
