//Created  on 2019/5/16 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 * 动画组
 */




import Foundation
import UIKit

extension CD_HUD: CAAnimationDelegate {
    public func animationDidStart(_ anim: CAAnimation) {
        
    }
    public func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        self.removeFromSuperview()
    }
}

extension CD_HUD {
    func makeLayoutAnimation(_ remove:Bool = false) {
        switch (remove ? model._hiddenAnimat : model._showAnimation) {
        case .none where remove:
            self.removeFromSuperview()
        case .slide:
            makeLayoutAnimationSlide(remove)
        case .fade:
            makeLayoutAnimationFade(remove)
        case .zoom:
            makeLayoutAnimationZoom(remove)
        case .spring where remove:
            makeLayoutAnimationFade(remove)
        case .spring:
            makeLayoutAnimationSpring(remove)
        case .custom(let block):
            block?(self, contentView)
        default:
            break
        }
    }
    
    public func makeLayoutAnimationFade(_ remove:Bool) {
        let animote = CABasicAnimation(keyPath: "opacity")
        animote.duration = model._animoteDuration
        animote.isRemovedOnCompletion = false
        animote.fillMode = .forwards
        animote.fromValue = remove ? 1 : 0
        animote.toValue = remove ? 0 : 1
        animote.delegate = remove ? self : nil
        self.layer.add(animote, forKey: animote.keyPath)
    }
    
    func makeLayoutAnimationZoom(_ remove:Bool) {
        func addAnimation(_ view: UIView){
            let animote = CABasicAnimation(keyPath: "transform.scale")
            animote.duration = model._animoteDuration
            animote.isRemovedOnCompletion = false
            animote.fillMode = .forwards
            animote.fromValue = remove ? 1 : 0
            animote.toValue = remove ? 0 : 1
            view.layer.add(animote, forKey: animote.keyPath)
        }
        guard let view = model._isEnabledMask ? self : contentView else { return }
        addAnimation(view)
        makeLayoutAnimationFade(remove)
    }
    
    func makeLayoutAnimationSpring(_ remove:Bool) {
        func addAnimation(with view: UIView, value:(Any,Any)){
            let animote = CASpringAnimation(keyPath: "position.y")
            animote.duration = model._animoteDuration*5
            animote.damping = 10
            animote.stiffness = 500
            animote.mass = 0.5
            animote.initialVelocity = 0
            animote.fromValue = remove ? value.1 : value.0
            animote.toValue = remove ? value.0 : value.1
            view.layer.add(animote, forKey: animote.keyPath)
        }
        switch model._position {
        case .top:
            guard let view = model._isEnabledMask ? self : contentView else { return }
            view.superview?.layoutIfNeeded()
            let value0 = view.layer.position.y - view.layer.position.y - view.frame.size.height
            let value1 = view.layer.position.y
            addAnimation(with: view, value:(value0,value1))
            makeLayoutAnimationFade(remove)
        case .bottom:
            guard let view = model._isEnabledMask ? self : contentView else { return }
            view.superview?.layoutIfNeeded()
            let value0 = view.layer.position.y + view.frame.size.height + model._offsetBottomY
            let value1 = view.layer.position.y
            addAnimation(with: view, value:(value0,value1))
            makeLayoutAnimationFade(remove)
        case .center:
            makeLayoutAnimationFade(remove)
        case .custom(let offsetY):
            guard offsetY != 0 else {
                makeLayoutAnimationFade(remove)
                return
            }
            
            guard let view = model._isEnabledMask ? self : contentView else { return }
            view.superview?.layoutIfNeeded()
            var value0 = view.layer.position.y + view.frame.size.height + model._offsetBottomY
            let value1 = view.layer.position.y
            if offsetY < 0  {
                value0 = view.layer.position.y + view.frame.size.height - offsetY
            }else{
                value0 = view.layer.position.y - view.layer.position.y - view.frame.size.height
            }
            addAnimation(with: view, value:(value0,value1))
            makeLayoutAnimationFade(remove)
        }
    }
    
    func makeLayoutAnimationSlide(_ remove:Bool){
        func addAnimation(with view: UIView, value:(Any,Any)){
            let animote = CABasicAnimation(keyPath: "position.y")
            animote.duration = model._animoteDuration
            animote.isRemovedOnCompletion = false
            animote.fillMode = .forwards
            animote.fromValue = remove ? value.1 : value.0
            animote.toValue = remove ? value.0 : value.1
            animote.timingFunction = CAMediaTimingFunction(name: .easeOut)
            view.layer.add(animote, forKey: animote.keyPath)
        }
        switch model._position {
        case .top:
            guard let view = model._isEnabledMask ? self : contentView else { return }
            view.superview?.layoutIfNeeded()
            let value0 = view.layer.position.y - view.layer.position.y - view.frame.size.height
            let value1 = view.layer.position.y
            addAnimation(with: view, value:(value0,value1))
            makeLayoutAnimationFade(remove)
        case .bottom:
            guard let view = model._isEnabledMask ? self : contentView else { return }
            view.superview?.layoutIfNeeded()
            let value0 = view.layer.position.y + view.frame.size.height + model._offsetBottomY
            let value1 = view.layer.position.y
            addAnimation(with: view, value:(value0,value1))
            makeLayoutAnimationFade(remove)
        case .center:
            makeLayoutAnimationFade(remove)
        case .custom(let offsetY):
            guard offsetY != 0 else {
                makeLayoutAnimationFade(remove)
                return
            }
            
            guard let view = model._isEnabledMask ? self : contentView else { return }
            view.superview?.layoutIfNeeded()
            var value0 = view.layer.position.y + view.frame.size.height + model._offsetBottomY
            let value1 = view.layer.position.y
            if offsetY < 0  {
                value0 = view.layer.position.y + view.frame.size.height - offsetY
            }else{
                value0 = view.layer.position.y - view.layer.position.y - view.frame.size.height
            }
            addAnimation(with: view, value:(value0,value1))
            makeLayoutAnimationFade(remove)
        }
    }
}
