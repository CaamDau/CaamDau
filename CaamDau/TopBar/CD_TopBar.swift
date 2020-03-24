//Created  on 2019/3/23 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 * 自定义导航栏
   该导航栏由 ：整体背景(CD_TopBar)、
 
              状态栏(CD_TopStatusBar)、
              导航栏(CD_TopNavigationBar)、
              自定义栏(CD_TopCustomBar)
   每个栏可独立使用
 
   状态栏由 一个背景 ImageView + Label(prompt)组成
   导航栏由 三个 CD_TopNavigationBarItem 组成 左侧按钮区、中部标题区、右侧按钮区
   自定义栏 无任何子控件
 */




import UIKit
import SnapKit
public protocol CD_TopBarProtocol: NSObjectProtocol {
    /// TopBar 自定义
    func topBar(custom topBar:CD_TopBar)
    
    /// 新：更新按钮样式
    func topBar(_ topBar:CD_TopBar, updateItemStyleForItem item:CD_TopNavigationBar.Item) -> [CD_TopNavigationBarItem.Item.Style]?
    /// 新：按钮事件
    func topBar(_ topBar:CD_TopBar, didSelectAt item:CD_TopNavigationBar.Item)
}

extension CD_TopBarProtocol {
    /// TopBar 自定义
    public func topBar(custom topBar:CD_TopBar) {
        
    }
    
    public func topBar(_ topBar:CD_TopBar, updateItemStyleForItem item:CD_TopNavigationBar.Item) -> [CD_TopNavigationBarItem.Item.Style]? {
        return topBar.topBarItemUpdate(item)
    }
    
    public func topBar(_ topBar:CD_TopBar, didSelectAt item:CD_TopNavigationBar.Item) {
        topBar.topBarItemClick(item)
    }
}


//@IBDesignable
open class CD_TopBar: UIView {
    /// 可变统一配置全局常量
    public struct Model {
        /// 状态栏 高度
        public static var height_status:CGFloat = {
            return (CD.Device.mode == .iPhoneX ? 44 : 20) //刘海高度大约 34
        }()
        
        /// 状态栏 prompt 高度
        public static var height_prompt:CGFloat = 20
        /// 导航栏高度
        public static var height_navigation:CGFloat = 44
        /// 分割线高度
        public static var height_line:CGFloat = 0.5
        /// 标题颜色
        public static var color_title:UIColor = UIColor.cd_hex("0", dark: "f")
        /// 副标题颜色
        public static var color_subTitle:UIColor = UIColor.cd_hex("0", dark: "f")
        /// 状态栏 prompt 颜色，等同于 UINavigationC 中的 prompt
        public static var color_prompt:UIColor = UIColor.cd_hex("0", dark: "f")
        /// 左右导航标签颜色
        public static var color_normal:UIColor = UIColor.cd_hex("d3", dark: "f")
        /// 左右导航标签颜色
        public static var color_selected:UIColor = UIColor.cd_hex("ed", dark: "f")
        /// 左右导航标签颜色
        public static var color_highlighted:UIColor = UIColor.cd_hex("ed", dark: "f")
        
        /// 背景色
        public static var color_bg:UIColor = UIColor.cd_hex("f", dark: "0")
        /// 分割线颜色
        public static var color_line:UIColor = UIColor.cd_hex("ed", dark: "f0")
        /// 标题字体
        public static var font_title:UIFont = UIFont.systemFont(ofSize: 17)
        /// 副标题字体
        public static var font_subTitle:UIFont = UIFont.systemFont(ofSize: 10)
        /// 状态栏 prompt 字体，等同于 UINavigationC 中的 prompt
        public static var font_prompt:UIFont = UIFont.systemFont(ofSize: 12)
        /// 导航栏按钮字体
        public static var font_item:UIFont = UIFont.systemFont(ofSize: 17)
        
        
        /// 指定左侧默认返回按钮
        public static var back:CD_TopNavigationBarItem.Item.Style = .title([(CD_IconFont.tback_light(30).text,CD_IconFont.tback_light(30).font,.cd_hex("0", dark: "f"),.normal), (CD_IconFont.tback_light(30).text,CD_IconFont.tback_light(30).font,.cd_hex("d3", dark: "f0"),.highlighted), (CD_IconFont.tback_light(30).text,CD_IconFont.tback_light(30).font,.cd_hex("d3", dark: "f0"),.selected)])
    }
    
    
    /// 背景图片
    public lazy var img_bg:UIImageView = {
        return UIImageView().cd.clips(true).build
    }()
    /// 状态栏
    public lazy var bar_status:CD_TopStatusBar = {
        return CD_TopStatusBar().cd
            .background(_colorStatusBar)
            .build
    }()
    /// 导航栏
    public lazy var bar_navigation:CD_TopNavigationBar = {
        let bar =  CD_TopNavigationBar().cd
            .background(_bgColorNavigationBar)
            .build
        bar.delegate = self
        return bar
    }()
    /// 自定义栏
    public lazy var bar_custom:CD_TopCustomBar = {
        return CD_TopCustomBar().cd
            .background(UIColor.clear)
            .build
    }()
    
