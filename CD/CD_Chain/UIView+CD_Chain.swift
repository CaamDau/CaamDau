//Created  on 2018/12/11  by LCD :https://github.com/liucaide .

import Foundation
import UIKit

public protocol CDViewProtocol {
    /// T: UIView、UIGestureRecognizer、NSLayoutConstraint、[NSLayoutConstraint]、、
    func addT<T>(_ t: T?)
}
extension CDViewProtocol {
    func addT<T>(_ t: T?){}
}

public extension CD where Base: CDViewProtocol {
    @discardableResult
    public func add<T>(_ t: T?) -> CD {
        base.addT(t)
        return self
    }
}

extension UIView: CDViewProtocol {
    public func addT<T>(_ t: T?) {
        switch t {
        case let subview as UIView :
            self.addSubview(subview)
        case let ges as UIGestureRecognizer :
            self.addGestureRecognizer(ges)
        case let lay as NSLayoutConstraint :
            self.addConstraint(lay)
        case let lays as [NSLayoutConstraint] :
            self.addConstraints(lays)
        default:
            break
        }
    }
}


public extension CD where Base: UIView {
    @discardableResult
    func frame(_ a: CGRect) -> CD {
        base.frame = a
        return self
    }
    @discardableResult
    func frame(x: CGFloat = 0, y: CGFloat = 0, w: CGFloat = 0, h: CGFloat = 0) -> CD {
        base.frame = CGRect(x: x, y: y, width: w, height: h)
        return self
    }
    @discardableResult
    func bounds(_ a: CGRect) -> CD {
        base.bounds = a
        return self
    }
    @discardableResult
    func bounds(w: CGFloat = 0, h: CGFloat = 0) -> CD {
        base.bounds = CGRect(x: 0, y: 0, width: w, height: h)
        return self
    }
    
    @discardableResult
    func center(_ a: CGPoint) -> CD {
        base.center = a
        return self
    }
    
    @discardableResult
    func center(x: CGFloat = 0, y: CGFloat = 0) -> CD {
        base.center = CGPoint(x: x, y: y)
        return self
    }
    @discardableResult
    func tag(_ a: Int) -> CD {
        base.tag = a
        return self
    }
    @discardableResult
    func background(_ color: UIColor) -> CD {
        base.backgroundColor = color
        return self
    }
    
    @discardableResult
    func alpha(_ a: CGFloat) -> CD {
        base.alpha = a
        return self
    }
    
    @discardableResult
    func content(_ mode: UIView.ContentMode) -> CD {
        base.contentMode = mode
        return self
    }
    
    @discardableResult
    func isHidden(_ a: Bool) -> CD {
        base.isHidden = a
        return self
    }
    
    @discardableResult
    func isOpaque(_ a: Bool) -> CD {
        base.isOpaque = a
        return self
    }
    
    @discardableResult
    func isUser(_ interactionEnabled: Bool) -> CD {
        base.isUserInteractionEnabled = interactionEnabled
        return self
    }
    
    @discardableResult
    func tint(_ color: UIColor) -> CD {
        base.tintColor = color
        return self
    }
    
    @discardableResult
    func corner(_ radius: CGFloat) -> CD {
        base.layer.cornerRadius = radius
        return self
    }
    
    @discardableResult
    func clips(_ toBounds: Bool) -> CD {
        base.clipsToBounds = toBounds
        return self
    }
    
    @discardableResult
    func corner(_ radius:CGFloat, clips: Bool = true) -> CD {
        base.layer.cornerRadius = radius
        base.clipsToBounds = clips
        return self
    }
    
    @discardableResult
    func masks(_ toBounds: Bool) -> CD {
        base.layer.masksToBounds = toBounds
        return self
    }
    
    @discardableResult
    func border(_ width: CGFloat) -> CD {
        base.layer.borderWidth = width
        return self
    }
    
    @discardableResult
    func border(_ color: UIColor) -> CD {
        base.layer.borderColor = color.cgColor
        return self
    }
    
