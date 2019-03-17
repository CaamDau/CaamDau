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
    func attributedString(_ fgColor:UIColor, bgColor:UIColor?) -> NSAttributedString
    func attributedString(_ attributes:[NSAttributedString.Key : Any]?) -> NSAttributedString
}

extension CD_IconFontProtocol {
    func attributedString(_ fgColor:UIColor, bgColor:UIColor?) -> NSAttributedString {
        var attributes:[NSAttributedString.Key : Any] = [NSAttributedString.Key.font : self.font.fit(), NSAttributedString.Key.foregroundColor : fgColor, NSAttributedString.Key.backgroundColor : bgColor]
        return NSAttributedString(string: self.text, attributes: attributes)
    }
    
    func attributedString(_ attributes:[NSAttributedString.Key : Any]?) -> NSAttributedString {
        return NSAttributedString(string: self.text, attributes: attributes)
    }
}



public extension CD where Base: UILabel {
    @discardableResult
    func iconfont(_ font:CD_IconFontProtocol) -> CD {
        base.font = font.font
        base.text = font.text
        return self
    }
}

public extension CD where Base: UIButton {
    enum CD_IconFontStyle {
        case text(_ state:UIControl.State?)
        case image(_ state:UIControl.State?, color:UIColor?, mode:UIImage.CD_IconFontMode?)
        case bgImage(_ state:UIControl.State?, color:UIColor?, mode:UIImage.CD_IconFontMode?)
    }
    @discardableResult
    func iconfont(_ font:CD_IconFontProtocol, style:CD_IconFontStyle = .text(.normal)) -> CD {
        switch style {
        case let .text(state):
            base.titleLabel?.font = font.font
            base.setTitle(font.text, for: state ?? .normal)
        case let .image(state, color, mode):
            base.contentMode = .center
            base.setImage(UIImage.cd_iconfont(font, color:color ?? base.tintColor, point: (mode ?? .center).point(font.size)), for: state ?? .normal)
        case let .bgImage(state, color, mode):
            base.contentMode = .center
            base.setBackgroundImage(UIImage.cd_iconfont(font, color:color ?? base.tintColor, point: (mode ?? .center).point(font.size)), for: state ?? .normal)
        }
        return self
    }
}

public extension CD where Base: UIImageView {
    @discardableResult
    func iconfont(_ font:CD_IconFontProtocol, color:UIColor = UIColor.lightGray, mode:UIImage.CD_IconFontMode = .center) -> CD {
        base.contentMode = .center
        base.image = UIImage.cd_iconfont(font, color:color, point: mode.point(font.size))
        return self
    }
}

public extension UIImage {
    enum CD_IconFontMode {
        case center
        case top
        case bottom
        case left
        case right
        case topLeft
        case topRight
        case bottomLeft
        case bottomRight
        
        @discardableResult
        public func point(_ size:CGFloat) -> CGPoint {
            switch self {
            case .center:
                //return .zero
                return CGPoint(x: size/2.0, y: size/2.0)
            case .top:
                return CGPoint(x: size/2.0, y: 0)
            case .bottom:
                return CGPoint(x: size/2.0, y: size)
            case .left:
                return CGPoint(x: 0, y: size/2.0)
            case .right:
                return CGPoint(x: size, y: size/2.0)
            case .topLeft:
                return CGPoint(x: 0, y: 0)
            case .topRight:
                return CGPoint(x: size, y: 0)
            case .bottomLeft:
                return CGPoint(x: 0, y: size)
            case .bottomRight:
                return CGPoint(x: size, y: size)
            }
        }
    }
    
    @discardableResult
    static func cd_iconfont(_ font:CD_IconFontProtocol, color:UIColor, point:CGPoint = .zero) -> UIImage {
        let scale = UIScreen.main.scale
        let size = font.size
        UIGraphicsBeginImageContext(CGSize(width: size*scale, height: size*scale))
        //let context = UIGraphicsGetCurrentContext()
        //context!.setFillColor(color.cgColor)
        
        NSString(string: font.text).draw(at: point, withAttributes: [NSAttributedString.Key.font : font.font.fit(), NSAttributedString.Key.foregroundColor:color])
        
        guard let imageCG:CGImage = UIGraphicsGetImageFromCurrentImageContext()?.cgImage  else {
            assertionFailure("👉👉👉CGImage - 失败  👻")
            return UIImage()
        }
        let image = UIImage(cgImage: imageCG, scale: scale, orientation: UIImage.Orientation.up)
        UIGraphicsEndImageContext()
        return image
    }
}
