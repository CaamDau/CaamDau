//Created  on 2018/12/13  by LCD :https://github.com/liucaide .

import Foundation
import UIKit
public extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get { return layer.cornerRadius }
        set { layer.cornerRadius = newValue }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get { return layer.borderWidth }
        set { layer.borderWidth = newValue }
    }
    
    @IBInspectable var borderColor: UIColor {
        get { return UIColor(cgColor: layer.borderColor ?? UIColor.clear.cgColor) }
        set { layer.borderColor = newValue.cgColor }
    }
}


public extension CD where Base: UIView{
    func vc() -> UIViewController? {
        var next:UIResponder? = base
        repeat {
            next = next?.next
            if let vc = next as? UIViewController {
                return vc
            }
        }while next != nil
        return nil
    }
}


extension UIView{
    
}

