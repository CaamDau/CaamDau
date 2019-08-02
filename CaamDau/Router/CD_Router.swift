//Created  on 2018/7/15  by LCD :https://github.com/liucaide .

/***** 模块文档 *****
 * 提供一个路由协议
 * 自定义一个路由管理器，遵循此协议
 * 举个栗子:
 
func test() {
    ///
    CD_Router.CD.t商品详情(id: "") { }.router()
}
extension CD_Router {
    // 路由管理器，组员自行维护，使用枚举可进行参数强关联，可传递任意参数
    // 一旦需求变动，需要维护路由，可同时知晓需要修改的其他地方
    enum CD { //组员 CD 开发的页面
        case t商品详情(id:String, callback:(()->Void)?)
    }
    enum ZS { //组员 ZS 开发的页面
        case t订单详情(id:String, callback:(()->Void)?)
    }
    enum LS { //组员 LS 开发的页面
        case t结算(id:String, callback:(()->Void)?)
    }
}
extension CD_Router.CD: CD_RouterProtocol {
    // 每个组员自己开发的页面自己管理路由
    func router() {
        switch self {
        case let .t商品详情(id, callback):
            R_Detail.push(id, callback:callback)
        default:
            break
        }
    }
}
/// 详情页面 只暴露路由方法
public struct R_Detail {
    static func push(_ id:String, callback:(()->Void)?) {
        let vc = VC_Detail()
        vc.id = id
        vc.callback = callback
        CD.push(vc)
    }
}
/// 详情页面 不暴露任何内容
class VC_Detail: UIViewController {
    var id:String?, callback:(()->Void)?
}
*/


import Foundation
public protocol CD_RouterProtocol {
    
    func router()
    /// 入参、回参 模糊，自由度更好
    func router(_ param:[AnyHashable:Any]?, callback:(([AnyHashable:Any])->Void)?)
}
extension CD_RouterProtocol {
    public func router() {
        router(nil, callback: nil)
    }
    public func router(_ param:[AnyHashable:Any]? = nil, callback:(([AnyHashable:Any])->Void)? = nil) {
    }
}


public enum CD_Router {
    
}


