//Created  on 2018/12/6  by LCD :https://github.com/liucaide .

/***** 模块文档 *****
 * CD_Row UI 排版组件
 */







import UIKit
import Foundation

//MARK:-------------------- 新的 表单协议 --------------------

public typealias CD_RowDidSelectBlock = () -> Void
public typealias CD_RowCallBack = (Any?) -> Void
public typealias CD_RowCompletionHandle = (Any?) -> (Any?)

//MARK:--- UI 数据源和配置协议 ----------
public typealias CD_UIDataSourceConfigModel = CD_UIDataSource & CD_UIConfigModel
//MARK:--- UI 数据源协议， ----------
public protocol CD_UIDataSource {
    associatedtype DataSource
    var dataSource:DataSource? { set get }
    func row_update(dataSource data: DataSource)
}
extension CD_UIDataSource {
    /// 部分地方是不需要用到的，需要使用到的地方重写即可
    public var dataSource: DataSource? {
        get { return nil }
        set {}
    }
    func row_update(dataSource data: DataSource) {}
}
//MARK:--- UI 配置协议， ----------
public protocol CD_UIConfigModel {
    associatedtype ConfigModel
    var config:ConfigModel? { set get }
    func row_update(config data: ConfigModel)
}
extension CD_UIConfigModel {
    /// 部分地方是不需要用到的，需要使用到的地方重写即可
    public var config: ConfigModel? {
        get { return nil }
        set {}
    }
    func row_update(config data: ConfigModel){}
}




//MARK:--- UI 协议 ----------
public protocol CD_UIProtocol {
    var dataSource:Any? { set get }
    var config:Any? { set get }
    var bundleFrom:String? { get }
    var autoLayout:Bool { get }
    var frame:CGRect { set get }
    var x:CGFloat { set get }
    var y:CGFloat { set get }
    var w:CGFloat { set get }
    var h:CGFloat { set get }
    var size:CGSize { set get }
    var insets:UIEdgeInsets { set get }
    var insetsTitle:UIEdgeInsets { set get }
    var callBack:CD_RowCallBack?{ set get }
    var tapBlock:CD_RowDidSelectBlock?{ set get }
    func bind(_ obj: AnyObject)
}

extension CD_UIProtocol {
    //public var dataSource: Any? { set{} get{ return nil} }
    //public var config: Any? { set{} get{ return nil} }
    public var bundleFrom: String? { return nil }
    public var autoLayout: Bool { return true }
    public var frame: CGRect { set{} get{ return .zero }}
    public var x:CGFloat {
        get{ return frame.origin.x }
        set{ frame.origin.x = newValue }
    }
    public var y:CGFloat{
        get{ return frame.origin.y }
        set{ frame.origin.y = newValue }
    }
    public var w:CGFloat{
        get{ return frame.size.width }
        set{ frame.size.width = newValue }
    }
    public var h:CGFloat{
        get{ return frame.size.height }
        set{ frame.size.height = newValue }
    }
    public var size:CGSize{
        get{ return frame.size }
        set{ frame.size = newValue }
    }
    public var insets:UIEdgeInsets{ set{} get{ return .zero }}
    public var insetsTitle:UIEdgeInsets{ set{} get{ return .zero }}
    
    public var callBack:CD_RowCallBack?{ set{} get{ return nil} }
    public var tapBlock:CD_RowDidSelectBlock?{ set{} get{ return nil} }
    
    public func bind(_ obj: AnyObject) {
        
    }
}

//MARK:--- UI 控制器 ViewControllers 列表协议， ----------
public protocol CD_RowVCProtocol: CD_UIProtocol {
    var vc:UIViewController { get }
    var view:UIView { get }
}
extension CD_RowVCProtocol {
    public var view:UIView { get{ return vc.view} }
    public var dataSource: Any? { set{} get{ return nil} }
    public var config: Any? { set{} get{ return nil} }
}

