//Created  on 2019/2/28 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 *
 */

import Foundation
import UIKit

public extension CaamDau where Base: UIScrollView {
    
    @discardableResult
    func delegate(_ d: UIScrollViewDelegate?) -> CaamDau {
        base.delegate = d
        return self
    }
    
    @discardableResult
    func content(offset p: CGPoint) -> CaamDau {
        base.contentOffset = p
        return self
    }
    
    @discardableResult
    func content(size s: CGSize) -> CaamDau {
        base.contentSize = s
        return self
    }
    
    @discardableResult
    func content(inset i: UIEdgeInsets) -> CaamDau {
        base.contentInset = i
        return self
    }
    
    @available(iOS 11.0, *)
    @discardableResult
    func content(insetAdjustmentBehavior i: UIScrollView.ContentInsetAdjustmentBehavior) -> CaamDau {
        base.contentInsetAdjustmentBehavior = i
        return self
    }
    
    @discardableResult
    func isDirectional(lockEnabled l: Bool) -> CaamDau {
        base.isDirectionalLockEnabled = l
        return self
    }
    
    @discardableResult
    func bounces(_ b: Bool) -> CaamDau {
        base.bounces = b
        return self
    }
    
    @discardableResult
    func always(bounceVertical b: Bool) -> CaamDau {
        base.alwaysBounceVertical = b
        return self
    }
    
    @discardableResult
    func always(bounceHorizontal b: Bool) -> CaamDau {
        base.alwaysBounceHorizontal = b
        return self
    }
    
    @discardableResult
    func isPaging(enabled e: Bool) -> CaamDau {
        base.isPagingEnabled = e
        return self
    }
    
    @discardableResult
    func isScroll(enabled e: Bool) -> CaamDau {
        base.isScrollEnabled = e
        return self
    }
    
    @discardableResult
    func shows(horizontalScrollIndicator b: Bool) -> CaamDau {
        base.showsHorizontalScrollIndicator = b
        return self
    }
    
    @discardableResult
    func shows(verticalScrollIndicator b: Bool) -> CaamDau {
        base.showsVerticalScrollIndicator = b
        return self
    }
    
    @discardableResult
    func scroll(indicatorInsets i: UIEdgeInsets) -> CaamDau {
        base.scrollIndicatorInsets = i
        return self
    }
    
    @discardableResult
    func indicator(style s: UIScrollView.IndicatorStyle) -> CaamDau {
        base.indicatorStyle = s
        return self
    }
    
    @discardableResult
    func deceleration(rate r: UIScrollView.DecelerationRate) -> CaamDau {
        base.decelerationRate = r
        return self
    }
    
    @discardableResult
    func index(displayMode m: UIScrollView.IndexDisplayMode) -> CaamDau {
        base.indexDisplayMode = m
        return self
    }
    
    @discardableResult
    func set(contentOffset p:CGPoint, _ animated:Bool = true) -> CaamDau {
        base.setContentOffset(p, animated: animated)
        return self
    }
    
    @discardableResult
    func scroll(rectToVisible r:CGRect, _ animated:Bool = true) -> CaamDau {
        base.scrollRectToVisible(r, animated: animated)
        return self
    }
    
    @discardableResult
    func flashScrollIndicators() -> CaamDau {
        base.flashScrollIndicators()
        return self
    }
    
    @discardableResult
    func delays(contentTouches b:Bool) -> CaamDau {
        base.delaysContentTouches = b
        return self
    }
    
    @discardableResult
    func canCancel(contentTouches b:Bool) -> CaamDau {
        base.canCancelContentTouches = b
        return self
    }
    @discardableResult
    func bounces(zoom b:Bool) -> CaamDau {
        base.bouncesZoom = b
        return self
    }
    @discardableResult
    func scrollsToTop(_ b:Bool = true) -> CaamDau {
        base.scrollsToTop = b
        return self
    }
    
    @discardableResult
    func min(imumZoomScale a:CGFloat) -> CaamDau {
        base.minimumZoomScale = a
        return self
    }
    @discardableResult
    func max(imumZoomScale a:CGFloat) -> CaamDau {
        base.maximumZoomScale = a
        return self
    }
    @discardableResult
    func zoom(scale a:CGFloat) -> CaamDau {
        base.maximumZoomScale = a
        return self
    }
    
    @discardableResult
    func set(zoomScale a:CGFloat, _ animated:Bool = true) -> CaamDau {
        base.setZoomScale(a, animated: animated)
        return self
    }
    
    @discardableResult
    func zoom(toRect a:CGRect, _ animated:Bool = true) -> CaamDau {
        base.zoom(to: a, animated: animated)
        return self
    }
    
    @discardableResult
    func keyboard(dismissMode a:UIScrollView.KeyboardDismissMode) -> CaamDau {
        base.keyboardDismissMode = a
        return self
    }
    
    @available(iOS 10.0, *)
    @discardableResult
    func refresh(control a:UIRefreshControl?) -> CaamDau {
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
