//Created  on 2018/12/11  by LCD :https://github.com/liucaide .

import Foundation
import UIKit

public extension CD where Base: UIStackView {
    @discardableResult
    func addArranged(subview view: UIView) -> CD {
        base.addArrangedSubview(view)
        return self
    }
    
    @discardableResult
    func removeArranged(subview view: UIView) -> CD {
        base.removeArrangedSubview(view)
        return self
    }
    
    @discardableResult
    func insertArranged(subview view: UIView, at:Int) -> CD {
        base.insertArrangedSubview(view, at: at)
        return self
    }
    
    @discardableResult
    func axis(_ a: NSLayoutConstraint.Axis) -> CD {
        base.axis = a
        return self
    }
    
    @discardableResult
    func distribution(_ a: UIStackView.Distribution) -> CD {
        base.distribution = a
        return self
    }
    
    @discardableResult
    func alignment(_ a: UIStackView.Alignment) -> CD {
        base.alignment = a
        return self
    }

    @discardableResult
    func spacing(_ a: CGFloat) -> CD {
        base.spacing = a
        return self
    }
    
    @discardableResult
    @available(iOS 11.0, *)
    func custom(_ spacing: CGFloat, after arrangedSubview: UIView) -> CD {
        base.setCustomSpacing(spacing, after: arrangedSubview)
        return self
    }
    
    @discardableResult
    func a(_ a: UIView) -> CD {
        
        return self
    }
    
    @discardableResult
    func isBaselineRelativeArrangement(_ a: Bool) -> CD {
        base.isBaselineRelativeArrangement = a
        return self
    }
    
    @discardableResult
    func isLayoutMarginsRelativeArrangement(_ a: Bool) -> CD {
        base.isLayoutMarginsRelativeArrangement = a
        return self
    }
}
