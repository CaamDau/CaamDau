//Created  on 2019/8/2 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 *
 */




import Foundation


extension App_Router {
    func map(_ router:RouterProtocol,
    _ param:RouterParameter = [:],
    _ callback:RouterCallback = nil) {
        
        switch router {
        case Router.Map.location:
            break//R_LocationSys.router(param, callback: callback)
        default:
            break
        }
        
    }
}
