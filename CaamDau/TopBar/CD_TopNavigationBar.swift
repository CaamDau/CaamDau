//Created  on 2019/3/25 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 *
 */




import UIKit
import SnapKit

public protocol CD_TopNavigationBarProtocol: NSObjectProtocol {
    /// 更新按钮样式
    func update(withNavigationBar item:CD_TopNavigationBar.Item) -> [CD_TopNavigationBarItem.Item.Style]?
    /// 按钮事件
    func didSelect(withNavigationBar item:CD_TopNavigationBar.Item)
}

extension CD_TopNavigationBar {
    public enum Style:String {
        case value10 = "10"
        case value11 = "11"
        case value12 = "12"
        case value13 = "13"
        case value21 = "21"
        case value22 = "22"
        case value23 = "23"
        case value31 = "31"
        case value32 = "32"
        case value33 = "33"
        case valueNone = "000"
    }
    public enum Item:Int {
        case leftItem1 = 11
        case leftItem2 = 12
        case leftItem3 = 13
        case centreItem1 = 21
        case centreItem2 = 22
        case rightItem1 = 31
        case rightItem2 = 32
        case rightItem3 = 33
        case itemNone = 999
        
        /// Item 基本样式
        public enum Style {
            case bgImage(_ img:[(img:UIImage, state:UIControl.State)])
            case bgColor(_ color:UIColor)
            /// 内间距/边距更新
            case space(_ space:CGFloat, _ left:CGFloat, _ right:CGFloat)
        }
    }
}

//@IBDesignable
open class CD_TopNavigationBar: UIView {
    
    public lazy var img_bg:UIImageView = {
        return UIImageView().cd.clips(true).build
    }()
    
    public lazy var line:UIView = {
        return UIView().cd
            .background(CD_TopBar.Model.color_line)
            .build
    }()
    public lazy var item_left:CD_TopNavigationBarItem = {
        let item = CD_TopNavigationBarItem()
        item.delegate = self
        item.tag = 10
        return item
    }()
    public lazy var item_centre:CD_TopNavigationBarItem = {
        let item = CD_TopNavigationBarItem()
        item.delegate = self
        item.tag = 20
        return item
    }()
    
    public lazy var item_right:CD_TopNavigationBarItem = {
        let item = CD_TopNavigationBarItem()
        item.delegate = self
        item.tag = 30
        return item
    }()
    
    
    /// 样式
    public var style:CD_TopNavigationBar.Style = .value10 {
        didSet{
            makeWithStyle()
        }
    }
    //MARK:--- 样式 ----------
    /// 标题
    @IBInspectable open var _title:String? = "" {
        didSet{
            guard self.style != .valueNone else {return}
            item_centre.btn_1.cd.text(_title ?? "")
        }
    }
    /// 副标题
    @IBInspectable open var _subTitle:String? = "" {
        didSet{
            guard self.style != .valueNone  else {
                return
            }
            item_centre.btn_2.cd.text(_subTitle ?? "")
            item_centre.btn_2.snp.updateConstraints { (make) in
                make.height.equalTo((_subTitle ?? "").isEmpty ? 0 : 15)
            }
        }
    }
    /// 样式
    @IBInspectable open var _style:String? {
        didSet{
            style = CD_TopNavigationBar.Style(rawValue: _style ?? "10") ?? CD_TopNavigationBar.Style.value10
        }
    }
    
    //MARK:--- 背景 ----------
    /// 背景图片
    @IBInspectable open var _bgImg:String = "" {
        didSet{
            img_bg.image = UIImage(named: _bgImg) ?? nil
        }
    }
    /// 背景颜色
    @IBInspectable open var _bgColor:UIColor = UIColor.clear {
        didSet{
            self.backgroundColor = _bgColor
        }
    }
    /// 左右导航标签颜色
    @IBInspectable open var _colorNormal:UIColor = CD_TopBar.Model.color_normal {
        didSet{
            item_left._colorNormal = _colorNormal
            item_right._colorNormal = _colorNormal
        }
    }
    /// 左右导航标签颜色
    @IBInspectable open var _colorSelected:UIColor = CD_TopBar.Model.color_selected {
        didSet{
            item_left._colorSelected = _colorSelected
            item_right._colorSelected = _colorSelected
        }
    }
    /// 左右导航标签颜色
    @IBInspectable open var _colorHighlighted:UIColor = CD_TopBar.Model.color_highlighted {
        didSet{
            item_left._colorHighlighted = _colorHighlighted
            item_right._colorHighlighted = _colorHighlighted
        }
    }
    /// 标题颜色
    @IBInspectable open var _colorTitle:UIColor = CD_TopBar.Model.color_title {
        didSet{
            item_centre._colorTitle = _colorTitle
        }
    }
    /// 副标题颜色
    @IBInspectable open var _colorSubTitle:UIColor = CD_TopBar.Model.color_subTitle {
        didSet{
            item_centre._colorSubTitle = _colorSubTitle
        }
    }
    
