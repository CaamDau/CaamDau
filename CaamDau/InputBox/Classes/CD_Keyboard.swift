//Created  on 2019/7/19 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 *
 */




import Foundation
import UIKit
public class CD_Keyboard {
    weak var view:UIView?
    var observers:[NSObjectProtocol] = []
    open var willShowBeforeHandle:(() -> Void)?
    open var willHideBeforeHandle:(() -> Void)?
    open var willShowCallback:((CGFloat) -> Void)?
    open var willHideCallback:(() -> Void)?
    public init(view:UIView, willShowBeforeHandle show:(() -> Void)? = nil, willHideBeforeHandle hide:(() -> Void)? = nil) {
        self.view = view
        self.willShowCallback = { [weak self] h in
            var bottom:CGFloat = 0.0
            if #available(iOS 11.0, *) {
                bottom = CD.window?.safeAreaInsets.bottom ?? 0
            }
            self?.view?.transform = CGAffineTransform(translationX: 0,y: -h+bottom)
        }
        self.willHideCallback = { [weak self] in
            self?.view?.transform = .identity
        }
        self.willShowBeforeHandle = show
        self.willHideBeforeHandle = hide
        makeNotification()
    }
    public init(callback willShow:((CGFloat) -> Void)?, willHide:(() -> Void)?, willShowBeforeHandle show:(() -> Void)? = nil, willHideBeforeHandle hide:(() -> Void)? = nil) {
        self.willShowCallback = willShow
        self.willHideCallback = willHide
        self.willShowBeforeHandle = show
        self.willHideBeforeHandle = hide
        makeNotification()
    }
    public init() {
        makeNotification()
    }
}


extension CD_Keyboard {
    private func makeNotification() {
        do{
            let ob = NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: nil) { [weak self](n) in
                self?.keyBoardWillShow(n)
            }
            observers.append(ob)
        }
        do{
            let ob = NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: nil) { [weak self](n) in
                self?.keyBoardWillHide(n)
            }
            observers.append(ob)
        }
    }
    
    private func keyBoardWillShow(_ note:Notification) {
        willShowBeforeHandle?()
        guard let userInfo  = note.userInfo else { return }
        guard let keyBoardBounds = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        let duration:TimeInterval = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval ?? 0.25
        let hh = keyBoardBounds.size.height
        let curve = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt
        let options = (curve != nil) ? UIView.AnimationOptions(rawValue: curve!) : [.layoutSubviews, .allowUserInteraction , .beginFromCurrentState]
        UIView.animate(withDuration: duration, delay: 0, options: options, animations: {[weak self] in
            self?.willShowCallback?(hh)
        }, completion: nil)
    }
    
    private func keyBoardWillHide(_ note:Notification)
    {
        willHideBeforeHandle?()
        guard let userInfo  = note.userInfo else { return }
        let duration:TimeInterval = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval ?? 0.25
        let curve = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt
        let options = (curve != nil) ? UIView.AnimationOptions(rawValue: curve!) : [.layoutSubviews, .allowUserInteraction , .beginFromCurrentState]
        UIView.animate(withDuration: duration, delay: 0, options: options, animations: {[weak self] in
            self?.willHideCallback?()
        }, completion: nil)
    }
}
