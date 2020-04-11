//Created  on 2018/12/11  by LCD :https://github.com/liucaide .

import Foundation
import UIKit

public extension CaamDau where Base: UIStackView {
    @discardableResult
    func addArranged(subview view: UIView) -> CaamDau {
        base.addArrangedSubview(view)
        return self
    }
    
    @discardableResult
    func removeArranged(subview view: UIView) -> CaamDau {
        base.removeArrangedSubview(view)
        return self
    }
    
    @discardableResult
    func insertArranged(subview view: UIView, at:Int) -> CaamDau {
        base.insertArrangedSubview(view, at: at)
        return self
    }
    
    @discardableResult
    func axis(_ a: NSLayoutConstraint.Axis) -> CaamDau {
        base.axis = a
        return self
    }
    
    @discardableResult
    func distribution(_ a: UIStackView.Distribution) -> CaamDau {
        base.distribution = a
        return self
    }
    
    @discardableResult
    func alignment(_ a: UIStackView.Alignment) -> CaamDau {
        base.alignment = a
        return self
    }

    @discardableResult
    func spacing(_ a: CGFloat) -> CaamDau {
        base.spacing = a
        return self
    }
    
    @discardableResult
    @available(iOS 11.0, *)
    func custom(_ spacing: CGFloat, after arrangedSubview: UIView) -> CaamDau {
        base.setCustomSpacing(spacing, after: arrangedSubview)
        return self
    }
    
    @discardableResult
    func isBaselineRelativeArrangement(_ a: Bool) -> CaamDau {
        base.isBaselineRelativeArrangement = a
        return self
    }
    
    @discardableResult
    func isLayoutMarginsRelativeArrangement(_ a: Bool) -> CaamDau {
        base.isLayoutMarginsRelativeArrangement = a
        return self
    }
}