    //MARK:--- 间距 ----------
    /// item 内间距
    @IBInspectable open var _space:CGFloat = 0 {
        didSet{
            item_centre.snp.updateConstraints { (make) in
                make.right
                    .lessThanOrEqualTo(item_right.snp.left)
                    .offset(-_space).priority(.required)
                make.left
                    .greaterThanOrEqualTo(item_left.snp.right)
                    .offset(_space).priority(.required)
            }
        }
    }
    /// 左item边距
    @IBInspectable open var _spaceLeft:CGFloat = 0 {
        didSet{
            item_left.snp.updateConstraints { (make) in
                make.left.equalToSuperview().offset(_spaceLeft)
            }
        }
    }
    /// 右item边距
    @IBInspectable open var _spaceRight:CGFloat = 0 {
        didSet{
            item_right.snp.updateConstraints { (make) in
                make.right.equalToSuperview().offset(-_spaceRight)
            }
        }
    }
    
    //MARK:--- 子级 控件 ----------
    /// 左侧 item 内 按钮1宽度
    @IBInspectable open var _leftWidth1:CGFloat = CD_TopBar.Model.height_navigation {
        didSet{
            item_left._width1 = _leftWidth1
        }
    }
    /// 左侧 item 内 按钮2宽度
    @IBInspectable open var _leftWidth2:CGFloat = CD_TopBar.Model.height_navigation {
        didSet{
            item_left._width2 = _leftWidth2
        }
    }
    /// 左侧 item 内 按钮3宽度
    @IBInspectable open var _leftWidth3:CGFloat = CD_TopBar.Model.height_navigation {
        didSet{
            item_left._width3 = _leftWidth3
        }
    }
    
    /// 左侧 item 内 按钮内间距
    @IBInspectable open var _leftSpace:CGFloat = 0 {
        didSet{
            item_left._space = _leftSpace
        }
    }
    /// 左侧 item 内 按钮top边距
    @IBInspectable open var _leftSpaceTop:CGFloat = 0 {
        didSet{
            item_left._spaceTop = _leftSpaceTop
        }
    }
    /// 左侧 item 内 按钮两侧边距
    @IBInspectable open var _leftSpaceSide:CGFloat = 0 {
        didSet{
            item_left._spaceSide = _leftSpaceSide
        }
    }
    
    /// 右侧 item 内 按钮1宽度
    @IBInspectable open var _rightWidth1:CGFloat = CD_TopBar.Model.height_navigation {
        didSet{
            item_right._width1 = _rightWidth1
        }
    }
    /// 右侧 item 内 按钮2宽度
    @IBInspectable open var _rightWidth2:CGFloat = CD_TopBar.Model.height_navigation {
        didSet{
            item_right._width2 = _rightWidth2
        }
    }
    /// 右侧 item 内 按钮3宽度
    @IBInspectable open var _rightWidth3:CGFloat = CD_TopBar.Model.height_navigation {
        didSet{
            item_right._width3 = _rightWidth3
        }
    }
    /// 右侧 item 内 按钮内间距
    @IBInspectable open var _rightSpace:CGFloat = 0 {
        didSet{
            item_right._space = _rightSpace
        }
    }
    /// 右侧 item 内 按钮top边距
    @IBInspectable open var _rightSpaceTop:CGFloat = 0 {
        didSet{
            item_right._spaceTop = _rightSpaceTop
        }
    }
    /// 右侧 item 内 按钮两侧边距
    @IBInspectable open var _rightSpaceSide:CGFloat = 0 {
        didSet{
            item_right._spaceSide = _rightSpaceSide
        }
    }
    
    //MARK:--- 初始化 ----------
    weak public var delegate:CD_TopNavigationBarProtocol? {
        didSet{
            guard delegate != nil else {return}
            reloadData()
            guard callBack != nil else {return}
            callBack = nil
        }
    }
    var callBack:((CD_TopNavigationBar.Item)->Void)? {
        didSet{
            guard callBack != nil else {return}
            guard delegate != nil else {return}
            delegate = nil
        }
    }
    convenience public init(_ callBack:((CD_TopNavigationBar.Item)->Void)? = nil){
        self.init(frame: CGRect.zero)
        self.callBack = callBack
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        makeUI()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        makeUI()
    }
}