public protocol CD_UIViewControllerProtocol: CD_UIDataSourceConfigModel {
    /// UIViewController 使用此方法初始化
    static func row_init(withDataSource dataSource:DataSource?, config:ConfigModel?, callBack:CD_RowCallBack?, tapBlock:CD_RowDidSelectBlock?) -> UIViewController
    
    
}
extension CD_UIViewControllerProtocol {
    //    public static func row_init(withDataSource dataSource:DataSource? = nil, config:ConfigModel? = nil, callBack:CD_RowCallBack? = nil, tapBlock:CD_RowDidSelectBlock? = nil) -> UIViewController {
    //        return UIViewController()
    //    }
    public func row_update(config data: ConfigModel) {
        
    }
    public func row_update(dataSource data: DataSource) {
        
    }
}


public protocol CD_RowViewProtocol: CD_UIProtocol {
    var view:UIView { get }
    func row_show(withSuperView vv:UIView, callBack:((UIView)->Void)?)
}
extension CD_RowViewProtocol {
    public var dataSource: Any? { set{} get{ return nil} }
    public var config: Any? { set{} get{ return nil} }
    public func row_show(withSuperView vv:UIView, callBack:((UIView)->Void)? = nil) {
        vv.addSubview(view)
        callBack?(view)
    }
}


public protocol CD_UIViewProtocol: CD_UIDataSourceConfigModel {
    /// UIView 使用此方法初始化
    static func row_init(withDataSource dataSource:DataSource?, config:ConfigModel?, callBack:CD_RowCallBack?, tapBlock:CD_RowDidSelectBlock?) -> UIView
    
    
}
extension CD_UIViewProtocol {
    //    public static func row_init(withDataSource dataSource:DataSource? = nil, config:ConfigModel? = nil, callBack:CD_RowCallBack? = nil, tapBlock:CD_RowDidSelectBlock? = nil) -> UIView {
    //        return UIView()
    //    }
    public func row_update(config data: ConfigModel) {
        
    }
    public func row_update(dataSource data: DataSource) {
        
    }
    
    
}


//MARK:--- UI 控制器 ViewControllers 协议关联模型 ----------
public struct CD_RowVC<T:CD_UIViewControllerProtocol>:CD_RowVCProtocol where T:UIViewController {
    public var vc:UIViewController
    public var _dataSource:T.DataSource?
    public var _config:T.ConfigModel?
    public var frame:CGRect
    public var autoLayout:Bool
    public init(dataSource:T.DataSource? = nil,
                config:T.ConfigModel? = nil,
                frame:CGRect = .zero,
                autoLayout:Bool = true,
                callBack:CD_RowCallBack? = nil,
                tapBlock:CD_RowDidSelectBlock? = nil) {
        self.vc = T.row_init(withDataSource: dataSource, config: config, callBack:callBack, tapBlock:tapBlock)
        self._dataSource = dataSource
        self._config = config
        self.frame = frame
        self.autoLayout = autoLayout
    }
    public func bind(_ obj: AnyObject) {
        guard let item = obj as? T else {
            return
        }
        if let m = _config {
            item.row_update(config: m)
        }
        if let d = _dataSource {
            item.row_update(dataSource:d)
        }
    }
    
    public var dataSource: Any? {
        set{
            _dataSource = newValue as? T.DataSource
        }
        get{
            return _dataSource
        }
    }
    public var config: Any? {
        set{
            _config = newValue as? T.ConfigModel
        }
        get{
            return _config
        }
    }
}


//MARK:--- UI View 协议关联模型 ----------
public struct CD_RowView<T:CD_UIViewProtocol>: CD_RowViewProtocol where T:UIView {
    public var view:UIView
    public var _dataSource:T.DataSource?
    public var _config:T.ConfigModel?
    public var frame:CGRect
    public var autoLayout:Bool
    public init(dataSource:T.DataSource? = nil,
                config:T.ConfigModel? = nil,
                frame:CGRect = .zero,
                autoLayout:Bool = true,
                callBack:CD_RowCallBack? = nil,
                tapBlock:CD_RowDidSelectBlock? = nil) {
        self.view = T.row_init(withDataSource: dataSource, config: config, callBack:callBack, tapBlock:tapBlock)
        
        self._dataSource = dataSource
        self._config = config
        self.frame = frame
        self.autoLayout = autoLayout
    }
    