    @discardableResult
    func border(_ width:CGFloat, color: UIColor) -> CD {
        base.layer.borderWidth = width
        base.layer.borderColor = color.cgColor
        return self
    }
    
    
    @discardableResult
    func shadow(_ color: UIColor) -> CD {
        base.layer.shadowColor = color.cgColor
        return self
    }
    
    @discardableResult
    func shadow(_ opacity: Float) -> CD {
        base.layer.shadowOpacity = opacity
        return self
    }
    
    @discardableResult
    func shadow(_ offset: CGSize) -> CD {
        base.layer.shadowOffset = offset
        return self
    }
    
    @discardableResult
    func shadow( w:CGFloat = 0, h:CGFloat = 0) -> CD {
        base.layer.shadowOffset = CGSize(width: w, height: h)
        return self
    }
    
    @discardableResult
    func shadow(_ radius: CGFloat) -> CD {
        base.layer.shadowRadius = radius
        return self
    }
    
    @discardableResult
    func shadow(_ path: CGPath?) -> CD {
        base.layer.shadowPath = path
        return self
    }
    /// 阴影
    @discardableResult
    func shadow(color: UIColor, opacity: Float, offset: CGSize, radius: CGFloat) -> CD {
        base.layer.shadowColor = color.cgColor
        base.layer.shadowOffset = offset
        base.layer.shadowOpacity = opacity
        base.layer.shadowRadius = radius
        return self
    }
    /// 变形属性(平移\缩放\旋转)
    @discardableResult
    func transform(_ a: CGAffineTransform) -> CD {
        base.transform = a
        return self
    }
    /// 自动调整子视图尺寸，默认YES则会根据autoresizingMask属性自动调整子视图尺寸
    @discardableResult
    func autoresizes(_ subviews: Bool) -> CD {
        base.autoresizesSubviews = subviews
        return self
    }
    /// 自动调整子视图与父视图的位置，默认UIViewAutoresizingNone
    @discardableResult
    func autoresizing(_ mask: UIView.AutoresizingMask) -> CD {
        base.autoresizingMask = mask
        return self
    }
    
    /// 圆角
    @discardableResult
    func rounded(_ corners:UIRectCorner, _ radii:CGSize) -> CD {
        return self.rounded(base.bounds, corners, radii)
    }
    