    //MARK:--- 样式 ----------
    /// 导航栏标题
    @IBInspectable open var _title:String? = "" {
        didSet{
            bar_navigation._title = _title
        }
    }
    /// 导航栏副标题
    @IBInspectable open var _subtitle:String? = "" {
        didSet{
            bar_navigation._subTitle = _subtitle
        }
    }
    /// 设置 状态栏将会拉高，高度为 20
    /// 如果不希望被拉高，或者拉高高度希望自定义，可在设置后 更新约束
    @IBInspectable open var _prompt:String? = "" {
        didSet{
            bar_status._title = _prompt ?? ""
            updateStatusPrompt()
        }
    }
    /// 导航栏样式
    @IBInspectable open var _style:String? {
        didSet{
            bar_navigation._style = _style
        }
    }
    //MARK:--- 间距 ----------
    /// 导航栏内 三个 item 的间距
    @IBInspectable open var _space:CGFloat = 0 {
        didSet{
            bar_navigation._space = _space
        }
    }
    /// 导航栏内 三个 左侧 item 的边距
    @IBInspectable open var _spaceItemLeft:CGFloat = 0 {
        didSet{
            bar_navigation._spaceLeft = _spaceItemLeft
        }
    }
    /// 导航栏内 三个 右侧 item 的边距
    @IBInspectable open var _spaceItemRight:CGFloat = 0 {
        didSet{
            bar_navigation._spaceRight = _spaceItemRight
        }
    }
    
    //MARK:--- 背景 ----------
    /// 主背景图片 - 如果是网络图片 自行设置
    @IBInspectable open var _bgImg:String = "" {
        didSet{
            img_bg.image = UIImage(named: _bgImg) ?? UIImage()
        }
    }
    /// 状态呢栏背景图片 - 如果是网络图片 自行设置
    @IBInspectable open var _bgImgStatusBar:String = "" {
        didSet{
            bar_status._bgImg = _bgImgStatusBar
        }
    }
    /// 导航栏背景图片 - 如果是网络图片 自行设置
    @IBInspectable open var _bgImgNavigationBar:String = "" {
        didSet{
            bar_navigation._bgImg = _bgImgNavigationBar
        }
    }
    //MARK:--- 颜色 ----------
    /// 主背景颜色 - 如果是渐变色 自行设置
    @IBInspectable open var _colorBg:UIColor = UIColor.clear {
        didSet{
            self.backgroundColor = _colorBg
        }
    }
    /// 状态栏背景颜色 - 如果是渐变色 自行设置
    @IBInspectable open var _colorStatusBar:UIColor = UIColor.clear {
        didSet{
            bar_status._colorBg = _colorStatusBar
        }
    }
    /// 导航栏背景颜色 - 如果是渐变色 自行设置
    @IBInspectable open var _bgColorNavigationBar:UIColor = UIColor.clear {
        didSet{
            bar_navigation._bgColor = _bgColorNavigationBar
        }
    }
    
    /// 左右导航标签颜色
    @IBInspectable open var _colorNormal:UIColor = CD_TopBar.Model.color_normal {
        didSet{
            bar_navigation._colorNormal = _colorNormal
        }
    }
    /// 左右导航标签颜色
    @IBInspectable open var _colorSelected:UIColor = CD_TopBar.Model.color_selected {
        didSet{
            bar_navigation._colorSelected = _colorSelected
        }
    }
    /// 左右导航标签颜色
    @IBInspectable open var _colorHighlighted:UIColor = CD_TopBar.Model.color_highlighted {
        didSet{
            bar_navigation._colorHighlighted = _colorHighlighted
        }
    }
    /// 标题颜色
    @IBInspectable open var _colorTitle:UIColor = CD_TopBar.Model.color_title {
        didSet{
            bar_navigation._colorTitle = _colorTitle
        }
    }
    /// 副标题颜色
    @IBInspectable open var _colorSubTitle:UIColor = CD_TopBar.Model.color_subTitle {
        didSet{
            bar_navigation._colorSubTitle = _colorSubTitle
        }
    }
    /// Prompt标题颜色
    @IBInspectable open var _colorPrompt:UIColor = CD_TopBar.Model.color_prompt {
        didSet{
            bar_status._colorPrompt = _colorPrompt
        }
    }
    
    
    //MARK:--- 宽高 ----------
    /// 状态栏高度
    @IBInspectable open var _heightStatusBar:CGFloat = CD_TopBar.Model.height_status {
        didSet{
            updateStatusPrompt()
        }
    }
    /// 状态栏 Prompt 部分 高度 - 在设置 Prompt 后有效
    @IBInspectable open var _heightStatusPrompt:CGFloat = CD_TopBar.Model.height_prompt {
        didSet{
            updateStatusPrompt()
        }
    }
    /// 状态栏 Prompt 部分 实际高度 - 在设置 Prompt 后有效
    var heightStatusPrompt:CGFloat {
        get{
            return ((_prompt ?? "").isEmpty ? 0 : _heightStatusPrompt)
        }
    }
    
