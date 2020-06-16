//Created  on 2019/6/20 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 *
 */


import Foundation
import CaamDau
import Alamofire
import SwiftyJSON

public class App_Net: AppProtocol {
    
    var observer:[NSObjectProtocol] = []
    var domainType:Int = 0
    func domainGet(_ type:Int) -> (String, String) {
        switch type {
        case -1:
            return ("https://baidu.com", "开发环境")
        case 0:
            return ("http://apis.juhe.cn", "测试环境")
        case 1:
            return ("http://apis.juhe.cn", "生产环境")
        case 2:
            return ("http://172.17.32:88", "生产环境")
        default:
            return ("", "未配置环境")
        }
    }
    ///- 生产、测试环境 域名配置
    func domainSwitching(_ type:Int) {
        domainType = type
        Net.config.baseURL = domainGet(type).0
    }
    
    public func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        // - 生产、测试环境 域名配置
        #if DEBUG
        let type = 0
        #else
        let type = 1
        #endif
        domainSwitching(type)
        
        // - 基本网络配置
        Net.config.method = .post
        Net.config.encoding = JSONEncoding(options: [])
        // responseStyle 默认为.data
        //Net.config.responseStyle = .json
        Net.config.headers = [:]
        Net.config.log = true
        Net.config.logHandler = { (res, h, p) in
            guard let res = res else { return }
            var url:URL?
            var value:Any?
            if let res = res as? DataResponse<Any> {
                url = res.request?.url
                value = res.result.value
            }
            else if let res = res as? DataResponse<Data> {
                url = res.request?.url
                value = res.result.value
            }
            else if let res = res as? DataResponse<String> {
                url = res.request?.url
                value = res.result.value
            }
            debugPrint("---👉👉👉", url ?? "")
            debugPrint("Parameters：", p ?? "")
            debugPrint(JSON( value ?? "未知数据"))
            debugPrint("----------  👻")
        }
        
        // - 登录登出  接口增补参数配置
        if !User.shared.info.userid.isEmpty {
            Net.config.parametersSubjoin = ["token":User.shared.token]
            Net.config.parametersHandler = { (p) -> [String:Any]? in
                /// 执行参数签名
                return p
            }
            requestUserMessageOnCache()
            App_Net.requestData()
        }
        observer.append(User.notice.signIn.add(block: { (_) in
            Net.config.parametersSubjoin = ["token":User.shared.token]
            App_Net.requestData()
        }))
        observer.append(User.notice.signOut.add(block: { (n) in
            Net.config.parametersSubjoin = [:]
        }))
        observer.append(User.notice.signForced.add(block: { (n) in
            Net.config.parametersSubjoin = [:]
        }))
        
        
        debuggingDomainChange()
        return true
    }
    
    
    public static func requestData() {
        requestUserMessage()
        
    }
    /// 获取用户信息
    func requestUserMessageOnCache() {
        
    }
    public static func requestUserMessage() {
        
        
    }
}



extension App_Net {
    func debuggingDomainChange(){
        let notice = NotificationCenter.default
        let name = Notification.Name("App_Debugging.domainChange")
        observer.append(notice.addObserver(forName: name, object: nil, queue: nil) { [weak self](n) in
            guard let self = self else{ return }
            var domain = self.domainGet(self.domainType)
            if domain.0 != Net.config.baseURL {
                domain.0 = Net.config.baseURL
            }
            UIAlertController.cd_init(style: .actionSheet).cd
                .title("环境切换")
                .message("当前：" + domain.1 + "：" + domain.0)
                .action("取消", style: .cancel)
                .action("开发环境", handler: { [weak self](a) in
                    self?.domainSwitching(-1)
                    User.shared.signOut(User.shared.account)
                    CD.window?.hud_msg("环境已切换:"+Net.config.baseURL)
                })
                .action("测试环境", handler: { [weak self](a) in
                    self?.domainSwitching(0)
                    User.shared.signOut(User.shared.account)
                    CD.window?.hud_msg("环境已切换:"+Net.config.baseURL)
                })
                .action("生产环境", handler: { [weak self](a) in
                    self?.domainSwitching(1)
                    User.shared.signOut(User.shared.account)
                    CD.window?.hud_msg("环境已切换:"+Net.config.baseURL)
                })
                .show()
        })
    }
}
