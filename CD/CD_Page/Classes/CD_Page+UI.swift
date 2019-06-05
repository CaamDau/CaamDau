//Created  on 2019/5/29 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 *
 */




import Foundation
import FDFullscreenPopGesture
import CD
public class CD_PageUICollectionView: UICollectionView, UIGestureRecognizerDelegate {
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return self.cd.panBack(gestureRecognizer, otherGesture: otherGestureRecognizer)
    }
}

public class CD_PageUIScrollView: UIScrollView, UIGestureRecognizerDelegate {
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return self.cd.panBack(gestureRecognizer, otherGesture: otherGestureRecognizer)
    }
}

