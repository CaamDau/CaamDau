//Created  on 2019/8/2 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 *
 */




import Foundation
import CaamDau

func test(_ scheme:String, path:String) {
    switch scheme {
    case "sign":
        Router.Sign(rawValue: path)?.router([:], callback: { (res) in
            
        })
    default:
        break
    }
}


extension Router {
    /// 同一页面 不同模式、状态、类型，进行区分
    public static let PathKey = "router_path"
    
}


//MARK:--- 登录注册 ----------
extension Router {
    public enum Sign:String, RouterProtocol {
        case up = "up"
        case out = "out"
        
        public var parameter: RouterParameter {
            return [Router.PathKey:self.rawValue]
        }
        
        public var target: String? {
            return "Sign.VC_Sign"
        }
    }
}
//MARK:--- 通用 ----------
extension Router {
    public enum Utility:String, RouterProtocol {
        case html = "html"
        case http = "http"
        case file = "file"
        case pencilDraw = "pencildraw"
        
        public var parameter: RouterParameter {
            return [Router.PathKey:self.rawValue]
        }
        public var target: String? {
            switch self {
            case .pencilDraw:
                return nil
            default:
                return "Utility.VC_Web"
            }
            
        }
    }
}

//MARK:--- 通用 ----------
extension Router {
    public enum Map:String, RouterProtocol {
        case location = "location"
        case baidu = "baidu"
    }
}
