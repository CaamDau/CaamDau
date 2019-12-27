//Created  on 2018/12/11  by LCD :https://github.com/liucaide .

import Foundation
import UIKit

public protocol CaamDauViewProtocol {
    /// T: UIView、UIGestureRecognizer、NSLayoutConstraint、[NSLayoutConstraint]、、
    func addT<T>(_ t: T?)
    
    func appendView<T:UIView>(_ type:T.Type, _ handler:((T)->Void)?)
    
    
}
extension CaamDauViewProtocol {
    public func addT<T>(_ t: T?){
        guard let vv = self as? UIView else { return }
        switch t {
        case let subview as UIView where vv is UIStackView:
            (vv as? UIStackView)?.addArrangedSubview(subview)
        case let subview as UIView :
            vv.addSubview(subview)
        case let ges as UIGestureRecognizer :
            vv.addGestureRecognizer(ges)
        case let lay as NSLayoutConstraint :
            vv.addConstraint(lay)
        case let lays as [NSLayoutConstraint] :
            vv.addConstraints(lays)
        default:
            break
        }
        
    }
    
    public func appendView<T>(_ type: T.Type, _ handler: ((T) -> Void)? = nil) where T : UIView {
        switch self {
        case let stack as UIStackView:
            let v = T()
            handler?(v)
            stack.addArrangedSubview(v)
        case let vv as UIView:
            let v = T()
            handler?(v)
            vv.addSubview(v)
        default:
            break
        }
    }
    
}



public extension CaamDau where Base: UIView {
    @discardableResult
    public func add<T>(_ t: T?) -> CaamDau {
        base.addT(t)
        return self
    }
    
    @discardableResult
    public func append<T:UIView>(_ type:T.Type, _ handler:((T)->Void)?) -> CaamDau {
        base.appendView(type, handler)
        return self
    }
}


extension UIView: CaamDauViewProtocol {
    /*
    public func appendView<T>(_ type: T.Type, _ handler: ((T) -> Void)?) where T : UIView {
        self.cd.append(type, handler)
    }*/
    /*
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
    }*/
}


public extension CaamDau where Base: UIView {
    @discardableResult
    func frame(_ a: CGRect) -> CaamDau {
        base.frame = a
        return self
    }
    @discardableResult
    func frame(x: CGFloat = 0, y: CGFloat = 0, w: CGFloat = 0, h: CGFloat = 0) -> CaamDau {
        base.frame = CGRect(x: x, y: y, width: w, height: h)
        return self
    }
    @discardableResult
    func bounds(_ a: CGRect) -> CaamDau {
        base.bounds = a
        return self
    }
    @discardableResult
    func bounds(w: CGFloat = 0, h: CGFloat = 0) -> CaamDau {
        base.bounds = CGRect(x: 0, y: 0, width: w, height: h)
        return self
    }
    
    @discardableResult
    func center(_ a: CGPoint) -> CaamDau {
        base.center = a
        return self
    }
    
    @discardableResult
    func center(x: CGFloat = 0, y: CGFloat = 0) -> CaamDau {
        base.center = CGPoint(x: x, y: y)
        return self
    }
    @discardableResult
    func tag(_ a: Int) -> CaamDau {
        base.tag = a
        return self
    }
    @discardableResult
    func background(_ color: UIColor?) -> CaamDau {
        base.backgroundColor = color
        return self
    }
    
    @discardableResult
    func alpha(_ a: CGFloat) -> CaamDau {
        base.alpha = a
        return self
    }
    
    @discardableResult
    func content(_ mode: UIView.ContentMode) -> CaamDau {
        base.contentMode = mode
        return self
    }
    
    @discardableResult
    func isHidden(_ a: Bool) -> CaamDau {
        base.isHidden = a
        return self
    }
    
    @discardableResult
    func isOpaque(_ a: Bool) -> CaamDau {
        base.isOpaque = a
        return self
    }
    
    @discardableResult
    func isUser(_ interactionEnabled: Bool) -> CaamDau {
        base.isUserInteractionEnabled = interactionEnabled
        return self
    }
    
    @discardableResult
    func tint(_ color: UIColor) -> CaamDau {
        base.tintColor = color
        return self
    }
    
    @discardableResult
    func corner(_ radius: CGFloat) -> CaamDau {
        base.layer.cornerRadius = radius
        return self
    }
    
    @discardableResult
    func clips(_ toBounds: Bool) -> CaamDau {
        base.clipsToBounds = toBounds
        return self
    }
    
    @discardableResult
    func corner(_ radius:CGFloat, clips: Bool = true) -> CaamDau {
        base.layer.cornerRadius = radius
        base.clipsToBounds = clips
        return self
    }
    
    @discardableResult
    func masks(_ toBounds: Bool) -> CaamDau {
        base.layer.masksToBounds = toBounds
        return self
    }
    
    @discardableResult
    func border(_ width: CGFloat) -> CaamDau {
        base.layer.borderWidth = width
        return self
    }
    
    @discardableResult
    func border(_ color: UIColor) -> CaamDau {
        base.layer.borderColor = color.cgColor
        return self
    }
    
