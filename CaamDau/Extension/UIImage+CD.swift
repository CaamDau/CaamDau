//Created  on 2018/12/13  by LCD :https://github.com/liucaide .

import Foundation
import UIKit

public extension CaamDau where Base: UIImage {
    
}

//MARK:--- pod 资源图片 ----------
public extension UIImage{
    ///- forClass:class  from: pod resource_bundles key
    ///- from:bundle.url(forResource ‘(pod s.resource_bundles -> key)’
    static func cd_bundle(_ name:String, dark:String? = nil, forClass:AnyClass, from:String = "") -> UIImage {
        let from = from.isEmpty ? String(describing: forClass) : from
        guard #available(iOS 13.0, *), let dark = dark else {
            return UIImage(named: name, in: Bundle.cd_bundle(forClass, from), compatibleWith: nil) ?? UIImage()
        }
        switch UITraitCollection.current.userInterfaceStyle {
        case .dark:
            return UIImage(named: dark, in: Bundle.cd_bundle(forClass, from), compatibleWith: nil) ?? UIImage(named: name, in: Bundle.cd_bundle(forClass, from), compatibleWith: nil) ?? UIImage()
        default:
            return UIImage(named: name, in: Bundle.cd_bundle(forClass, from), compatibleWith: nil) ?? UIImage()
        }
    }
    
    static func cd_bundle(_ name:String, forClass:AnyClass, from:String = "") -> UIImage? {
        let from = from.isEmpty ? String(describing: forClass) : from
        return UIImage(named: name, in: Bundle.cd_bundle(forClass, from), compatibleWith: nil)
    }
    
    /// - 由颜色 生成图片
    static func cd_color(_ color: UIColor) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img!
    }
}


