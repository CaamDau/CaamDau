//Created  on 2018/12/11  by LCD :https://github.com/liucaide .

import Foundation
import UIKit
public extension UIViewController{
    enum UIViewControllerError:Error {
        case noBundle
    }
    class func cd_storyboard(name:String = "Main", id:String = "") -> UIViewController {
        let identifier = id == "" ? String(describing: self) : id
        return UIStoryboard(name: name, bundle: nil).instantiateViewController(withIdentifier: identifier)
        
    }
    /// - from:bundle.url(forResource ; name:storyboard name
    class func cd_storyboard(from:String, name:String, id:String = "") -> UIViewController? {
        
        let podBundle = Bundle(for: VC_Find.self)
        
        let bundleURL = podBundle.url(forResource: from, withExtension: "bundle")
        let bundle = Bundle(url: bundleURL!)!
        let storyboard = UIStoryboard(name: name, bundle: bundle)
        return storyboard.instantiateInitialViewController()
        
        
    }
    
    class func cd_storyboardWithBundle(from:String, name:String, id:String = "") -> UIViewController? {
        
        let podBundle = Bundle(for: VC_Find.self)
        
        let bundleURL = podBundle.url(forResource: "CD", withExtension: "bundle")
        let bundle = Bundle(url: bundleURL!)!
        let storyboard = UIStoryboard(name: "FindStoryboard", bundle: bundle)
        let vc = storyboard.instantiateInitialViewController()!

        return vc
        
        /*
        let bundle = Bundle(for: self)
        guard let bundleURL = bundle.url(forResource: from, withExtension: "bundle") else {
            assertionFailure("👉👉👉\(from) - 无法找到 Bundle👈👈👈")
            return nil
        }
        let bundle2 = Bundle(url: bundleURL)
        let storyboard = UIStoryboard(name: name, bundle: bundle2)
        return storyboard.instantiateInitialViewController()!
        */
        
        
        
//        guard let vc = storyboard.instantiateInitialViewController() else {
//            assertionFailure("👉👉👉\(name)中检索\(String(describing: self))失败👈👈👈")
//            return nil
//        }
//        return vc
        /*
        let storyboard = UIStoryboard(name: name, bundle: cd_bundle(forClass:self, from))
        guard let vc = storyboard.instantiateInitialViewController() else {
            assertionFailure("👉👉👉\(name)中检索\(String(describing: self))失败👈👈👈")
            return nil
        }
        let identifier = id == "" ? String(describing: self) : id
        return storyboard.instantiateViewController(withIdentifier: identifier)*/
    }
    
    class func cd_storyboardBundle(forClass:AnyClass, name:String) -> UIViewController?{
        let podBundle = Bundle(for: forClass)
        guard let bundleURL = podBundle.url(forResource: "CD", withExtension: "bundle") else {
            assertionFailure("👉👉👉\(forClass) - 无法找到 Bundle👈👈👈")
            return nil
        }
        let bundle = Bundle(url: bundleURL)
        
        let storyboard = UIStoryboard(name: name, bundle: bundle)
        let vc = storyboard.instantiateInitialViewController()!
        return vc
    }
}

public func cd_bundle(forClass:AnyClass, _ from:String) -> Bundle? {
    let bundle = Bundle(for: forClass)
    guard let bundleURL = bundle.url(forResource: from, withExtension: "bundle") else {
        assertionFailure("👉👉👉\(from) - 无法找到 Bundle👈👈👈")
        return nil
    }
    return Bundle(url: bundleURL)
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
