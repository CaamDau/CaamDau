//Created  on 2019/4/13 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 *
 */




import Foundation
import UIKit
public struct CD_Page {
    public struct Model {
        /// View.tag 差值
        public var offsetTag:Int = 10
        /// 间距
        public var space:CGFloat = 10
        /// 边距
        public var marge:CGFloat = 20
        ///
        public var alignment:Alignment = .leftOrTop
        
        public var scrollDirection:ScrollDirection = .horizontal
        
        public enum Alignment : Int {
            case leftOrTop
            case center
            case rightOrBottom
        }
        
        public enum ScrollDirection : Int {
            case horizontal
            case vertical
        }
        public init() {}
    }
    
    public enum Size {
        case auto
        case size(_ s:CGFloat)
        var rawValue:CGFloat {
            switch self {
            case .auto:
                return -88988
            case .size(let s):
                return s
            }
        }
    }
}


//MARK:--- CD_PageProtocol ----------
/// 分页内容控制器协议
public protocol CD_PageScrollProtocol: NSObjectProtocol {
    /// 正在滑动
    func scroll(didScroll view:UIScrollView, offset:CGFloat)
    /// 滑动结束
    func scroll(didEndScrollingAnimation view:UIScrollView, index:Int)
    /// 滑动结束 手势导致
    func scroll(didEndDecelerating view:UIScrollView, index:Int)
    /// 滑动视图，当手指离开屏幕那一霎那
    func scroll(didEndDragging view:UIScrollView, index:Int)
    /// 开始滑动
    func scroll(willBeginDragging view:UIScrollView)
}


/// 分页导航栏选中协议
public protocol CD_PageControlProtocol: NSObjectProtocol {
    func didSelect(withIndex index:Int)
}
/// 分页导航栏数据源协议
public protocol CD_PageControlDataSource {
    associatedtype DataSource
    var dataSource:DataSource { set get }
    var selectIndex:Int { set get }
    func scrollDidEnd(_ index:Int)
    func scrolling(_ offset:CGFloat)
}

/// 分页导航标签响应回调
public typealias CD_PageControlDidSelectBlock = (() -> Void)
/// 分页导航标签构造配置协议 - 自定义标签遵循此协议，默认标签：CD_PageControlItem
public protocol CD_PageControlItemProtocol {
    associatedtype DataSource
    associatedtype ConfigModel
    var dataSource:DataSource? { set get }
    var config:ConfigModel? { set get }
    var scale:CGFloat {set get}
    var id:String {set get}
    var click:CD_PageControlDidSelectBlock?{ set get }
}

/// 分页导航浮漂构造配置协议 - 自定义浮漂遵循此协议，默认浮漂：CD_PageControlBuoy
public protocol CD_PageControlBuoyProtocol {
    associatedtype ConfigModel
    var config:ConfigModel? { set get }
    func scroll(didScroll view: UIScrollView?, offset:CGFloat)
    func scroll(endScroll view: UIScrollView?, index:Int, animotion:Bool)
    func scroll(willBeginDragging view: UIScrollView?)
}

extension CD_PageControlItemProtocol {
    public var id:String {set{} get{return ""}}
    var click: CD_PageControlDidSelectBlock? {
        get { return nil }
        set {}
    }
    var config: ConfigModel? {
        get { return nil }
        set {}
    }
    var dataSource: DataSource? {
        get { return nil }
        set {}
    }
    var scale: CGFloat {
        get { return 0 }
        set {}
    }
}

//MARK:--- 内容控制器协议， 子控制器需遵循此协议， ----------
public protocol CD_PageViewControllerProtocol {
    associatedtype DataSource
    associatedtype ConfigModel
    var dataSource:DataSource? { set get }
    var config:ConfigModel? { set get }
    /// 子控制器 使用此方法初始化
    static func initialize(withDataSource dataSource:DataSource?, config:ConfigModel?) -> UIViewController
}
extension CD_PageViewControllerProtocol {
    public var config: ConfigModel? {
        get { return nil }
        set {}
    }
    public var dataSource: DataSource? {
        get { return nil }
        set {}
    }
}
