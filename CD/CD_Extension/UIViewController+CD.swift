//Created  on 2018/12/11  by LCD :https://github.com/liucaide .

import Foundation
import UIKit
public extension UIViewController{
    enum UIViewControllerError:Error {
        case noBundle
    }
    static func cd_storyboard(name:String = "Main", id:String = "") -> UIViewController {
        let identifier = id == "" ? String(describing: self) : id
        return UIStoryboard(name: name, bundle: nil).instantiateViewController(withIdentifier: identifier)
    }
    
    /// - from:bundle.url(forResource (s.resource_bundles -> key) ; name:storyboard name
    static func cd_storyboardWithBundle(from:String, name:String, id:String = "") -> UIViewController? {
        let identifier = id == "" ? String(describing: self) : id
        let storyboard = UIStoryboard(name: name, bundle: Bundle.cd_bundle(self, from))
        return storyboard.instantiateViewController(withIdentifier: identifier)
    }
}

///获取当前控制器
public func cd_vc() ->UIViewController? {
    var vc = UIApplication.shared.keyWindow?.rootViewController
    
    if (vc?.isKind(of: UITabBarController.self))! {
        vc = (vc as! UITabBarController).selectedViewController
    }else if (vc?.isKind(of: UINavigationController.self))!{
        vc = (vc as! UINavigationController).visibleViewController
    }else if ((vc?.presentedViewController) != nil){
        vc =  vc?.presentedViewController
    }
    
    return vc
}
