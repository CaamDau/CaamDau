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
    func content(insetAdjustmentBehavior i: UIScrollView.ContentInsetAdjustmentBehavior) -> CD {
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
    
    @discardableResult
    func indicator(style s: UIScrollView.IndicatorStyle) -> CD {
        base.indicatorStyle = s
        return self
    }
    
    @discardableResult
    func deceleration(rate r: UIScrollView.DecelerationRate) -> CD {
        base.decelerationRate = r
        return self
    }
    
    @discardableResult
    func index(displayMode m: UIScrollView.IndexDisplayMode) -> CD {
        base.indexDisplayMode = m
        return self
    }
    
    @discardableResult
    func set(contentOffset p:CGPoint, _ animated:Bool = true) -> CD {
        base.setContentOffset(p, animated: animated)
        return self
    }
    
    @discardableResult
    func scroll(rectToVisible r:CGRect, _ animated:Bool = true) -> CD {
        base.scrollRectToVisible(r, animated: animated)
        return self
    }
    
    @discardableResult
    func flashScrollIndicators() -> CD {
        base.flashScrollIndicators()
        return self
    }
    
    @discardableResult
    func delays(contentTouches b:Bool) -> CD {
        base.delaysContentTouches = b
        return self
    }
    
    @discardableResult
    func canCancel(contentTouches b:Bool) -> CD {
        base.canCancelContentTouches = b
        return self
    }
    @discardableResult
    func bounces(zoom b:Bool) -> CD {
        base.bouncesZoom = b
        return self
    }
    @discardableResult
    func scrollsToTop(_ b:Bool = true) -> CD {
        base.scrollsToTop = b
        return self
    }
    
    @discardableResult
    func min(imumZoomScale a:CGFloat) -> CD {
        base.minimumZoomScale = a
        return self
    }
    @discardableResult
    func max(imumZoomScale a:CGFloat) -> CD {
        base.maximumZoomScale = a
        return self
    }
    @discardableResult
    func zoom(scale a:CGFloat) -> CD {
        base.maximumZoomScale = a
        return self
    }
    
    @discardableResult
    func set(zoomScale a:CGFloat, _ animated:Bool = true) -> CD {
        base.setZoomScale(a, animated: animated)
        return self
    }
    
    @discardableResult
    func zoom(toRect a:CGRect, _ animated:Bool = true) -> CD {
        base.zoom(to: a, animated: animated)
        return self
    }
    
    @discardableResult
    func keyboard(dismissMode a:UIScrollView.KeyboardDismissMode) -> CD {
        base.keyboardDismissMode = a
        return self
    }
    
    @available(iOS 10.0, *)
    @discardableResult
    func refresh(control a:UIRefreshControl?) -> CD {
        base.refreshControl = a
        return self
    }
    
    /// 右滑返回
    @discardableResult
    func panBack(_ gesture: UIGestureRecognizer, otherGesture:UIGestureRecognizer) -> Bool {
        if base.contentOffset.x <= 0,
            let delegate = otherGesture.delegate,
            let fdFulls = NSClassFromString("_FDFullscreenPopGestureRecognizerDelegate").self,
            delegate.isKind(of: fdFulls) {
            return true
        }
        else if gesture == base.panGestureRecognizer,
            let pan:UIPanGestureRecognizer = gesture as? UIPanGestureRecognizer {
            let point = pan.translation(in: base)
            let state = pan.state
            if state == .began || state == .possible {
                let location = pan.location(in: base)
                if point.x >= 0 && location.x < 60 && base.contentOffset.x <= 0 {
                    return true
                }
            }
        }
        return false
    }
}
