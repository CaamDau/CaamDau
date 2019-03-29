//Created  on 2018/12/11  by LCD :https://github.com/liucaide .

import Foundation
import UIKit

public extension CD where Base: UIButton {
    @discardableResult
    func line(breakMode mode: NSLineBreakMode) -> CD {
        base.titleLabel?.lineBreakMode = mode
        return self
    }
    
    @discardableResult
    func image(_ image: UIImage?, for state:UIControl.State = .normal) -> CD {
        base.setImage(image, for: state)
        return self
    }
    @discardableResult
    func background(_ image: UIImage?, for state:UIControl.State = .normal) -> CD {
        base.setBackgroundImage(image, for: state)
        return self
    }
    
    @discardableResult
    func attributed(_ title: NSAttributedString, for state:UIControl.State = .normal) -> CD {
        base.setAttributedTitle(title, for: state)
        return self
    }
    
    @discardableResult
    func title(_ edgeInsets: UIEdgeInsets) -> CD {
        base.titleEdgeInsets = edgeInsets
        return self
    }
    
    @discardableResult
    func title(edgeInsets top: CGFloat = 0, left:CGFloat = 0, bottom:CGFloat = 0, right:CGFloat = 0) -> CD {
        base.titleEdgeInsets = UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
        return self
    }
    
    @discardableResult
    func image(_ edgeInsets: UIEdgeInsets) -> CD {
        base.imageEdgeInsets = edgeInsets
        return self
    }
    
    @discardableResult
    func image(edgeInsets top: CGFloat = 0, left:CGFloat = 0, bottom:CGFloat = 0, right:CGFloat = 0) -> CD {
        base.imageEdgeInsets = UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
        return self
    }
    
    @discardableResult
    func content(_ horizontalAlignment: UIControl.ContentHorizontalAlignment) -> CD {
        base.contentHorizontalAlignment = horizontalAlignment
        return self
    }
    @discardableResult
    func content(_ verticalAlignment: UIControl.ContentVerticalAlignment) -> CD {
        base.contentVerticalAlignment = verticalAlignment
        return self
    }
    
    @discardableResult
    func content(_ horizontal: UIControl.ContentHorizontalAlignment = .center, _ vertical: UIControl.ContentVerticalAlignment = .center) -> CD {
        base.contentHorizontalAlignment = horizontal
        base.contentVerticalAlignment = vertical
        return self
    }
    
    @discardableResult
    func reverses(_ titleShadowWhenHighlighted: Bool) -> CD {
        base.reversesTitleShadowWhenHighlighted = titleShadowWhenHighlighted
        return self
    }
    
    @discardableResult
    func adjusts(imageWhenHighlighted a: Bool) -> CD {
        base.adjustsImageWhenHighlighted = a
        return self
    }
    
    @discardableResult
    func adjusts(imageWhenDisabled a: Bool) -> CD {
        base.adjustsImageWhenDisabled = a
        return self
    }
    @discardableResult
    func shows(_ touchWhenHighlighted: Bool) -> CD {
        base.showsTouchWhenHighlighted = touchWhenHighlighted
        return self
    }
    
    @discardableResult
    func loading(bgViewColor: UIColor = .clear,
                 bgViewFrame:CGRect = .zero,
                 style:UIActivityIndicatorView.Style = .gray,
                 activityColor:UIColor = .clear) -> CD {
        base.isEnabled = false
        let activity = UIActivityIndicatorView(style: style)
        activity.startAnimating()
        let view = UIView()
        view.tag = -8668
        if bgViewFrame == .zero {
            view.frame = bgViewFrame
        }else{
            view.frame = base.bounds
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
    func loading(_ custom:(()->Void)) -> CD {
        base.isEnabled = false
        custom()
        return self
    }
    
    @discardableResult
    func loadingHidden(_ tag:Int = -8668) -> CD {
        base.viewWithTag(tag)?.removeFromSuperview()
        base.isEnabled = true
        return self
    }
}