    /// 自定义栏高度
    @IBInspectable open var _heightCustomBar:CGFloat = 0 {
        didSet{
            bar_custom.snp.updateConstraints { (make) in
                make.height.equalTo(_heightCustomBar)
            }
        }
    }
    /// TopBar 总高度
    open var _heightTopBar:CGFloat {
        get{
            return _heightStatusBar + CD_TopBar.Model.height_navigation + heightStatusPrompt + _heightCustomBar
        }
    }
    
    //MARK:--- 子级 控件 ----------
    /// 导航栏左侧 Item 按钮1的宽度
    @IBInspectable open var _leftItemsWidth1:CGFloat = CD_TopBar.Model.height_navigation {
        didSet{
            bar_navigation._leftWidth1 = _leftItemsWidth1
        }
    }
    /// 导航栏左侧 Item 按钮2的宽度
    @IBInspectable open var _leftItemsWidth2:CGFloat = CD_TopBar.Model.height_navigation {
        didSet{
            bar_navigation._leftWidth2 = _leftItemsWidth2
        }
    }
    /// 导航栏左侧 Item 按钮3的宽度
    @IBInspectable open var _leftItemsWidth3:CGFloat = CD_TopBar.Model.height_navigation {
        didSet{
            bar_navigation._leftWidth3 = _leftItemsWidth3
        }
    }
    
    /// 导航栏左侧 Item 内 按钮间距
    @IBInspectable open var _leftItemsSpace:CGFloat = 0 {
        didSet{
            bar_navigation._leftSpace = _leftItemsSpace
        }
    }
    /// 导航栏左侧 Item 内 按钮Top边距
    @IBInspectable open var _leftItemsSpaceTop:CGFloat = 0 {
        didSet{
            bar_navigation._leftSpaceTop = _leftItemsSpaceTop
        }
    }
    /// 导航栏左侧 Item 内 按钮两侧边距
    @IBInspectable open var _leftItemsSpaceSide:CGFloat = 0 {
        didSet{
            bar_navigation._leftSpaceSide = _leftItemsSpaceSide
        }
    }
    /// 导航栏右侧 Item 按钮1的宽度
    @IBInspectable open var _rightItemsWidth1:CGFloat = CD_TopBar.Model.height_navigation {
        didSet{
            bar_navigation._rightWidth1 = _rightItemsWidth1
        }
    }
    /// 导航栏右侧 Item 按钮2的宽度
    @IBInspectable open var _rightItemsWidth2:CGFloat = CD_TopBar.Model.height_navigation {
        didSet{
            bar_navigation._rightWidth2 = _rightItemsWidth2
        }
    }
    /// 导航栏右侧 Item 按钮3的宽度
    @IBInspectable open var _rightItemsWidth3:CGFloat = CD_TopBar.Model.height_navigation {
        didSet{
            bar_navigation._rightWidth3 = _rightItemsWidth3
        }
    }
    /// 导航栏右侧 Item 内 按钮间距
    @IBInspectable open var _rightItemsSpace:CGFloat = 0 {
        didSet{
            bar_navigation._rightSpace = _rightItemsSpace
        }
    }
    /// 导航栏右侧 Item 内 按钮Top边距
    @IBInspectable open var _rightItemsSpaceTop:CGFloat = 0 {
        didSet{
            bar_navigation._rightSpaceTop = _rightItemsSpaceTop
        }
    }
    /// 导航栏右侧 Item 内 按钮两侧边距
    @IBInspectable open var _rightItemsSpaceSide:CGFloat = 0 {
        didSet{
            bar_navigation._rightSpaceSide = _rightItemsSpaceSide
        }
    }
    
