//Created  on 2019/2/28 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 * 引入这一模块 将会在 Xib Storyboard 操作栏添加响应功能
 */




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
