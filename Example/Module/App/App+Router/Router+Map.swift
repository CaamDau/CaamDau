//Created  on 2019/8/2 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 *
 */




import Foundation
//import Map

extension App_Router {
    func map(_ router:CD_RouterProtocol,
    _ param:CD_RouterParameter = [:],
    _ callback:CD_RouterCallback = nil) {
        
        switch router {
        case Router.Map.location:
            break//R_LocationSys.router(param, callback: callback)
        default:
            break
        }
        
    }
}