    public func bind(_ obj: AnyObject) {
        guard let item = obj as? T else {return}
        if let m = _config {
            item.row_update(config: m)
        }
        if let d = _dataSource {
            item.row_update(dataSource:d)
        }
    }
    
    public var dataSource: Any? {
        set{
            _dataSource = newValue as? T.DataSource
        }
        get{
            return _dataSource
        }
    }
    public var config: Any? {
        set{
            _config = newValue as? T.ConfigModel
        }
        get{
            return _config
        }
    }
}
/// CD_RowView 引用类型  一般用上面的 struct
public class CD_RowViewClass<T:CD_UIViewProtocol>: CD_RowViewProtocol where T:UIView {
    public var view:UIView
    public var _dataSource:T.DataSource?
    public var _config:T.ConfigModel?
    public var frame:CGRect
    public var autoLayout:Bool
    public init(dataSource:T.DataSource? = nil,
                config:T.ConfigModel? = nil,
                frame:CGRect = .zero,
                autoLayout:Bool = true,
                callBack:CD_RowCallBack? = nil,
                tapBlock:CD_RowDidSelectBlock? = nil) {
        self.view = T.row_init(withDataSource: dataSource, config: config, callBack:callBack, tapBlock:tapBlock)
        
        self._dataSource = dataSource
        self._config = config
        self.frame = frame
        self.autoLayout = autoLayout
    }
    
    public func bind(_ obj: AnyObject) {
        guard let item = obj as? T else {return}
        if let m = _config {
            item.row_update(config: m)
        }
        if let d = _dataSource {
            item.row_update(dataSource:d)
        }
    }
    public var dataSource: Any? {
        set{
            _dataSource = newValue as? T.DataSource
        }
        get{
            return _dataSource
        }
    }
    public var config: Any? {
        set{
            _config = newValue as? T.ConfigModel
        }
        get{
            return _config
        }
    }
}


//MARK:--- TableViewCell CollectionViewCell 协议 ----------
public protocol CD_CellProtocol:CD_UIProtocol {
    var cellId: String { get }
    var cellClass:AnyClass { get }
}
//MARK:---  数据源更新协议 ---
public protocol CD_RowCellUpdateProtocol:CD_UIDataSourceConfigModel {
    func row_update(callBack block:CD_RowCallBack?)
}
extension CD_RowCellUpdateProtocol {
    public func row_update(config data: ConfigModel) {}
    public func row_update(dataSource data: DataSource) {}
    public func row_update(callBack block:CD_RowCallBack?) {}
}

public struct CD_RowCell<T:CD_RowCellUpdateProtocol>:CD_CellProtocol where T: UIView {
    public var cellId: String
    public var cellClass:AnyClass
    public var _dataSource:T.DataSource?
    public var _config:T.ConfigModel?
    public var bundleFrom:String?
    public var frame:CGRect
    public var insets:UIEdgeInsets
    public var insetsTitle:UIEdgeInsets
    public var callBack:CD_RowCallBack?
    public var _didSelect:CD_RowDidSelectBlock?
    /*
     data  ：View Data 数据源
     id    ：View Id 标识 输入空则默认以类名 viewClass 为标识
     tag   ：View Tag 标签 - 同类不同数据源或同控件不同UI展示效果做区分
     frame ：View frame 数据源
     insets  ：View UIButton imageEdgeInsets | UICollectionView sectionInset
     另 UICollectionView LineSpacing InteritemSpacing 使用 frame - x  y
     insetsTitle  ：View UIButton titleEdgeInsets
     bundleFrom ：View bundle 索引（组件化 | pod   nib 资源。。。。）
     callBack ： View 类内执行回调
     didSelect ： View 点击回调 UITableView | UICollectionView didSelectRow
     */
    public init(data: T.DataSource? = nil,
                config:T.ConfigModel? = nil,
                id: String? = nil,
                frame:CGRect = .zero,
                insets:UIEdgeInsets = .zero,
                insetsTitle:UIEdgeInsets = .zero,
                bundleFrom:String = "",
                callBack:CD_RowCallBack? = nil,
                didSelect:CD_RowDidSelectBlock? = nil) {
        self._dataSource = data
        self._config = config
        self.cellClass = T.self
        self.cellId = id ?? String(describing: T.self)
        self.frame = frame
        self.bundleFrom = bundleFrom
        self.insets = insets
        self.insetsTitle = insetsTitle
        self.callBack = callBack
        self._didSelect = didSelect
    }
    
