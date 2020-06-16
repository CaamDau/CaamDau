//Created  on 2019/8/2 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 *
 */




import Foundation
import Sign

extension App_Router {
    func utility(_ router:RouterProtocol,
    _ param:RouterParameter = [:],
    _ callback:RouterCallback = nil) {
        /*
        switch router {
        case Router.Utility.http(let url, let title):
            R_Web.push(.http(url), title: title)
        case Router.Utility.html(let html, let title):
            R_Web.push(.html(html), title: title)
        case Router.Utility.file(let url, let title):
            R_Web.push(.file(url), title: title)
        case Router.Utility.pencilDraw:
            
            if let r = NSClassFromString("Home.R_Home") as? RouterInterface.Type {
                r.router(param, callback: callback)
            }
            
            if #available(iOS 13.0, *) {
                PencilDraw.show(UIImage(named: "launchScreen")!)
            } else {
                
            }
        default:
            break
        }
        */
    }
}



extension App_Router {
    func sign(_ router:RouterProtocol,
    _ param:RouterParameter = [:],
    _ callback:RouterCallback = nil) {
        
    }
    
    
    func sign(open url:URL) {
        /// 通过 open url 调起
        switch url.host {
        case "sign":
            var param = url.parameters ?? [:]
            param += [Router.PathKey:url.paths.first ?? ""]
            Router.target("Sign.VC_Sign")?.router(param, callback: { (res) in
            })
        default:
            break
        }
    }
}
