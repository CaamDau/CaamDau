//Created  on 2019/6/20 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 *
 */




import Foundation
import CD


public class App_Net: CD_AppDelegate {
    public func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        
        #if DEBUG
        CD_Net.config.baseURL = ""
        #else
        CD_Net.config.baseURL = ""
        #endif
        
        return true
    }
}