    public func bind(_ obj: AnyObject) {
        guard let item = obj as? T else {return}
        if let m = _config {
            item.row_update(config: m)
        }
        if let d = _dataSource {
            item.row_update(dataSource:d)
        }
        if let back = callBack  {
            item.row_update(callBack: back)
        }
    }
    public var dataSource: Any? {
        set{
            _dataSource = newValue as? T.DataSource
        }
        get{
            return _dataSource
        }
    }
    public var config: Any? {
        set{
            _config = newValue as? T.ConfigModel
        }
        get{
            return _config
        }
    }
}
extension CD_RowCell {
    public var tapBlock: CD_RowDidSelectBlock? {
        get { return _didSelect}
        set { _didSelect = newValue}
    }
}
/// CD_RowCell 引用类型  一般用上面的 struct
public class CD_RowCellClass<T:CD_RowCellUpdateProtocol>:CD_CellProtocol where T: UIView {
    public var cellId: String
    public var cellClass:AnyClass
    public var _dataSource:T.DataSource?
    public var _config:T.ConfigModel?
    public var bundleFrom:String?
    public var frame:CGRect
    public var insets:UIEdgeInsets
    public var insetsTitle:UIEdgeInsets
    public var callBack:CD_RowCallBack?
    public var _didSelect:CD_RowDidSelectBlock?
    /*
     data  ：View Data 数据源
     id    ：View Id 标识 输入空则默认以类名 viewClass 为标识
     tag   ：View Tag 标签 - 同类不同数据源或同控件不同UI展示效果做区分
     frame ：View frame 数据源
     insets  ：View UIButton imageEdgeInsets | UICollectionView sectionInset
     另 UICollectionView LineSpacing InteritemSpacing 使用 frame - x  y
     insetsTitle  ：View UIButton titleEdgeInsets
     bundleFrom ：View bundle 索引（组件化 | pod   nib 资源。。。。）
     callBack ： View 类内执行回调
     didSelect ： View 点击回调 UITableView | UICollectionView didSelectRow
     */
    public init(data: T.DataSource? = nil,
                config:T.ConfigModel? = nil,
                id: String? = nil,
                frame: CGRect = .zero,
                insets:UIEdgeInsets = .zero,
                insetsTitle:UIEdgeInsets = .zero,
                bundleFrom:String = "",
                callBack:CD_RowCallBack? = nil,
                didSelect:CD_RowDidSelectBlock? = nil) {
        self._dataSource = data
        self._config = config
        self.cellClass = T.self
        self.cellId = id ?? String(describing: T.self)
        self.frame = frame
        self.bundleFrom = bundleFrom
        self.insets = insets
        self.insetsTitle = insetsTitle
        self.callBack = callBack
        self._didSelect = didSelect
    }
    
    public func bind(_ obj: AnyObject) {
        guard let item = obj as? T else {return}
        if let m = _config {
            item.row_update(config: m)
        }
        if let d = _dataSource {
            item.row_update(dataSource:d)
        }
        if let back = callBack  {
            item.row_update(callBack: back)
        }
    }
    public var dataSource: Any? {
        set{
            _dataSource = newValue as? T.DataSource
        }
        get{
            return _dataSource
        }
    }
    public var config: Any? {
        set{
            _config = newValue as? T.ConfigModel
        }
        get{
            return _config
        }
    }
}
extension CD_RowCellClass {
    public var tapBlock: CD_RowDidSelectBlock? {
        get { return _didSelect}
        set { _didSelect = newValue}
    }
}








