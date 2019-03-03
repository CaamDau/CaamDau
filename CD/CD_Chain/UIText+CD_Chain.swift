//Created  on 2019/2/28 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 *
 */

import Foundation
import UIKit

public extension CD where Base: UITextField {
    @discardableResult
    func placeholder(_ p: String? = nil) -> CD {
        base.placeholder = p
        return self
    }
    @discardableResult
    func placeholder(_ attributed: NSAttributedString? = nil) -> CD {
        base.attributedPlaceholder = attributed
        return self
    }
    @discardableResult
    func border(_ style:UITextField.BorderStyle) -> CD {
        base.borderStyle = style
        return self
    }
    @discardableResult
    func text(default attributes:[NSAttributedString.Key : Any]) -> CD {
        base.defaultTextAttributes = attributes
        return self
    }
    @discardableResult
    func clear(onBeginEditing b:Bool) -> CD {
        base.clearsOnBeginEditing = b
        return self
    }
    
    @discardableResult
    func clear(buttonMode b:UITextField.ViewMode) -> CD {
        base.clearButtonMode = b
        return self
    }
    
    @discardableResult
    func adjusts(_ fontSizeToFitWidth:Bool) -> CD {
        base.adjustsFontSizeToFitWidth = fontSizeToFitWidth
        return self
    }
    @discardableResult
    func minimumFont(_ size:CGFloat) -> CD {
        base.minimumFontSize = size
        return self
    }
    @discardableResult
    func delegate(_ d:UITextFieldDelegate? = nil) -> CD {
        base.delegate = d
        return self
    }
    @discardableResult
    func background(_ img:UIImage? = nil) -> CD {
        base.background = img
        return self
    }
    @discardableResult
    func disabledBackground(_ img:UIImage? = nil) -> CD {
        base.disabledBackground = img
        return self
    }
    @discardableResult
    func allows(editingTextAttributes b:Bool) -> CD {
        base.allowsEditingTextAttributes = b
        return self
    }
    @discardableResult
    func typing(attributes b:[NSAttributedString.Key : Any]) -> CD {
        base.typingAttributes = b
        return self
    }
    
    @discardableResult
    func left(view v:UIView) -> CD {
        base.leftView = v
        return self
    }
    @discardableResult
    func left(viewMode v:UITextField.ViewMode) -> CD {
        base.leftViewMode = v
        return self
    }
    @discardableResult
    func right(view v:UIView) -> CD {
        base.rightView = v
        return self
    }
    @discardableResult
    func right(viewMode v:UITextField.ViewMode) -> CD {
        base.rightViewMode = v
        return self
    }
}



public extension CD where Base: UITextView {
}
