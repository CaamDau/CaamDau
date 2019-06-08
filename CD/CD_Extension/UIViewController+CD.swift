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
    static func cd_storyboard(withBundle from:String? = nil, name:String, id:String = "") -> UIViewController? {
        let identifier = id.isEmpty ? String(describing: self) : id
        let storyboard = UIStoryboard(name: name, bundle: Bundle.cd_bundle(self, from) ?? Bundle.main)
        return storyboard.instantiateViewController(withIdentifier: identifier)
    }
}
