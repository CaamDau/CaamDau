//Created  on 2019/2/28 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 * 引入这一模块 将会在 Xib Storyboard 操作栏添加响应功能
 */




import Foundation
import UIKit

//@IBDesignable
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
    
    /*
    @IBInspectable var bgColor: String {
        get { return backgroundColor!.cd_hex }
        set { backgroundColor = UIColor.cd_hex(newValue) }
    }
    @IBInspectable var bgColorAlpha: CGFloat {
        get { return backgroundColor!.cd_alpha }
        set { backgroundColor!.withAlphaComponent(newValue)}
    }*/
}
/*
public extension UILabel {
    @IBInspectable var txtColor: String {
        get { return self.textColor.cd_hex }
        set { textColor = UIColor.cd_hex(newValue) }
    }
    @IBInspectable var txtColorAlpha: CGFloat {
        get { return self.textColor.cd_alpha }
        set { textColor.withAlphaComponent(newValue) }
    }
}


public extension UIButton {
    @IBInspectable var titleColor: String {
        get { return self.titleColor(for: self.state)!.cd_hex }
        set { self.setTitleColor(UIColor.cd_hex(newValue), for: self.state) }
    }
    @IBInspectable var txtColorAlpha: CGFloat {
        get { return self.titleColor(for: self.state)!.cd_alpha }
        set { self.setTitleColor(self.titleColor(for: self.state)!.withAlphaComponent(newValue), for: self.state) }
    }
}
*/
