//Created  on 2019/8/2 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 *
 */




import Foundation
import Sign

extension App_Router {
    func utility(_ router:CD_RouterProtocol,
    _ param:CD_RouterParameter = [:],
    _ callback:CD_RouterCallback = nil) {
        
        switch router {
        case Router.Utility.http(let url, let title):
            R_Web.push(.http(url), title: title)
        case Router.Utility.html(let html, let title):
            R_Web.push(.html(html), title: title)
        case Router.Utility.file(let url, let title):
            R_Web.push(.file(url), title: title)
        case Router.Utility.pencilDraw:
            if #available(iOS 13.0, *) {
                CD_PencilDraw.show(UIImage(named: "launchScreen")!)
            } else {
                
            }
        default:
            break
        }
        
    }
}



extension App_Router {
    func sign(_ router:CD_RouterProtocol,
    _ param:CD_RouterParameter = [:],
    _ callback:CD_RouterCallback = nil) {
        
        switch router {
        case Router.Sign.up(let back):
            R_Sign.isSignUp(back)
        case Router.Sign.out:
            break
        default:
            break
        }
        
    }
}