extension CD_TopNavigationBar {
    func makeUI() {
        self.cd
            .add(img_bg)
            .add(item_left)
            .add(item_right)
            .add(item_centre)
            .add(line)
        
        img_bg.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        item_left.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(0)
            make.width.greaterThanOrEqualTo(0).priority(.low)
        }
        
        item_right.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.right.equalToSuperview().offset(0)
            make.width.greaterThanOrEqualTo(0).priority(.low)
        }
        
        item_centre.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.centerX.equalToSuperview().priority(.medium)
            make.right
                .lessThanOrEqualTo(item_right.snp.left)
                .offset(0).priority(.required)
            make.left
                .greaterThanOrEqualTo(self.item_left.snp.right)
                .offset(0).priority(.required)
        }
        
        line.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(CD_TopBar.Model.height_line)
        }
        
        makeWithStyle()
    }
    
    
    func makeWithStyle(){
        guard self.style != .valueNone else {
            item_left.style = .valueNone
            item_right.style = .valueNone
            item_centre.style = .valueNone
            return
        }
        
        switch self.style {
        case .value10:
            item_left.style = .value1
            item_right.style = .valueNone
        case .value11:
            item_left.style = .value1
            item_right.style = .value1
        case .value12:
            item_left.style = .value1
            item_right.style = .value2
        case .value13:
            item_left.style = .value1
            item_right.style = .value3
        case .value21:
            item_left.style = .value2
            item_right.style = .value1
        case .value22:
            item_left.style = .value2
            item_right.style = .value2
        case .value23:
            item_left.style = .value2
            item_right.style = .value3
        case .value31:
            item_left.style = .value3
            item_right.style = .value1
        case .value32:
            item_left.style = .value3
            item_right.style = .value2
        case .value33:
            item_left.style = .value3
            item_right.style = .value3
        case .valueNone:
            break
        }
        makeTitleView()
    }
    
    func makeTitleView() {
        item_centre.style = .valueTitle
        let tit = _title
        let subtit = _subTitle
        _title = tit
        _subTitle = subtit
    }
}

//MARK:--- 更新 ----------
extension CD_TopNavigationBar {
    /// 此更新方法用于 delegate 类回调更新
    public func reloadData() {
        if self.delegate?.update(withNavigationBar: .leftItem1) != nil ||
            self.delegate?.update(withNavigationBar: .leftItem2) != nil ||
            self.delegate?.update(withNavigationBar: .leftItem3) != nil {
            item_left.reloadData()
        }
        if self.delegate?.update(withNavigationBar: .centreItem1) != nil ||
            self.delegate?.update(withNavigationBar: .centreItem2) != nil {
            item_centre.reloadData()
        }
        if self.delegate?.update(withNavigationBar: .rightItem1) != nil ||
            self.delegate?.update(withNavigationBar: .rightItem2) != nil ||
            self.delegate?.update(withNavigationBar: .rightItem3) != nil {
            item_right.reloadData()
        }
    }
    /// 此更新方法一般用于 callBack 类回调更新
    public func reloadData(with item:CD_TopNavigationBar.Item, styles:[CD_TopNavigationBarItem.Item.Style]) {
        switch item {
        case .leftItem1:
            item_left.reloadData(with: .item1, styles: styles)
        case .leftItem2:
            item_left.reloadData(with: .item2, styles: styles)
        case .leftItem3:
            item_left.reloadData(with: .item3, styles: styles)
        case .centreItem1:
            item_centre.reloadData(with: .item1, styles: styles)
        case .centreItem2:
            item_centre.reloadData(with: .item2, styles: styles)
        case .rightItem1:
            item_right.reloadData(with: .item1, styles: styles)
        case .rightItem2:
            item_right.reloadData(with: .item2, styles: styles)
        case .rightItem3:
            item_right.reloadData(with: .item3, styles: styles)
        case .itemNone:
            break
        }
    }
}

extension CD_TopNavigationBar: CD_TopNavigationBarItemProtocol {
    public func update(withBarItem tag: Int, _ item: CD_TopNavigationBarItem.Item) -> [CD_TopNavigationBarItem.Item.Style]? {
        return self.delegate?.update(withNavigationBar: CD_TopNavigationBar.Item(rawValue: tag + item.rawValue) ?? .itemNone)
    }
    public func didSelect(withBarItem tag: Int, _ item: CD_TopNavigationBarItem.Item) {
        self.delegate?.didSelect(withNavigationBar: CD_TopNavigationBar.Item(rawValue: tag + item.rawValue) ?? .itemNone)
        self.callBack?(CD_TopNavigationBar.Item(rawValue: tag + item.rawValue) ?? .itemNone)
    }
    
}
