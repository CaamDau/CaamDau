//Created  on 2019/2/28 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 *
 */




import Foundation
import UIKit

public protocol CDTextProtocol {
    /// T: String、NSAttributedString、UIColor、NSTextAlignment、UIFont、、
    func set<T>(_ t: T?, _ state:UIControl.State?)
}
extension CDTextProtocol {
    /// T: String、NSAttributedString、UIColor、NSTextAlignment、UIFont、、
    func set<T>(_ t: T?, _ state:UIControl.State?){}
}


public extension CD where Base: CDTextProtocol {
    /// T: String、NSAttributedString、UIColor、NSTextAlignment、UIFont、、 state -> button use
    @discardableResult
    public func text<T>(_ t: T?, _ state:UIControl.State? = .normal) -> CD {
        base.set(t, state)
        return self
    }
}

extension UILabel: CDTextProtocol {
    public func set<T>(_ t: T?, _ state:UIControl.State?) {
        switch t {
        case let txt as String:
            self.text = txt
        case let attributed as NSAttributedString:
            self.attributedText = attributed
        case let color as UIColor:
            self.textColor = color
        case let alignment as NSTextAlignment:
            self.textAlignment = alignment
        case let font as UIFont:
            self.font = font
        default:
            break
        }
    }
}

extension UIButton: CDTextProtocol {
    public func set<T>(_ t: T?, _ state:UIControl.State?) {
        switch t {
        case let txt as String:
            self.setTitle(txt, for: state ?? .normal)
        case let attributed as NSAttributedString:
            self.setAttributedTitle(attributed, for: state ?? .normal)
        case let color as UIColor:
            self.setTitleColor(color, for: state ?? .normal)
        case let font as UIFont:
            self.titleLabel?.font = font
        default:
            break
        }
    }
}

extension UITextField: CDTextProtocol {
    public func set<T>(_ t: T?, _ state:UIControl.State?) {
        switch t {
        case let txt as String:
            self.text = txt
        case let attributed as NSAttributedString:
            self.attributedText = attributed
        case let color as UIColor:
            self.textColor = color
        case let alignment as NSTextAlignment:
            self.textAlignment = alignment
        case let font as UIFont:
            self.font = font
        default:
            break
        }
    }
}

extension UITextView: CDTextProtocol {
    public func set<T>(_ t: T?, _ state:UIControl.State?) {
        switch t {
        case let txt as String:
            self.text = txt
        case let attributed as NSAttributedString:
            self.attributedText = attributed
        case let color as UIColor:
            self.textColor = color
        case let alignment as NSTextAlignment:
            self.textAlignment = alignment
        case let font as UIFont:
            self.font = font
        default:
            break
        }
    }
}
