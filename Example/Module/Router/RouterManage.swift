//Created  on 2019/8/2 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 *
 */




import Foundation
import CaamDau

public struct Router {
    
}
//MARK:--- 登录注册 ----------
extension Router {
    public enum Sign: CD_RouterProtocol {
        case up(_ canback:Bool)
        case out
    }
}
//MARK:--- 通用 ----------
extension Router {
    public enum Utility: CD_RouterProtocol {
        case html(_ html:String, _ title:String)
        case http(_ url:String, _ title:String)
        case file(_ url:String, _ title:String)
        case pencilDraw
    }
}

//MARK:--- 通用 ----------
extension Router {
    public enum Map: CD_RouterProtocol {
        case location
        case baidu
    }
}
