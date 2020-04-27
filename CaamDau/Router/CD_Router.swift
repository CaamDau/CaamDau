//Created  on 2018/7/15  by LCD :https://github.com/liucaide .

/***** 模块文档 *****
 * 提供一个路由协议
 * 自定义一个路由管理器，遵循此协议
 * 举个栗子:
*

public struct R_OrderSubmit:CD_RouterInterface {
    public static func router(_ param: CD_RouterParameter, callback: CD_RouterCallback) {
        let vc = VC_OrderSubmit()
        vc.carId = param.stringValue("carId")
        CD.push(vc)
    }
}
class VC_OrderSubmit: UIViewController {
    var carId = ""
}
class VC_OrderList: UIViewController {}
extension VC_OrderList: CD_RouterInterface {
    static func router(_ param: CD_RouterParameter, callback: CD_RouterCallback) {
        let vc = VC_OrderList()
        CD.push(vc)
    }
}

/// 组件化 声明路由表， 遵循 CD_RouterProtocol 协议
/// 这个时候，在单一组件中只需引用路由表，不需要引用所要路由的页面，
/// 路由管理器，组员自行维护，使用枚举，更便于管理，或可进行参数强关联，可传递任意参数
enum Router {
    /// 组员A开发Order 模块，
    /// 只声明路由模块，路由走统一 CD_Router.shared.routerHandle 配置
    enum Order: CD_RouterProtocol {
        var target: String {
            switch self {
            case .list:
                return "VC_OrderList"
            default:
                return ""
            }
        }
        var parameter: CD_RouterParameter {
            switch self {
            case .detail(let id):
                return ["id":id]
            default:
                return [:]
            }
        }
 *
        case list
        case submit
        case detail(_ id:String) // 参数强关联，需求变更后，同时所有调用者知晓变更, 此时需要
    }
    /// 组员B 开发Pay 模块，
    /// 声明路由模块, 并同时配置路由
    enum Pay:CD_RouterProtocol {
        case pay
        
        /// 模式3：
        func router(_ param: CD_RouterParameter = [:], callback: CD_RouterCallback = nil) {
            print("重写了")
        }
    }
}
/// 模式1：协议内默认通道
/// --> CD_RouterProtocol 。。。

/// 模式2：单例通道
CD_Router.shared.routerHandler = { (r, param, callback) in
    switch r {
    case Router.Order.submit:
        R_OrderSubmit.router(r, param, callback)
    default:
        break
    }
}

 /// 模式3：open url 通道 走 application open url
 switch url.host {
 case "order" where url.path.first? == "submit":
     CD.router(target: "Order.VC_OrderSubmit")?.router(url.parameters, callback: { (res) in
     })
 default:
     break
 }

/// 调用
Router.Order.list.router()
Router.Order.submit.router(["carId":999]) { (res) in
    //.....
}
Router.Order.detail("123").router()
Router.Pay.pay.router(["123":456, 7:888])
 
 
CD_Router.open(url: "caamdau://order/submit", param:  ["id":999])
*/


import Foundation


public typealias CD_RouterParameter = [AnyHashable:Any]
public typealias CD_RouterCallback = ((CD_RouterParameter?)->Void)?

/// 输入协议：路由表协议
public protocol CD_RouterProtocol {
    /// 目标 如："Home.R_Home" (Home: 模块、组件 命名空间，R_Home：接口类)
    var target:String? {get}
    /// 增补固定参数
    var parameter:CD_RouterParameter {get}
    /// 入参、回参 模糊，自由度更好
    func router(_ param:CD_RouterParameter, callback:CD_RouterCallback)
}
extension CD_RouterProtocol {
    /// 目标 如："Home.R_Home" (Home: 模块、组件 命名空间，R_Home：接口类)
    public var target:String? { return nil }
    public var parameter:CD_RouterParameter { return [:] }
    
    /// 入参、回参 模糊，自由度更好
    public func router(_ param:CD_RouterParameter = [:], callback:CD_RouterCallback = nil) {
        self.routerCore(param, callback: callback)
    }
    
    public func routerCore(_ param:CD_RouterParameter, callback:CD_RouterCallback) {
        if  let target = target, let r = CD_Router.target(target) {
            var param = param
            param += parameter
            r.router(param, callback: callback)
        }else{
            var param = param
            param += parameter
            CD_Router.shared.routerHandler?(self, param, callback)
        }
    }
}

@objc public class CD_Router: NSObject {
    private override init(){}
    public static let shared = CD_Router()
    public var routerHandler:((_ router:CD_RouterProtocol, _ parameter:CD_RouterParameter, _ callback:CD_RouterCallback)->Void)?
}

extension CD_Router {
    /// 直接通过 URL 配合 application open url 进行寻址
    @objc public class func open(url string:String, param:CD_RouterParameter = [:]) {
        guard let urlComponents = NSURLComponents(string: string) else {
            print_cd("CD_Router withURL string error:", string)
            return
        }
        var items:[URLQueryItem] = []
        param.forEach {
            guard let key = $0.key as? String, let value = $0.value as? String else { return }
            items.append(URLQueryItem(name: key, value: value))
        }
        urlComponents.queryItems = items
        
        guard var url = urlComponents.url else {
            print_cd("CD_Router withURL error:", urlComponents)
            return
        }
        
        
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
}


/// 对外接口路由协议 用于直接页面开放接口路由： ViewController.router([:], callback:{_ in })
public protocol CD_RouterInterface {
    static func router(_ param:CD_RouterParameter, callback:CD_RouterCallback)
}


extension CD_Router {
    public static func target(_ string:String) -> CD_RouterInterface.Type? {
        return NSClassFromString(string) as? CD_RouterInterface.Type
    }
}
