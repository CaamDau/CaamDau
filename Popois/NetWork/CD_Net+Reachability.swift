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


public extension CD_Net {
    static func massageFor(_ code:Int) -> String? {
        switch code {
        case -88888:
            return "服务器错误"
        case 404:
            return "服务器错误"
        case -1:
            return "未知错误"
        case -999:
            return "网络请求取消"
        case -1000:
            return "URL错误"
        case -1001:
            return "请求超时"
        case -1003:
            return "无法找到服务器"
        case -1004:
            return "无法连接服务器"
        case -1005:
            return "网络连接丢失"
        case -1008:
            return "资源不可用"
        case -1008:
            return "您可能没有连接互联网"
        case -1011:
            return "服务器响应错误"
        case -1015, -1016:
            return "解码失败"
        case -1017:
            return "无法解析"
        case -1100:
            return "资源不存在"
        case -1101:
            return "资源目录错误"
        case -1102:
            return "没有权限读取资源"
        default:
            return nil
        }
    }
}
