//Created  on 2018/12/11  by LCD :https://github.com/liucaide .

import Foundation

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
    
    @discardableResult
    func add(_ subview: UIView) -> CD {
        base.addSubview(subview)
        return self
    }
    
    @discardableResult
    func add(_ gestureRecognizer: UIGestureRecognizer) -> CD {
        base.addGestureRecognizer(gestureRecognizer)
        return self
    }
    
    @discardableResult
    func add(_ constraint: NSLayoutConstraint) -> CD {
        base.addConstraint(constraint)
        return self
    }
    
    @discardableResult
    func add(_ constraints: [NSLayoutConstraint]) -> CD {
        base.addConstraints(constraints)
        return self
    }
}


