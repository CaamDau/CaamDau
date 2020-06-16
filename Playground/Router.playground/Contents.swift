import UIKit

var str = "Hello, playground"

public protocol CD_RouterProtocol {
    
    func router()
    /// 入参、回参 模糊，自由度更好
    func router(_ param:[AnyHashable:Any]?, callback:(([AnyHashable:Any]?)->Void)?)
}
extension CD_RouterProtocol {
    public func router() {
        router(nil, callback: nil)
    }
    public func router(_ param:[AnyHashable:Any]? = nil, callback:(([AnyHashable:Any]?)->Void)? = nil) {
        CD_Router.shared.routerHandler?(self, param, callback)
        
    }
}


public class CD_Router {
    private init(){}
    public static let shared = CD_Router()
    public var routerHandler:((_ router:CD_RouterProtocol, _ parameter:[AnyHashable:Any]?, _ callback:(([AnyHashable:Any]?)->Void)?)->Void)?
}


enum Router {
    /// 只声明路由模块，路由走统一 CD_Router.shared.routerHandle
    enum Order:CD_RouterProtocol {
        case list
        case detail
        case create
    }
    /// 在声明路由模块, 并同时配置路由
    enum Pay:CD_RouterProtocol {
        case pay
        case payLater
        
        func router(_ param: [AnyHashable : Any]? = nil, callback: (([AnyHashable : Any]?) -> Void)? = nil) {
            print("重写了， 不走 CD_Router.shared.routerHandle")
        }
    }
}
/// 统一路由配置
CD_Router.shared.routerHandler = { (router, parameter, callback) in
    
    switch router {
    case Router.Order.list:
        print(router, "->", parameter)
        callback?(["status":4])
    default:
        print(router, "->", parameter)
    }
    print(router, "->", parameter)
}

Router.Order.list.router(["id":123]) { (p) in
    print(p)
}
Router.Order.detail.router(["id":989], callback: nil)
Router.Pay.pay.router(["order":"KKK78473874837"], callback: nil)
