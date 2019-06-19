//Created  on 2019/6/19 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 *
 */




import Foundation
import Alamofire

public extension CD_Net {
    static func reachability(_ host:String = "www.baidu.com", block:NetworkReachabilityManager.Listener? = nil) -> NetworkReachabilityManager? {
        let manager:NetworkReachabilityManager? = NetworkReachabilityManager(host: host)
        manager?.listener = block
        manager?.startListening()
        return manager
    }
}