    /// 圆角
    @discardableResult
    func rounded(_ rect:CGRect, _ corners:UIRectCorner, _ radii:CGSize) -> CD {
        let rounded = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: radii)
        let shape = CAShapeLayer()
        shape.path = rounded.cgPath
        base.layer.mask = shape
        return self
    }
    
    /// 背景线性渐变 默认横向渐变 point -> 0 - 1
    /// let gradients:[(UIColor,Float)] = [(UIColor.red,0),(UIColor.yellow,1)]
    /// view.cd.gradient(layer: gradients)
    @discardableResult
    func gradient(layerAxial gradients:[(color:UIColor,location:Float)], point:(start:CGPoint, end:CGPoint) = (start:CGPoint(x: 0, y: 0), end:CGPoint(x: 1, y: 0)), at: UInt32 = 0, updateIndex:Int? = nil) -> CD {
        
        func gradient(_ layer:CAGradientLayer) {
            base.layoutIfNeeded()
            layer.colors = gradients.map{$0.color.cgColor}
            layer.locations = gradients.map{NSNumber(value:$0.location)}
            layer.startPoint = point.start
            layer.endPoint = point.end
            layer.frame = base.bounds
        }
        
        let layers:[CAGradientLayer] = base.layer.sublayers?.filter{$0.isKind(of: CAGradientLayer.self)}.map{$0} as? [CAGradientLayer] ?? []
        if layers.count <= at {
            let layer = CAGradientLayer()
            gradient(layer)
            base.layer.insertSublayer(layer, at: at)
        }else{
            gradient(layers[updateIndex ?? 0])
        }
        return self
    }
    /// 放射性渐变
    private class CD_GradientLayer:CALayer {
        var point: CGPoint = CGPoint.zero
        var colorSpace = CGColorSpaceCreateDeviceRGB()
        var locations:[CGFloat] = [0.0, 1.0]
        var colors:[CGFloat] = [0.0,0.0,0.0,0.0,0.0,0.0,0.0,1.0]
        lazy var radius: CGFloat = {
            return max(self.bounds.size.width, self.bounds.size.height)
        }()
        override func draw(in ctx: CGContext) {
            guard let gradient = CGGradient(colorSpace: colorSpace, colorComponents: colors, locations: locations, count: locations.count) else {
                return
            }
            ctx.drawRadialGradient(gradient, startCenter: point, startRadius: 0, endCenter: point, endRadius: radius, options: .drawsAfterEndLocation)
        }
    }
    /// 背景放射性渐变
    @discardableResult
    func gradient(layerRadial gradients:[(color:UIColor,location:CGFloat)], point:CGPoint = CGPoint(x: 0, y: 0), radius:CGFloat? = nil, at: UInt32 = 0, updateIndex:Int? = nil) -> CD {
        
        func gradient(_ layer:CD_GradientLayer) {
            base.layoutIfNeeded()
            layer.locations = gradients.map{$0.location}
            layer.colors =  Array(gradients.map({ (c) -> [CGFloat] in
                let cc = c.color.cd_rgba
                return [cc.0,cc.1,cc.2,cc.3]
            }).joined())
            layer.frame = base.bounds
            layer.point = point
            layer.radius = radius ?? max(base.bounds.size.width, base.bounds.size.height)
            layer.setNeedsDisplay()
        }
        
        let layers:[CD_GradientLayer] = base.layer.sublayers?.filter{$0.isKind(of: CD_GradientLayer.self)}.map{$0} as? [CD_GradientLayer] ?? []
        if layers.count <= at {
            let layer = CD_GradientLayer()
            gradient(layer)
            base.layer.insertSublayer(layer, at: at)
        }else{
            gradient(layers[updateIndex ?? 0])
        }
        return self
    }
    
    /// 毛玻璃效果 view.blurEffect(UIColor.red.withAlphaComponent(0.5))
    @discardableResult
    func blurEffect(_ color:UIColor = UIColor.clear,  style:UIBlurEffect.Style = .light, block:((UIVisualEffectView) -> Void)? = nil) -> CD {
        base.layoutIfNeeded()
        base.backgroundColor = UIColor.clear
        let blurEffect = UIBlurEffect(style: style)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.backgroundColor = color
        blurEffectView.frame = base.bounds
        base.addSubview(blurEffectView)
        base.sendSubviewToBack(blurEffectView)
        block?(blurEffectView)
        return self
    }
    
    ///
    @discardableResult
    func then(_ block:() -> Void) -> CD {
        block()
        return self
    }
}

//MARK:--- 返回非 self 将中断链式 ----------
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
    
    /// 截图
    var cutImage:UIImage? {
        base.layoutIfNeeded()
        UIGraphicsBeginImageContextWithOptions(base.frame.size, true, UIScreen.main.scale)
        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
        base.layer.render(in: context)
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else {
            return nil
        }
        UIGraphicsEndImageContext()
        return image
    }
}


public extension CD where Base: UIScrollView {
    /// 截长图
    var cutImageLong:UIImage? {
        base.layoutIfNeeded()
        let savedContentOffset = base.contentOffset
        let savedFrame = base.frame
        base.contentOffset = .zero
        base.frame = CGRect(x: 0, y: 0, width: base.contentSize.width, height: base.contentSize.height)
        guard let image = base.cd.cutImage else {
            base.contentOffset = savedContentOffset
            base.frame = savedFrame
            return nil
        }
        base.contentOffset = savedContentOffset
        base.frame = savedFrame
        return image
    }
}