    @discardableResult
    func border(_ width:CGFloat, color: UIColor) -> CaamDau {
        base.layer.borderWidth = width
        base.layer.borderColor = color.cgColor
        return self
    }
    
    @discardableResult
    func shadow(_ path: CGPath) -> CaamDau {
        base.layer.shadowPath = path
        return self
    }
    
    @discardableResult
    func shadow(_ color: UIColor) -> CaamDau {
        base.layer.shadowColor = color.cgColor
        return self
    }
    
    @discardableResult
    func shadow(_ opacity: Float) -> CaamDau {
        base.layer.shadowOpacity = opacity
        return self
    }
    
    @discardableResult
    func shadow(_ offset: CGSize) -> CaamDau {
        base.layer.shadowOffset = offset
        return self
    }
    
    @discardableResult
    func shadow( w:CGFloat = 0, h:CGFloat = 0) -> CaamDau {
        base.layer.shadowOffset = CGSize(width: w, height: h)
        return self
    }
    
    @discardableResult
    func shadow(_ radius: CGFloat) -> CaamDau {
        base.layer.shadowRadius = radius
        return self
    }
    
    @discardableResult
    func shadow(_ path: CGPath?) -> CaamDau {
        base.layer.shadowPath = path
        return self
    }
    /// 阴影
    @discardableResult
    func shadow(color: UIColor, opacity: Float, offset: CGSize, radius: CGFloat) -> CaamDau {
        base.layer.shadowColor = color.cgColor
        base.layer.shadowOffset = offset
        base.layer.shadowOpacity = opacity
        base.layer.shadowRadius = radius
        return self
    }
    /// 变形属性(平移\缩放\旋转)
    @discardableResult
    func transform(_ a: CGAffineTransform) -> CaamDau {
        base.transform = a
        return self
    }
    /// 自动调整子视图尺寸，默认YES则会根据autoresizingMask属性自动调整子视图尺寸
    @discardableResult
    func autoresizes(_ subviews: Bool) -> CaamDau {
        base.autoresizesSubviews = subviews
        return self
    }
    /// 自动调整子视图与父视图的位置，默认UIViewAutoresizingNone
    @discardableResult
    func autoresizing(_ mask: UIView.AutoresizingMask) -> CaamDau {
        base.autoresizingMask = mask
        return self
    }
    
    /// 圆角
    @discardableResult
    func rounded(_ corners:UIRectCorner, _ radii:CGSize) -> CaamDau {
        return self.rounded(base.bounds, corners, radii)
    }
    
