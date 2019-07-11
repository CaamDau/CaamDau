//Created  on 2019/5/29 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 *
 */




import Foundation
import FDFullscreenPopGesture


//MARK:--- 手势同时识别 实现 多个 ScrollView 层叠联动 ----------
public protocol CD_RecognizeSimultaneously: UIGestureRecognizerDelegate {
}
extension CD_RecognizeSimultaneously {
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}


@IBDesignable
public class CD_PageUICollectionView: UICollectionView {
}
extension CD_PageUICollectionView: CD_RecognizeSimultaneously {
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return self.cd.panBack(gestureRecognizer, otherGesture: otherGestureRecognizer)
    }
}

@IBDesignable
public class CD_PageUIScrollView: UIScrollView {
}
extension CD_PageUIScrollView: CD_RecognizeSimultaneously {
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return self.cd.panBack(gestureRecognizer, otherGesture: otherGestureRecognizer)
    }
}





@IBDesignable
public class CD_RecognizeSimultaneouslyScrollView: UIScrollView {}
extension CD_RecognizeSimultaneouslyScrollView: CD_RecognizeSimultaneously {}

@IBDesignable
public class CD_RecognizeSimultaneouslyCollectionView: UICollectionView {}
extension CD_RecognizeSimultaneouslyCollectionView: CD_RecognizeSimultaneously {}


@IBDesignable
public class CD_RecognizeSimultaneouslyTableView: UITableView {}
extension CD_RecognizeSimultaneouslyTableView: CD_RecognizeSimultaneously {}


@IBDesignable
public class CD_IgnoreHeaderTouchTableView: UITableView {
    open lazy var ignoreHeaderFrame: CGRect = {
        return self.tableHeaderView?.frame ?? .zero
    }()
    
    public override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        if self.tableHeaderView != nil
            && self.ignoreHeaderFrame.contains(point) {
            return false
        }
        return super.point(inside: point, with: event)
    }
}

@IBDesignable
public class CD_IgnoreHeaderTouchRecognizeSimultaneouslTableView: CD_IgnoreHeaderTouchTableView {
}
extension CD_IgnoreHeaderTouchRecognizeSimultaneouslTableView: CD_RecognizeSimultaneously {
}
