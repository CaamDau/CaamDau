//Created  on 2019/2/15 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 * IconFont 协议 和链式调用
 */


import Foundation
import UIKit


public protocol CD_IconFontProtocol{
    var size:CGFloat { get }
    var text:String { get }
    var font:UIFont { get }
    var attributedString:NSAttributedString { get }
    
    func attributedString(withColor fg:UIColor) -> NSAttributedString
    func attributedString(withColor fg:UIColor, bg:UIColor?) -> NSAttributedString
    func attributedString(withAttributes a:[NSAttributedString.Key : Any]?) -> NSAttributedString
}

public extension CD_IconFontProtocol {
    var attributedString:NSAttributedString {
        return self.attributedString(withAttributes:nil)
    }
    
    func attributedString(withColor fg:UIColor) -> NSAttributedString {
        return self.attributedString(withColor:fg, bg: nil)
    }
    
    func attributedString(withColor fg:UIColor, bg:UIColor?) -> NSAttributedString {
        var attributes:[NSAttributedString.Key : Any] = [NSAttributedString.Key.foregroundColor : fg]
        if (bg != nil) {
            attributes += [NSAttributedString.Key.backgroundColor : bg!]
        }
        return self.attributedString(withAttributes:attributes)
    }
    func attributedString(withAttributes a:[NSAttributedString.Key : Any]?) -> NSAttributedString {
        var attributes = a ?? [:]
        attributes[NSAttributedString.Key.font] = self.font
        return NSAttributedString(string: self.text, attributes: attributes)
    }
}



public extension CaamDau where Base: UILabel {
    @discardableResult
    func iconfont(_ font:CD_IconFontProtocol) -> CaamDau {
        base.font = font.font
        base.text = font.text
        return self
    }
}

public extension CaamDau where Base: UIButton {
    enum CD_IconFontStyle {
        case text(_ state:UIControl.State?)
        case image(_ state:UIControl.State?, color:UIColor?)
        case bgImage(_ state:UIControl.State?, color:UIColor?)
    }
    @discardableResult
    func iconfont(_ font:CD_IconFontProtocol, style:CD_IconFontStyle = .text(.normal)) -> CaamDau {
        switch style {
        case let .text(state):
            base.titleLabel?.font = font.font
            base.setTitle(font.text, for: state ?? .normal)
        case let .image(state, color):
            base.setImage(UIImage.cd_iconfont(font, color:color ?? base.tintColor), for: state ?? .normal)
        case let .bgImage(state, color):
            base.setBackgroundImage(UIImage.cd_iconfont(font, color:color ?? base.tintColor), for: state ?? .normal)
        }
        return self
    }
}

public extension CaamDau where Base: UIImageView {
    @discardableResult
    func iconfont(_ font:CD_IconFontProtocol, color:UIColor = UIColor.lightGray) -> CaamDau {
        base.image = UIImage.cd_iconfont(font, color:color)
        return self
    }
}

public extension UIImage {
    @discardableResult
    static func cd_iconfont(_ font:CD_IconFontProtocol, color:UIColor, point:CGPoint = .zero) -> UIImage {
        let scale = UIScreen.main.scale
        let size = font.size
        UIGraphicsBeginImageContextWithOptions(CGSize(width: size, height: size),false,0)
        NSString(string: font.text).draw(at: point, withAttributes: [NSAttributedString.Key.font : font.font.cd_fit(), NSAttributedString.Key.foregroundColor:color])
        
        guard let imageCG:CGImage = UIGraphicsGetImageFromCurrentImageContext()?.cgImage  else {
            assertionFailure("👉👉👉CGImage - 失败  👻")
            return UIImage()
        }
        let image = UIImage(cgImage: imageCG, scale: scale, orientation: UIImage.Orientation.up)
        UIGraphicsEndImageContext()
        return image
    }
}
