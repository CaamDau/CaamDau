//Created  on 2018/12/13  by LCD :https://github.com/liucaide .

import Foundation
import UIKit

public extension CaamDau where Base: UIImage {
    
}

//MARK:--- pod 资源图片 ----------
public extension UIImage{
    ///- forClass:class  from: pod resource_bundles key
    ///- from:bundle.url(forResource ‘(pod s.resource_bundles -> key)’
    static func cd_podImg(name:String, forClass:AnyClass, from:String = "") -> UIImage {
        let fromPod = from.isEmpty ? String(describing: forClass) : from
        return UIImage(named: name, in: Bundle.cd_bundle(forClass, fromPod), compatibleWith: nil) ?? UIImage()
    }
    
    
}


