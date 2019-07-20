//Created  on 2019/7/19 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 *
 */




import Foundation
import UIKit
public class CD_Keyboard {
    weak var view:UIView?
    var observers:[NSObjectProtocol] = []
    open var willShowHandle:((CGFloat) -> Void)?
    open var willHideHandle:(() -> Void)?
    public init(view:UIView) {
        self.view = view
        self.willShowHandle = { [weak self] h in
            var bottom:CGFloat = 0.0
            if #available(iOS 11.0, *) {
                bottom = CD.window?.safeAreaInsets.bottom ?? 0
            }
            self?.view?.transform = CGAffineTransform(translationX: 0,y: -h+bottom)
        }
        self.willHideHandle = { [weak self] in
            self?.view?.transform = .identity
        }
        makeNotification()
    }
    public init(willShow:((CGFloat) -> Void)?, willHide:(() -> Void)?) {
        self.willShowHandle = willShow
        self.willHideHandle = willHide
        makeNotification()
    }
    public init() {
        makeNotification()
    }
}


extension CD_Keyboard {
    
    func makeNotification() {
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
        guard let userInfo  = note.userInfo else { return }
        guard let keyBoardBounds = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        let duration:TimeInterval = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval ?? 0.25
        let hh = keyBoardBounds.size.height
        let curve = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt
        let options = (curve != nil) ? UIView.AnimationOptions(rawValue: curve!) : [.layoutSubviews, .allowUserInteraction , .beginFromCurrentState]
        UIView.animate(withDuration: duration, delay: 0, options: options, animations: {[weak self] in
            self?.willShowHandle?(hh)
        }, completion: nil)
    }
    
    private func keyBoardWillHide(_ note:Notification)
    {
        guard let userInfo  = note.userInfo else { return }
        let duration:TimeInterval = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval ?? 0.25
        let curve = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt
        let options = (curve != nil) ? UIView.AnimationOptions(rawValue: curve!) : [.layoutSubviews, .allowUserInteraction , .beginFromCurrentState]
        UIView.animate(withDuration: duration, delay: 0, options: options, animations: {[weak self] in
            self?.willHideHandle?()
        }, completion: nil)
    }
}
