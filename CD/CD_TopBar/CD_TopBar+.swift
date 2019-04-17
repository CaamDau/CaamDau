//Created  on 2019/3/25 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 *
 */




import UIKit
import SnapKit


public extension CD_TopBar {
    struct StopKeys {
        static var changeAlphaStop = "CD_TopBar_ChangeAlphaStop"
        static var hiddenNavigationBarStop = "CD_TopBar_HiddenNavigationBarStop"
        static var hiddenNavigationBarAnimateStop = "CD_TopBar_HiddenNavigationBarAnimateStop"
    }
    var changeAlphaStop:Bool {
        set{
            objc_setAssociatedObject(self, &CD_TopBar.StopKeys.changeAlphaStop, "\(newValue)", objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN)
        }
        get{
            return (objc_getAssociatedObject(self, &CD_TopBar.StopKeys.changeAlphaStop) as? String ?? "0").boolValue
        }
    }
    var hiddenNavigationBarStop:Bool {
        set{
            objc_setAssociatedObject(self, &CD_TopBar.StopKeys.hiddenNavigationBarStop, "\(newValue)", objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN)
        }
        get{
            return (objc_getAssociatedObject(self, &CD_TopBar.StopKeys.hiddenNavigationBarStop) as? String ?? "0").boolValue
        }
    }
    var hiddenNavigationBarAnimateStop:Bool {
        set{
            objc_setAssociatedObject(self, &CD_TopBar.StopKeys.hiddenNavigationBarAnimateStop, "\(newValue)", objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN)
        }
        get{
            return (objc_getAssociatedObject(self, &CD_TopBar.StopKeys.hiddenNavigationBarAnimateStop) as? String ?? "0").boolValue
        }
    }
    
    
    /// 改变TopBar 透明度
    func change(alpha offset:CGFloat, maxOffset:CGFloat, block:((_ alpha:CGFloat)->Void)? = nil) {
        //滑动太快，offset直接跳过了0 划过
        if offset<0 && !self.changeAlphaStop {
            let alpha:CGFloat = 0.0
            //回调
            block?(alpha)
            self.changeAlphaStop = true
            return
        }
        //滑动太快，offset直接跳过了maxOffset 划过
        if offset>maxOffset && !self.changeAlphaStop {
            let alpha:CGFloat = 1.0
            block?(alpha)
            self.changeAlphaStop = true
            return
        }
        //正常滑动
        if offset>=0 && offset<=maxOffset {
            self.changeAlphaStop = false
            let alpha:CGFloat = 1.0 - ((maxOffset - offset) / maxOffset);
            //回调
            block?(alpha)
        }
    }
    
    
    /// 隐藏导航栏
    func hidden(navigationBar offset:CGFloat) {
        //滑动太快，offset直接跳过了0 划过
        if offset>0 && !self.hiddenNavigationBarStop {
            self.hidden(navigationBar: false)
            self.hiddenNavigationBarStop = true
            return
        }
        //滑动太快，offset直接跳过了maxOffset 划过
        if offset < -CD_TopBar.Model.height_navigation && !self.hiddenNavigationBarStop {
            self.hidden(navigationBar: true)
            self.hiddenNavigationBarStop = true
            return
        }
        //正常滑动
        if offset >= -CD_TopBar.Model.height_navigation && offset <= 0 {
            self.hiddenNavigationBarStop = false
            self.bar_navigation.snp.updateConstraints { (make) in
                make.top.equalTo(bar_status.snp.bottom).offset(offset)
            }
        }
    }
    
    /*
     func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
     if velocity.y > 1.0 {
     self.tapBar.hidden(navigationBar: true)
     }else if velocity.y < -1.0 {
     self.tapBar.hidden(navigationBar: false)
     }
     }
     */
    /// 隐藏导航栏
    public func hidden(navigationBar hidden:Bool, duration:TimeInterval = 0.3, needsUpdate:(() -> Void)? = nil, animations:(() -> Void)? = nil, completion:((Bool) -> Void)? = nil) {
        guard !self.hiddenNavigationBarAnimateStop else {return}
        self.hiddenNavigationBarAnimateStop = true
        self.superview?.setNeedsLayout()
        self.bar_navigation.snp.updateConstraints { (make) in
            make.top.equalTo(bar_status.snp.bottom).offset(hidden ? -CD_TopBar.Model.height_navigation : 0)
        }
        needsUpdate?()
        UIView.animate(withDuration: duration, animations: {
            [weak self] in
            self?.superview?.layoutIfNeeded()
            animations?()
        }) { [weak self](bool) in
            self?.hiddenNavigationBarAnimateStop = false
            completion?(bool)
        }
    }
}
