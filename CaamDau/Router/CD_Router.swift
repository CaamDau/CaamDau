//Created  on 2018/7/15  by LCD :https://github.com/liucaide .

/***** 模块文档 *****
 * 提供一个路由协议
 * 自定义一个路由管理器，遵循此协议
 * 举个栗子:
*
/// 组件化 声明路由表， 遵循 CD_RouterProtocol 协议
/// 这个时候，在单一组件中只需引用路由表，不需要引用所要路由的页面，
/// 路由管理器，组员自行维护，使用枚举，更便于管理，或可进行参数强关联，可传递任意参数
enum Router {
    /// 组员A开发Order 模块，
    /// 只声明路由模块，路由走统一 CD_Router.shared.routerHandle 配置
    enum Order:CD_RouterProtocol {
        case list
        case detail
        case create(_ id:String) // 参数强关联，需求变更后，同时所有调用者知晓变更
    }
 
    /// 组员B 开发Pay 模块，
    /// 声明路由模块, 并同时配置路由
    enum Pay:CD_RouterProtocol {
        case pay
        case payLater
        
        func router(_ param: [AnyHashable : Any]? = nil, callback: (([AnyHashable : Any]?) -> Void)? = nil) {
            print("重写了， 不走 CD_Router.shared.routerHandle")
        }
    }
}

/// 统一路由配置，在主工程中配置，或者作为页面路由组件 在主工程导入即可
CD_Router.shared.routerHandle = { (t, p) -> [AnyHashable:Any]? in
    switch t {
    case Router.Order.list:
        print(t, "->", p)
        return ["status":4]
    default:
        print(t, "->", p)
    }
    print(t, "->", p)
    return nil
}

Router.Order.list.router(["id":123]) { (p) in
    print(p)
}
Router.Order.detail.router(["id":989], callback: nil)
Router.Pay.pay.router(["order":"KKK78473874837"], callback: nil)

*/

import Foundation
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