//MARK:--- ------------------- 旧的 表单 协议 --------------------
/*
//MARK:---  单元格配置协议 ---
/// 旧的协议，弃用
@available(*, deprecated, message: "旧的协议，弃用")
public protocol CD_RowProtocol {
    var tag:Int { get }
    var viewId: String { get }
    var viewClass:AnyClass { get }
    var bundleFrom:String { get }
    var datas: Any { set get }
    var frame: CGRect { set get }
    var x:CGFloat { set get }
    var y:CGFloat { set get }
    var w:CGFloat { set get }
    var h:CGFloat { set get }
    var size:CGSize { set get }
    var insets:UIEdgeInsets { set get }
    var insetsTitle:UIEdgeInsets { set get }
    var callBack:CD_RowCallBack?{ set get }
    var didSelect:CD_RowDidSelectBlock?{ set get }
    func bind(_ view: AnyObject)
}

//MARK:---  数据源更新协议 ---
/// 旧的协议，弃用
@available(*, deprecated, message: "旧的协议，弃用")
public protocol CD_RowUpdateProtocol {
    /// 数据源 关联类型
    associatedtype DataSource
    func row_update(_ data: DataSource, id:String, tag:Int, frame:CGRect, callBack:CD_RowCallBack?)
}
public extension CD_RowUpdateProtocol{
    func row_update(_ data: DataSource, id:String , tag:Int, frame:CGRect, callBack:CD_RowCallBack?) {}
}


//MARK:---  建设单元格模型 ---
/// 旧的协议，弃用
@available(*, deprecated, message: "旧的协议，弃用")
public struct CD_Row<T> where T: UIView, T: CD_RowUpdateProtocol {
    public var data: T.DataSource
    public let id: String
    public var tag:Int
    public var frame: CGRect
    public let viewClass:AnyClass = T.self
    public let bundleFrom:String
    public var callBack:CD_RowCallBack? = nil
    public var didSelect:CD_RowDidSelectBlock? = nil
    public var insets:UIEdgeInsets
    public var insetsTitle:UIEdgeInsets
    
    /*
     data  ：View Data 数据源
     id    ：View Id 标识 输入空则默认以类名 viewClass 为标识
     tag   ：View Tag 标签 - 同类不同数据源或同控件不同UI展示效果做区分
     frame ：View frame 数据源
     insets  ：View UIButton imageEdgeInsets | UICollectionView sectionInset
     另 UICollectionView LineSpacing InteritemSpacing 使用 frame - x  y
     insetsTitle  ：View UIButton titleEdgeInsets
     bundleFrom ：View bundle 索引（组件化 | pod   nib 资源。。。。）
     callBack ： View 类内执行回调
     didSelect ： View 点击回调 UITableView | UICollectionView didSelectRow
     */
    public init(data: T.DataSource,
                id: String = "",
                tag:Int = 0,
                frame: CGRect = .zero,
                insets:UIEdgeInsets = .zero,
                insetsTitle:UIEdgeInsets = .zero,
                bundleFrom:String = "",
                callBack:CD_RowCallBack? = nil,
                didSelect:CD_RowDidSelectBlock? = nil) {
        self.data = data
        self.id = id
        self.frame = frame
        self.tag = tag
        self.bundleFrom = bundleFrom
        self.callBack = callBack
        self.didSelect = didSelect
        self.insets = insets
        self.insetsTitle = insetsTitle
    }
}

extension CD_Row:CD_RowProtocol {
    // 单元格模型绑定单元格实例
    public func bind(_ view: AnyObject) {
        if let v = view as? T {
            v.row_update(self.data, id:self.id, tag:self.tag, frame:self.frame, callBack:self.callBack)
        }
    }
}

