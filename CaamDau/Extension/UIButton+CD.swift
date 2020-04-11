//Created  on 2018/12/11  by LCD :https://github.com/liucaide .

import Foundation
import UIKit

public extension CaamDau where Base: UIButton {
    @discardableResult
    ///addTarget(_ target: Any?, action: Selector, for controlEvents: UIControl.Event)
    func target(add target: Any?, action: Selector, event: UIControl.Event = .touchUpInside) -> CaamDau {
        base.addTarget(target, action: action, for: event)
        return self
    }
    
    func target(remove target: Any?, action: Selector, event: UIControl.Event = .touchUpInside) -> CaamDau {
        base.removeTarget(target, action: action, for: event)
        return self
    }
    
    @discardableResult
    func select(_ b: Bool) -> CaamDau {
        base.isSelected = b
        return self
    }
    
    @discardableResult
    func line(breakMode mode: NSLineBreakMode) -> CaamDau {
        base.titleLabel?.lineBreakMode = mode
        return self
    }
    
    @discardableResult
    func image(_ image: UIImage?, for state:UIControl.State = .normal) -> CaamDau {
        base.setImage(image, for: state)
        return self
    }
    @discardableResult
    func background(_ image: UIImage?, for state:UIControl.State = .normal) -> CaamDau {
        base.setBackgroundImage(image, for: state)
        return self
    }
    
    @discardableResult
    func attributed(_ title: NSAttributedString, for state:UIControl.State = .normal) -> CaamDau {
        base.setAttributedTitle(title, for: state)
        return self
    }
    
    @discardableResult
    func title(_ edgeInsets: UIEdgeInsets) -> CaamDau {
        base.titleEdgeInsets = edgeInsets
        return self
    }
    
    @discardableResult
    func title(edgeInsets top: CGFloat = 0, left:CGFloat = 0, bottom:CGFloat = 0, right:CGFloat = 0) -> CaamDau {
        base.titleEdgeInsets = UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
        return self
    }
    
    @discardableResult
    func image(_ edgeInsets: UIEdgeInsets) -> CaamDau {
        base.imageEdgeInsets = edgeInsets
        return self
    }
    
    @discardableResult
    func image(edgeInsets top: CGFloat = 0, left:CGFloat = 0, bottom:CGFloat = 0, right:CGFloat = 0) -> CaamDau {
        base.imageEdgeInsets = UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
        return self
    }
    
    @discardableResult
    func contentAlignment(horizontal: UIControl.ContentHorizontalAlignment) -> CaamDau {
        base.contentHorizontalAlignment = horizontal
        return self
    }
    @discardableResult
    func contentAlignment(vertical: UIControl.ContentVerticalAlignment) -> CaamDau {
        base.contentVerticalAlignment = vertical
        return self
    }
    @discardableResult
    func imageViewContent(_ mode: UIView.ContentMode) -> CaamDau {
        base.imageView?.contentMode = mode
        return self
    }
    @discardableResult
    func reverses(_ titleShadowWhenHighlighted: Bool) -> CaamDau {
        base.reversesTitleShadowWhenHighlighted = titleShadowWhenHighlighted
        return self
    }
    
    @discardableResult
    func adjusts(imageWhenHighlighted a: Bool) -> CaamDau {
        base.adjustsImageWhenHighlighted = a
        return self
    }
    
    @discardableResult
    func adjusts(imageWhenDisabled a: Bool) -> CaamDau {
        base.adjustsImageWhenDisabled = a
        return self
    }
    @discardableResult
    func shows(_ touchWhenHighlighted: Bool) -> CaamDau {
        base.showsTouchWhenHighlighted = touchWhenHighlighted
        return self
    }
    
    @discardableResult
    func loading(bgViewColor: UIColor = .clear,
                 bgViewFrame:CGRect = .zero,
                 style:UIActivityIndicatorView.Style = .gray,
                 activityColor:UIColor = .clear) -> CaamDau {
        base.isEnabled = false
        let activity = UIActivityIndicatorView(style: style)
        activity.startAnimating()
        let view = UIView()
        view.tag = -8668
        if bgViewFrame == .zero {
            base.superview?.layoutIfNeeded()
            view.frame = base.bounds
        }else{
            view.frame = bgViewFrame
        }
        if bgViewColor == .clear {
            view.backgroundColor = bgViewColor
        }else{
            view.backgroundColor = base.backgroundColor
        }
        if activityColor != .clear {
            activity.color = activityColor
        }
        activity.frame = view.bounds
        
        base.addSubview(view)
        view.addSubview(activity)
        return self
    }
    
    @discardableResult
    func loading(_ custom:(()->Void)) -> CaamDau {
        base.isEnabled = false
        custom()
        return self
    }
    
    @discardableResult
    func loadingHidden(_ tag:Int = -8668) -> CaamDau {
        base.viewWithTag(tag)?.removeFromSuperview()
        base.isEnabled = true
        return self
    }
}
