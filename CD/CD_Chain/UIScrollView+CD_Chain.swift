//Created  on 2019/2/28 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 *
 */

import Foundation
import UIKit

public extension CD where Base: UIScrollView {
    
    @discardableResult
    func delegate(_ d: UIScrollViewDelegate?) -> CD {
        base.delegate = d
        return self
    }
    
    @discardableResult
    func content(offset p: CGPoint) -> CD {
        base.contentOffset = p
        return self
    }
    
    @discardableResult
    func content(size s: CGSize) -> CD {
        base.contentSize = s
        return self
    }
    
    @discardableResult
    func content(inset i: UIEdgeInsets) -> CD {
        base.contentInset = i
        return self
    }
    
    @available(iOS 11.0, *)
    @discardableResult
    func content(InsetAdjustmentBehavior i: UIScrollView.ContentInsetAdjustmentBehavior) -> CD {
        base.contentInsetAdjustmentBehavior = i
        return self
    }
    
    @discardableResult
    func isDirectional(lockEnabled l: Bool) -> CD {
        base.isDirectionalLockEnabled = l
        return self
    }
    
    @discardableResult
    func bounces(_ b: Bool) -> CD {
        base.bounces = b
        return self
    }
    
    @discardableResult
    func always(bounceVertical b: Bool) -> CD {
        base.alwaysBounceVertical = b
        return self
    }
    
    @discardableResult
    func always(bounceHorizontal b: Bool) -> CD {
        base.alwaysBounceHorizontal = b
        return self
    }
    
    @discardableResult
    func isPaging(enabled e: Bool) -> CD {
        base.isPagingEnabled = e
        return self
    }
    
    @discardableResult
    func isScroll(enabled e: Bool) -> CD {
        base.isScrollEnabled = e
        return self
    }
    
    @discardableResult
    func shows(horizontalScrollIndicator b: Bool) -> CD {
        base.showsHorizontalScrollIndicator = b
        return self
    }
    
    @discardableResult
    func shows(verticalScrollIndicator b: Bool) -> CD {
        base.showsVerticalScrollIndicator = b
        return self
    }
    
    @discardableResult
    func scroll(indicatorInsets i: UIEdgeInsets) -> CD {
        base.scrollIndicatorInsets = i
        return self
    }
    
}