//MARK:--- 附加 ---
extension CD_Row {
    public var viewId:String {
        get{
            return id=="" ? String(describing: viewClass) : id
        }
    }
    public var datas: Any {
        get { return data }
        set { data = newValue as! T.DataSource }
    }
    public var x:CGFloat {
        get{ return frame.origin.x }
        set{ frame.origin.x = newValue }
    }
    public var y:CGFloat{
        get{ return frame.origin.y }
        set{ frame.origin.y = newValue }
    }
    public var w:CGFloat{
        get{ return frame.size.width }
        set{ frame.size.width = newValue }
    }
    public var h:CGFloat{
        get{ return frame.size.height }
        set{ frame.size.height = newValue }
    }
    public var size:CGSize{
        get{ return frame.size }
        set{ frame.size = newValue }
    }
}


//MARK:--- CD_RowClass 对象 ----------
/// 旧的协议，弃用
@available(*, deprecated, message: "旧的协议，弃用")
public class CD_RowClass<T> where T: UIView, T: CD_RowUpdateProtocol {
    public var data: T.DataSource
    public let id: String
    public var tag:Int
    public var frame: CGRect
    public let viewClass:AnyClass = T.self
    public let bundleFrom:String
    public var callBack:CD_RowCallBack? = nil
    public var didSelect:CD_RowDidSelectBlock? = nil
    public var insets:UIEdgeInsets
    public var insetsTitle:UIEdgeInsets
    
    /*
     data  ：View Data 数据源
     id    ：View Id 标识 输入空则默认以类名 viewClass 为标识
     tag   ：View Tag 标签 - 同类不同数据源或同控件不同UI展示效果做区分
     frame ：View frame 数据源
     insets  ：View UIButton imageEdgeInsets | UICollectionView sectionInset
     另 UICollectionView LineSpacing InteritemSpacing 使用 frame - x  y
     insetsTitle  ：View UIButton titleEdgeInsets
     bundleFrom ：View bundle 索引（组件化 | pod   nib 资源。。。。）
     callBack ： View 类内执行回调
     didSelect ： View 点击回调 UITableView | UICollectionView didSelectRow
     */
    public init(data: T.DataSource,
                id: String = "",
                tag:Int = 0,
                frame: CGRect = .zero,
                insets:UIEdgeInsets = .zero,
                insetsTitle:UIEdgeInsets = .zero,
                bundleFrom:String = "",
                callBack:CD_RowCallBack? = nil,
                didSelect:CD_RowDidSelectBlock? = nil) {
        self.data = data
        self.id = id
        self.frame = frame
        self.tag = tag
        self.bundleFrom = bundleFrom
        self.callBack = callBack
        self.didSelect = didSelect
        self.insets = insets
        self.insetsTitle = insetsTitle
    }
}
extension CD_RowClass:CD_RowProtocol {
    // 单元格模型绑定单元格实例
    public func bind(_ view: AnyObject) {
        if let v = view as? T {
            //if v.conforms(to: CD_RowUpdateProtocol.self)
            v.row_update(self.data, id:self.id, tag:self.tag, frame:self.frame, callBack:self.callBack)
        }
    }
}
//MARK:--- 附加 ---
extension CD_RowClass {
    public var viewId:String {
        get{
            return id=="" ? String(describing: viewClass) : id
        }
    }
    public var datas: Any {
        get { return data }
        set { data = newValue as! T.DataSource }
    }
    public var x:CGFloat {
        get{ return frame.origin.x }
        set{ frame.origin.x = newValue }
    }
    public var y:CGFloat{
        get{ return frame.origin.y }
        set{ frame.origin.y = newValue }
    }
    public var w:CGFloat{
        get{ return frame.size.width }
        set{ frame.size.width = newValue }
    }
    public var h:CGFloat{
        get{ return frame.size.height }
        set{ frame.size.height = newValue }
    }
    public var size:CGSize{
        get{ return frame.size }
        set{ frame.size = newValue }
    }
}

*/