    //MARK:--- init ----------
    /// 导航栏按钮交互响应回调方式 - 代理
    weak open var delegate :CD_TopBarProtocol? {
        didSet{
            guard delegate != nil else {return}
            reloadData()
            guard self.callBack != nil else {return}
            self.callBack = nil
        }
    }
    /// 导航栏按钮交互响应回调方式 - 闭包
    public var callBack:((CD_TopNavigationBar.Item) -> Void)? {
        didSet{
            guard self.callBack != nil else {return}
            guard self.delegate != nil else {return}
            self.delegate = nil
        }
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        makeUI()
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.makeUI()
    }
    convenience public init() {
        self.init(frame: CGRect.zero)
    }
    convenience public init(_ delegate:CD_TopBarProtocol) {
        self.init(frame: CGRect.zero)
        self.delegate = delegate
    }
    
    convenience public init(_ callBack:((CD_TopNavigationBar.Item) -> Void)? = nil) {
        self.init(frame: CGRect.zero)
        self.callBack = callBack
    }
}
private extension CD_TopBar {
    func makeUI() {
        self.cd
            .background(CD_TopBar.Model.color_bg)
            .add(img_bg)
            .add(bar_navigation)
            .add(bar_custom)
            .add(bar_status)
        
        
        self.makeLayout()
        self.makeNavigationBar()
    }
    func makeLayout() {
        bar_status.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(_heightStatusBar)
        }
        img_bg.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(bar_status)
        }
        
        bar_navigation.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            //make.top.equalToSuperview().offset(_heightStatusBar)
            make.top.equalTo(bar_status.snp.bottom)
            make.height.equalTo(CD_TopBar.Model.height_navigation)
        }
        bar_custom.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(self.bar_navigation.snp.bottom)
            make.height.equalTo(_heightCustomBar)
        }
        
    }
    
    
    /// 更新状态栏的 Prompt
    func updateStatusPrompt() {
        let h = heightStatusPrompt
        let hh = _heightStatusBar + h
        
        bar_status.snp.updateConstraints { (make) in
            make.height.equalTo(hh)
        }
        
        bar_status.lab_1.snp.updateConstraints { (make) in
            make.height.equalTo(h)
        }
    }
    
    
    /// 暂时这样，导航栈第一个控制器 将左侧默认返回按钮置为空
    func makeNavigationBar(){
        
        /*
        if CD.visibleVC?.presentingViewController == nil {
            
        }else{
            
        }
        if CD.topVC?.navigationController?.viewControllers.count == 1 {
            bar_navigation.item_left.btn_1.cd
                .text("").text(CD_TopBar.Model.font_title)
        }
        
        CD_Timer.after(2) {
            print("cd_1-->")
            print("cd_visVC-->",CD.visibleVC)
            print("cd_topVC-->",CD.topVC)
        }*/
        
        
    }
}


extension CD_TopBar {
    public func reloadData() {
        self.delegate?.topBar(custom: self)
        self.bar_navigation.reloadData()
        
    }
    public func reloadData(with item:CD_TopNavigationBar.Item, styles:[CD_TopNavigationBarItem.Item.Style]) {
        self.bar_navigation.reloadData(with: item, styles: styles)
    }
}

extension CD_TopBar: CD_TopNavigationBarProtocol {
    public func topNavigationBar(_ topNavigationBar: CD_TopNavigationBar, updateItemStyleForItem item: CD_TopNavigationBar.Item) -> [CD_TopNavigationBarItem.Item.Style]? {
        if let de = self.delegate {
            return de.topBar(self, updateItemStyleForItem: item)
        }
        return self.topBarItemUpdate(item)
    }
    public func topNavigationBar(_ topNavigationBar: CD_TopNavigationBar, didSelectAt item: CD_TopNavigationBar.Item) {
        if let de = self.delegate {
            de.topBar(self, didSelectAt: item)
        }
        else if let call = self.callBack {
            call(item)
        }else{
            self.topBarItemClick(item)
        }
    }
    
    public func topBarItemClick(_ item:CD_TopNavigationBar.Item) {
        if item == .leftItem1 {
            CD.pop()
        }
    }
    
    public func topBarItemUpdate(_ item:CD_TopNavigationBar.Item) -> [CD_TopNavigationBarItem.Item.Style]? {
        switch item {
        case .leftItem1:
            return [CD_TopBar.Model.back]
        default:
            return nil
        }
    }
}

extension CD_TopBar: CD_TopBarProtocol {
    
}