    /// 圆角
    @discardableResult
    func rounded(_ rect:CGRect, _ corners:UIRectCorner, _ radii:CGSize) -> CaamDau {
        let rounded = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: radii)
        let shape = CAShapeLayer()
        shape.path = rounded.cgPath
        base.layer.mask = shape
        return self
    }
    
    /// 背景线性渐变 默认横向渐变 point -> 0 - 1
    /// let gradients:[(UIColor,Float)] = [(UIColor.red,0),(UIColor.yellow,1)]
    /// view.cd.gradient(layer: gradients)
    /// 文字渐变 view.gradient(layerAxial: ..., then:{ layer in layer.mask = label.layer })
    @discardableResult
    func gradient(layerAxial gradients:[(color:UIColor,location:Float)], point:(start:CGPoint, end:CGPoint) = (start:CGPoint(x: 0, y: 0), end:CGPoint(x: 1, y: 0)), at: UInt32 = 0, updateIndex:Int? = nil, then:((CAGradientLayer)->Void)? = nil) -> CaamDau {
        
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
            then?(layer)
        }else{
            let layer = layers[updateIndex ?? 0]
            gradient(layers[updateIndex ?? 0])
            then?(layer)
        }
        return self
    }
    /// 放射性渐变
    open class CD_GradientLayer:CALayer {
        open var point: CGPoint = CGPoint.zero
        open var colorSpace = CGColorSpaceCreateDeviceRGB()
        open var locations:[CGFloat] = [0.0, 1.0]
        open var colors:[CGFloat] = [0.0,0.0,0.0,0.0,0.0,0.0,0.0,1.0]
        open lazy var radius: CGFloat = {
            return Swift.max(self.bounds.size.width, self.bounds.size.height)
        }()
        override open func draw(in ctx: CGContext) {
            guard let gradient = CGGradient(colorSpace: colorSpace, colorComponents: colors, locations: locations, count: locations.count) else {
                return
            }
            ctx.drawRadialGradient(gradient, startCenter: point, startRadius: 0, endCenter: point, endRadius: radius, options: .drawsAfterEndLocation)
        }
    }
    /// 背景放射性渐变
    @discardableResult
    func gradient(layerRadial gradients:[(color:UIColor,location:CGFloat)], point:CGPoint = CGPoint(x: 0, y: 0), radius:CGFloat? = nil, at: UInt32 = 0, updateIndex:Int? = nil, then:((CD_GradientLayer)->Void)? = nil) -> CaamDau {
        
        func gradient(_ layer:CD_GradientLayer) {
            base.layoutIfNeeded()
            layer.locations = gradients.map{$0.location}
            layer.colors =  Array(gradients.map({ (c) -> [CGFloat] in
                let cc = c.color.cd_rgba
                return [cc.0,cc.1,cc.2,cc.3]
            }).joined())
            layer.frame = base.bounds
            layer.point = point
            layer.radius = radius ?? Swift.max(base.bounds.size.width, base.bounds.size.height)
            layer.setNeedsDisplay()
        }
        
        let layers:[CD_GradientLayer] = base.layer.sublayers?.filter{$0.isKind(of: CD_GradientLayer.self)}.map{$0} as? [CD_GradientLayer] ?? []
        if layers.count <= at {
            let layer = CD_GradientLayer()
            gradient(layer)
            base.layer.insertSublayer(layer, at: at)
            then?(layer)
        }else{
            let layer = layers[updateIndex ?? 0]
            gradient(layer)
            then?(layer)
        }
        return self
    }
    
    /// 毛玻璃效果 view.blurEffect(UIColor.red.withAlphaComponent(0.5))
    @discardableResult
    func blurEffect(_ color:UIColor = UIColor.clear,  style:UIBlurEffect.Style = .light, block:((UIVisualEffectView) -> Void)? = nil) -> CaamDau {
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
    func then(_ block:(Base) -> Void) -> CaamDau {
        block(base)
        return self
    }
    
    
    
    @discardableResult
    func insert(_ subview:UIView, at index:Int = 0) -> CaamDau {
        base.insertSubview(subview, at: index)
        return self
    }
    
    @discardableResult
    func insert(_ subview:UIView, below view:UIView) -> CaamDau {
        base.insertSubview(subview, belowSubview: view)
        return self
    }
    @discardableResult
    func insert(_ subview:UIView, above view:UIView) -> CaamDau {
        base.insertSubview(subview, aboveSubview: view)
        return self
    }
    
    @discardableResult
    func exchange(_ subview1:Int, _ subview2:Int) -> CaamDau {
        base.exchangeSubview(at: subview1, withSubviewAt: subview2)
        return self
    }
    
    @discardableResult
    func bring(subviewToFront view:UIView) -> CaamDau {
        base.bringSubviewToFront(view)
        return self
    }
    
    @discardableResult
    func send(subviewToBack view:UIView) -> CaamDau {
        base.sendSubviewToBack(view)
        return self
    }
    
    @discardableResult
    func add(toSuperview view:UIView) -> CaamDau {
        view.addSubview(base)
        return self
    }
    
    @discardableResult
    func insert(toSuperview view:UIView, at index:Int) -> CaamDau {
        view.insertSubview(base, at: index)
        return self
    }
    
    @discardableResult
    func insert(toSuperview superview:UIView, below view:UIView) -> CaamDau {
        superview.insertSubview(base, belowSubview: view)
        return self
    }
    @discardableResult
    func insert(toSuperview superview:UIView, above view:UIView) -> CaamDau {
        superview.insertSubview(base, aboveSubview: view)
        return self
    }
    
    @discardableResult
    func exchange(_ view:UIView) -> CaamDau {
        guard let idx1 = base.superview?.subviews.firstIndex(of: base),
            let idx2 = base.superview?.subviews.firstIndex(of: view) else {
            return self
        }
        base.superview?.exchangeSubview(at: idx1, withSubviewAt: idx2)
        return self
    }
    
    @discardableResult
    func bringToFront() -> CaamDau {
        base.superview?.bringSubviewToFront(base)
        return self
    }
    
    @discardableResult
    func sendToBack() -> CaamDau {
        base.superview?.sendSubviewToBack(base)
        return self
    }
    
    @discardableResult
    func add(toSuperstack stack:UIStackView) -> CaamDau {
        stack.addArrangedSubview(base)
        return self
    }
    @discardableResult
    func insert(toSuperstack stack:UIStackView, at index:Int) -> CaamDau {
        stack.insertArrangedSubview(base, at: index)
        return self
    }
    
    @discardableResult
    func removeFromSuperview() -> CaamDau {
        base.removeFromSuperview()
        return self
    }
    
    @discardableResult
    func remove(subview view:UIView) -> CaamDau {
        base.subviews
            .filter{ $0 == view }
            .forEach{ $0.removeFromSuperview() }
        return self
    }
    
    @discardableResult
    func remove(subviews views:[UIView]) -> CaamDau {
        base.subviews
            .filter{ views.contains($0)}
            .forEach{ $0.removeFromSuperview() }
        return self
    }
}

//MARK:--- 返回非 self 将中断链式 ----------
public extension CaamDau where Base: UIView{
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
    public var cutImage:UIImage? {
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


public extension CaamDau where Base: UIScrollView {
    /// 截长图
    public var cutImageLong:UIImage? {
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




extension UIView{
    public static func cd_loadNib(_ name:String? = nil, from:String? = nil, owner: Any? = nil, options: [UINib.OptionsKey : Any]? = nil) -> [Any]? {
        let bundle = Bundle.cd_bundle(self, from) ?? Bundle.main
        return bundle.loadNibNamed(name ?? String(describing: self), owner: owner, options: options)
    }
}

