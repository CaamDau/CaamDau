//Created  on 2019/4/13 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 *
 */




import Foundation
import UIKit

class CD_Page {
    
}





//MARK:--- CD_PageProtocol ----------
/*
 * 分页控制器
 */
public protocol CD_PageProtocol: NSObjectProtocol {
    /// 正在滑动
    func scroll(didScroll view:UIScrollView)
    /// 滑动结束
    func scroll(didEndScrollingAnimation view:UIScrollView)
    /// 滑动结束 手势导致
    func scroll(didEndDecelerating view:UIScrollView)
    /// 滑动视图，当手指离开屏幕那一霎那
    func scroll(didEndDragging view:UIScrollView)
    /// 开始滑动
    func scroll(willBeginDragging view:UIScrollView)
}


//MARK:--- CD_PageViewProtocol ----------
/*
 * 分页页面，轮播视图
 */
