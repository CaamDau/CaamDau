//Created  on 2019/8/28 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 *
 */




import Foundation
import CaamDau
#if DEBUG
import DoraemonKit
#endif

public class App_Debugging: AppProtocol {
    public enum Notice:String, NotificationProtocol {
        public var name: Notification.Name {
            return Notification.Name("App_Debugging." + self.rawValue)
        }
        
        case domainChange = "domainChange"
        case netTest = "netTest"
        case domainGet = "domainGet"
    }
    
    public func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        #if DEBUG
        DoraemonManager.shareInstance().addPlugin(withTitle: "环境切换", icon: "", desc: "用于app内部环境切换功能", pluginName: "", atModule: "App 调试业务 此面板仅供测试调试", handle: { res in
            App_Debugging.Notice.domainChange.post()
            DoraemonManager.shareInstance().hiddenHomeWindow()
        })
        
        DoraemonManager.shareInstance().addPlugin(withTitle: "接口测试", icon: "", desc: "接口测试", pluginName: "", atModule: "App 调试业务 此面板仅供测试调试", handle: { res in
            App_Debugging.Notice.netTest.post()
            DoraemonManager.shareInstance().hiddenHomeWindow()
        })
        
        DoraemonManager.shareInstance().addPlugin(withTitle: "动态域名切换", icon: "", desc: "动态域名切换", pluginName: "", atModule: "App 调试业务 此面板仅供测试调试", handle: { res in
            App_Debugging.Notice.domainGet.post()
            DoraemonManager.shareInstance().hiddenHomeWindow()
        })
        
        DoraemonManager.shareInstance().install()
        #endif
        return true
    }
}
