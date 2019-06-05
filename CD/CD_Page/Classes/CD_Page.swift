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
        public var isScrollPaging:Bool = true
        public var scrollBounces:Bool = false
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
    func scroll(didScroll view:UIScrollView, contentOffset:CGFloat, offsetRatio:CGFloat, size:CGFloat, index:Int)
    /// 滑动结束
    func scroll(didEndScrollingAnimation view:UIScrollView, index:Int, animotion:Bool)
    /// 滑动结束 手势导致
    func scroll(didEndDecelerating view:UIScrollView, index:Int)
    /// 滑动视图，当手指离开屏幕那一霎那
    func scroll(didEndDragging view:UIScrollView, index:Int)
    /// 开始滑动
    func scroll(willBeginDragging view:UIScrollView, offset:CGFloat)
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
    func scrolling(_ offset:CGFloat, index:Int)
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
    func scroll(didScroll view: UIScrollView?, contentOffset:CGFloat, offsetRatio:CGFloat, size:CGFloat, index:Int, offsetItemWidthScale scale:CGFloat, scrollDirection:CD_Page.Model.ScrollDirection)
    func scroll(endScroll view: UIScrollView?, index:Int, item:UIView?, scrollDirection:CD_Page.Model.ScrollDirection, animotion:Bool)
    func scroll(willBeginDragging view: UIScrollView?, offset:CGFloat)
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






//MARK:--- UI 协议， 子控制器需遵循此协议， ----------
public typealias CD_UIDataSourceConfigModel = CD_UIDataSource & CD_UIConfigModel
//MARK:--- 内容控制器协议， 子控制器需遵循此协议， ----------
public protocol CD_UIDataSource {
    associatedtype DataSource
    var dataSource:DataSource? { set get }
}
extension CD_UIDataSource {
    public var dataSource: DataSource? {
        get { return nil }
        set {}
    }
}
//MARK:--- 内容控制器协议， 子控制器需遵循此协议， ----------
public protocol CD_UIConfigModel {
    associatedtype ConfigModel
    var config:ConfigModel? { set get }
}
extension CD_UIConfigModel {
    public var config: ConfigModel? {
        get { return nil }
        set {}
    }
}

//MARK:--- 内容控制器协议， 子控制器需遵循此协议， ----------
public protocol CD_UIProtocol {
    var dataSource:Any? { set get }
    var config:Any? { set get }
    var frame:CGRect { set get }
    var autoLayout:Bool { get }
}
public protocol CD_RowVCProtocol: CD_UIProtocol {
    var vc:UIViewController { get }
    var view:UIView { get }
}
public protocol CD_RowViewProtocol: CD_UIProtocol {
    var view:UIView { get }
}

public protocol CD_UIViewControllerProtocol: CD_UIDataSourceConfigModel {
    
    /// UIViewController 使用此方法初始化
    static func initialize(withDataSource dataSource:DataSource?, config:ConfigModel?) -> UIViewController
}
public protocol CD_UIViewProtocol: CD_UIDataSourceConfigModel {
    var view:UIView { get }
    /// UIView 使用此方法初始化
    static func initialize(withDataSource dataSource:DataSource?, config:ConfigModel?) -> UIView
}




public struct CD_RowVC<T> where T:CD_UIViewControllerProtocol {
    let _vc:UIViewController
    let _view:UIView
    var _dataSource:T.DataSource?
    var _config:T.ConfigModel?
    var _frame:CGRect
    var _autoLayout:Bool
    init(dataSource:T.DataSource? = nil,
         config:T.ConfigModel? = nil,
         size:CGSize = .zero,
         autoLayout:Bool = true) {
        self._vc = T.initialize(withDataSource: dataSource, config: config)
        self._view = _vc.view
        self._dataSource = dataSource
        self._config = config
        self._frame = CGRect(w: size.width, h: size.height)
        self._autoLayout = autoLayout
    }
}

extension CD_RowVC: CD_RowVCProtocol {
    public var autoLayout: Bool {
        return _autoLayout
    }
    
    public var dataSource: Any? {
        get {
            return _dataSource
        }
        set {
            _dataSource = dataSource as? T.DataSource ?? nil
        }
    }
    
    public var config: Any? {
        get {
            return _config
        }
        set {
            _config = config as? T.ConfigModel ?? nil
        }
    }
    public var frame: CGRect {
        get {
            return _frame
        }
        set {
            _frame = frame
        }
    }
    public var vc: UIViewController {
        return _vc
    }
    public var view: UIView {
        return _view
    }
}
public struct CD_RowView<T> where T:CD_UIViewProtocol {
    let _view:UIView
    var _dataSource:T.DataSource?
    var _config:T.ConfigModel?
    var _frame:CGRect
    var _autoLayout:Bool
    init(dataSource:T.DataSource? = nil,
         config:T.ConfigModel? = nil,
         size:CGSize = .zero,
         autoLayout:Bool = true) {
        self._view = T.initialize(withDataSource: dataSource, config: config)
        self._dataSource = dataSource
        self._config = config
        self._frame = CGRect(w: size.width, h: size.height)
        self._autoLayout = autoLayout
    }
}

extension CD_RowView: CD_RowViewProtocol {
    public var autoLayout: Bool {
        return _autoLayout
    }
    
    public var dataSource: Any? {
        get {
            return _dataSource
        }
        set {
            _dataSource = dataSource as? T.DataSource ?? nil
        }
    }
    
    public var config: Any? {
        get {
            return _config
        }
        set {
            _config = config as? T.ConfigModel ?? nil
        }
    }
    public var frame: CGRect {
        get {
            return _frame
        }
        set {
            _frame = frame
        }
    }
    public var view: UIView {
        return _view
    }
}
