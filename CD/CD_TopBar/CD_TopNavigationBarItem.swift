//Created  on 2019/3/25 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 *
 */




import UIKit
import SnapKit

//MARK:--- 协议 ----------
public protocol CD_TopNavigationBarItemProtocol: NSObjectProtocol {
    /// 更新样式
    func update(withBarItem tag:Int,  _ item:CD_TopNavigationBarItem.Item) -> [CD_TopNavigationBarItem.Item.Style]?
    /// 按钮事件
    func didSelect(withBarItem tag:Int, _ item:CD_TopNavigationBarItem.Item)
}

//MARK:--- 样式 ----------
extension CD_TopNavigationBarItem {
    /// 按钮排列样式
    public enum Style:String {
        case value1 = "1"
        case value2 = "2"
        case value3 = "3"
        case valueTitle = "title"
        case valueNone = "none"
    }
    /// 按钮编号
    public enum Item:Int {
        case item1 = 1
        case item2 = 2
        case item3 = 3
        case itemNone = 999
        
        /// 按钮基本样式
        public enum Style {
            case style(_ style:CD_TopNavigationBarItem.Style)
            case title(_ txt:[(txt:String, font:UIFont, color:UIColor, state:UIControl.State)])
            case image(_ img:[(img:UIImage, state:UIControl.State)])
            case bgImage(_ img:[(img:UIImage, state:UIControl.State)])
            case bgColor(_ color:UIColor)
            case border(_ color:UIColor, _ width:CGFloat)
            case corner(_ radius:CGFloat, _ clips:Bool)
            case width(_ width:CGFloat)
            /// 内间距/边距更新
            case space(_ space:CGFloat, _ top:CGFloat, _ side:CGFloat)
            /// top边距单独更新
            case spaceTop(CGFloat)
        }
    }
    
}

//MARK:--- 主类 ----------
@IBDesignable
open class CD_TopNavigationBarItem: UIView {
    
    public lazy var btn_1:UIButton = {
        let btn = UIButton().cd
            .text("M1")
            .text(CD_TopBar.Model.color_normal, .normal)
            .text(CD_TopBar.Model.color_selected, .selected)
            .text(CD_TopBar.Model.color_highlighted, .highlighted)
            .tag(CD_TopNavigationBarItem.Item.item1.rawValue)
            //.background(UIColor.brown)
            .build
        btn.titleLabel?.lineBreakMode = .byTruncatingTail
        btn.addTarget(self, action: #selector(buttonClick(_:)), for: UIControl.Event.touchUpInside)
        return btn
    }()
    public lazy var btn_2:UIButton = {
        let btn = UIButton().cd
            .text("M2")
            .text(CD_TopBar.Model.color_normal, .normal)
            .text(CD_TopBar.Model.color_selected, .selected)
            .text(CD_TopBar.Model.color_highlighted, .highlighted)
            .tag(CD_TopNavigationBarItem.Item.item2.rawValue)
            //.background(UIColor.orange)
            .build
        btn.titleLabel?.lineBreakMode = .byTruncatingTail
        btn.addTarget(self, action: #selector(buttonClick(_:)), for: UIControl.Event.touchUpInside)
        return btn
    }()
    
    public lazy var btn_3:UIButton = {
        let btn = UIButton().cd
            .text("M3")
            .text(CD_TopBar.Model.color_normal, .normal)
            .text(CD_TopBar.Model.color_selected, .selected)
            .text(CD_TopBar.Model.color_highlighted, .highlighted)
            .tag(CD_TopNavigationBarItem.Item.item3.rawValue)
            //.background(UIColor.gray)
            .build
        btn.titleLabel?.lineBreakMode = .byTruncatingTail
        btn.addTarget(self, action: #selector(buttonClick(_:)), for: UIControl.Event.touchUpInside)
        return btn
    }()
    
    public var style:CD_TopNavigationBarItem.Style = .value1 {
        didSet{
            makeUIWithStyle()
        }
    }
    //MARK:--- @IBInspectable ----------
    @IBInspectable open var _style:String = "1" {
        didSet{
            style = CD_TopNavigationBarItem.Style(rawValue: _style) ?? .value1
        }
    }
    
    /// 左右导航标签颜色
    @IBInspectable open var _colorNormal:UIColor = CD_TopBar.Model.color_normal {
        didSet{
            guard style != .valueNone else {return}
            guard style != .valueTitle else {return}
            guard self.subviews.contains(btn_1) else { return }
            btn_1.cd.text(_colorNormal, .normal)
            guard self.subviews.contains(btn_2) else { return }
            btn_2.cd.text(_colorNormal, .normal)
            guard self.subviews.contains(btn_3) else { return }
            btn_3.cd.text(_colorNormal, .normal)
        }
    }
    /// 左右导航标签颜色
    @IBInspectable open var _colorSelected:UIColor = CD_TopBar.Model.color_selected {
        didSet{
            guard style != .valueNone else {return}
            guard style != .valueTitle else {return}
            guard self.subviews.contains(btn_1) else { return }
            btn_1.cd.text(_colorSelected, .selected)
            guard self.subviews.contains(btn_2) else { return }
            btn_2.cd.text(_colorSelected, .selected)
            guard self.subviews.contains(btn_3) else { return }
            btn_3.cd.text(_colorSelected, .selected)
        }
    }
    /// 左右导航标签颜色
    @IBInspectable open var _colorHighlighted:UIColor = CD_TopBar.Model.color_highlighted {
        didSet{
            guard style != .valueNone else {return}
            guard style != .valueTitle else {return}
            guard self.subviews.contains(btn_1) else { return }
            btn_1.cd.text(_colorHighlighted, .highlighted)
            guard self.subviews.contains(btn_2) else { return }
            btn_2.cd.text(_colorHighlighted, .highlighted)
            guard self.subviews.contains(btn_3) else { return }
            btn_3.cd.text(_colorHighlighted, .highlighted)
        }
    }
    /// 标题颜色
    @IBInspectable open var _colorTitle:UIColor = CD_TopBar.Model.color_title {
        didSet{
            guard style != .valueNone else {return}
            guard style == .valueTitle else {return}
            guard self.subviews.contains(btn_1) else { return }
            btn_1.cd
                .text(_colorTitle, .normal)
                .text(_colorTitle, .selected)
                .text(_colorTitle, .highlighted)
        }
    }
    /// 副标题颜色
    @IBInspectable open var _colorSubTitle:UIColor = CD_TopBar.Model.color_subTitle {
        didSet{
            guard style != .valueNone else {return}
            guard style == .valueTitle else {return}
            guard self.subviews.contains(btn_2) else { return }
            btn_2.cd
                .text(_colorTitle, .normal)
                .text(_colorTitle, .selected)
                .text(_colorTitle, .highlighted)
        }
    }
    
    /// 按钮1 宽度
    @IBInspectable open var _width1:CGFloat = CD_TopBar.Model.height_navigation {
        didSet{
            guard style != .valueNone else {return}
            guard style != .valueTitle else {return}
            guard self.subviews.contains(btn_1) else { return }
            btn_1.snp.updateConstraints { (make) in
                make.width.equalTo(_width1)
            }
            
        }
    }
    /// 按钮2 宽度
    @IBInspectable open var _width2:CGFloat = CD_TopBar.Model.height_navigation {
        didSet{
            guard style != .valueNone else {return}
            guard style != .valueTitle else {return}
            guard self.subviews.contains(btn_2) else { return }
            btn_2.snp.updateConstraints { (make) in
                make.width.equalTo(_width2)
            }
            
        }
    }
    /// 按钮3 宽度
    @IBInspectable open var _width3:CGFloat = CD_TopBar.Model.height_navigation {
        didSet{
            guard style != .valueNone else {return}
            guard style != .valueTitle else {return}
            guard self.subviews.contains(btn_3) else { return }
            btn_3.snp.updateConstraints { (make) in
                make.width.equalTo(_width3)
            }
            
        }
    }
    /// 按钮 内间距
    @IBInspectable open var _space:CGFloat = 0 {
        didSet{
            guard style != .valueNone else {return}
            guard style != .valueTitle else {return}
            guard self.subviews.contains(btn_2) else { return }
            btn_2.snp.updateConstraints { (make) in
                make.left.equalTo(btn_1.snp.right).offset(_space)
            }
            
            guard self.subviews.contains(btn_3) else { return }
            btn_3.snp.updateConstraints { (make) in
                make.left.equalTo(btn_2.snp.right).offset(_space)
            }
            
        }
    }
    /// 按钮top边距
    @IBInspectable open var _spaceTop:CGFloat = 0 {
        didSet{
            guard style != .valueNone else {return}
            guard style != .valueTitle else {return}
            guard self.subviews.contains(btn_1) else { return }
            btn_1.snp.updateConstraints { (make) in
                make.top.equalToSuperview().offset(_spaceTop)
            }
            
            guard self.subviews.contains(btn_2) else { return }
            btn_2.snp.updateConstraints { (make) in
                make.top.equalToSuperview().offset(_spaceTop)
            }
            
            guard self.subviews.contains(btn_3) else { return }
            btn_3.snp.updateConstraints { (make) in
                make.top.equalToSuperview().offset(_spaceTop)
            }
            
        }
    }
    /// 按钮两侧边距
    @IBInspectable open var _spaceSide:CGFloat = 0 {
        didSet{
            guard style != .valueNone else {return}
            guard style != .valueTitle else {return}
            if self.subviews.contains(btn_1) {
                btn_1.snp.updateConstraints { (make) in
                    make.left.equalToSuperview().offset(_spaceSide)
                }
            }
            if self.subviews.contains(btn_3) {
                btn_3.snp.updateConstraints { (make) in
                    make.right.equalToSuperview().offset(-_spaceSide)
                }
            }
            
            guard style == .value2 else {return}
            guard self.subviews.contains(btn_2) else { return }
            btn_2.snp.updateConstraints { (make) in
                make.right.equalToSuperview().offset(-_spaceSide)
            }
        }
    }
    
    weak public var delegate: CD_TopNavigationBarItemProtocol? {
        didSet{
            guard delegate != nil else {return}
            reloadData()
            guard callBack != nil else {return}
            callBack = nil
        }
    }
    
    public var callBack:((CD_TopNavigationBarItem.Item)->Void)? {
        didSet{
            guard callBack != nil else {return}
            guard delegate != nil else {return}
            delegate = nil
        }
    }
    
    
    //MARK:--- 初始化 ----------
    convenience public init(_ style:CD_TopNavigationBarItem.Style = .value3, callBack:((CD_TopNavigationBarItem.Item)->Void)? = nil) {
        self.init(frame: CGRect.zero)
        self.style = style
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
//MARK:--- 默认配置 ----------
extension CD_TopNavigationBarItem {
    func makeUI(){
        self.backgroundColor = UIColor.clear
        self.style = .value1
    }
    
    func makeUIWithStyle() {
        for item in self.subviews {
            item.removeFromSuperview()
        }
        switch self.style {
        case .value1:
            makeStyleValue1()
        case .value2:
            makeStyleValue2()
        case .value3:
            makeStyleValue3()
        case .valueTitle:
            makeStyleValueTitle()
        case .valueNone:
            break
        }
    }
    
    func makeStyleValue1() {
        self.cd.add(btn_1)
        btn_1.snp.remakeConstraints { (make) in
            make.left.equalToSuperview().offset(_spaceSide)
            make.top.equalToSuperview().offset(_spaceTop)
            make.center.equalToSuperview()
            make.width.equalTo(_width1)
        }
    }
    
    func makeStyleValue2() {
        self.cd.add(btn_1).add(btn_2)
        btn_1.snp.remakeConstraints { (make) in
            make.left.equalToSuperview().offset(_spaceSide)
            make.top.equalToSuperview().offset(_spaceTop)
            make.centerY.equalToSuperview()
            make.width.equalTo(_width1)
        }
        btn_2.snp.remakeConstraints { (make) in
            make.right.equalToSuperview().offset(-_spaceSide)
            make.top.equalToSuperview().offset(_spaceTop)
            make.centerY.equalToSuperview()
            make.left.equalTo(btn_1.snp.right).offset(_space)
            make.width.equalTo(_width2)
        }
    }
    func makeStyleValue3() {
        self.cd.add(btn_1).add(btn_2).add(btn_3)
        btn_1.snp.remakeConstraints { (make) in
            make.left.equalToSuperview().offset(_spaceSide)
            make.top.equalToSuperview().offset(_spaceTop)
            make.centerY.equalToSuperview()
            make.width.equalTo(_width1)
        }
        btn_2.snp.remakeConstraints { (make) in
            make.top.equalToSuperview().offset(_spaceTop)
            make.centerY.equalToSuperview()
            make.left.equalTo(btn_1.snp.right)
            make.width.equalTo(_width2)
        }
        btn_3.snp.remakeConstraints { (make) in
            make.right.equalToSuperview().offset(-_spaceSide)
            make.top.equalToSuperview().offset(_spaceTop)
            make.centerY.equalToSuperview()
            make.left.equalTo(btn_2.snp.right)
            make.width.equalTo(_width3)
        }
    }
    
    func makeStyleValueTitle() {
        self.cd.add(btn_1).add(btn_2)
        btn_1.cd
            .text("")
            .text(CD_TopBar.Model.font_title)
            .text(CD_TopBar.Model.color_title, .normal)
            .text(CD_TopBar.Model.color_title, .selected)
            .text(CD_TopBar.Model.color_title, .highlighted)
        
        btn_2.cd
            .text("")
            .text(CD_TopBar.Model.font_subTitle)
            .text(CD_TopBar.Model.color_subTitle, .normal)
            .text(CD_TopBar.Model.color_subTitle, .selected)
            .text(CD_TopBar.Model.color_subTitle, .highlighted)
        
        btn_2.snp.remakeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(0)
        }
        
        btn_1.snp.remakeConstraints { (make) in
            make.left.right.top.equalToSuperview()
            make.bottom.equalTo(btn_2.snp.top)
        }
    }
    
    @objc func buttonClick(_ sender: UIButton) {
        
        self.delegate?.didSelect(withBarItem: self.tag,  CD_TopNavigationBarItem.Item(rawValue: sender.tag) ?? .itemNone)
        self.callBack?(CD_TopNavigationBarItem.Item(rawValue: sender.tag) ?? .itemNone)
    }
}


//MARK:--- 更新 ----------
extension CD_TopNavigationBarItem {
    /// 此更新方法用于 delegate 类回调更新
    public func reloadData() {
        if let styles = self.delegate?.update(withBarItem: self.tag, .item1) {
            reloadData(withButton: btn_1, styles: styles)
        }
        if let styles = self.delegate?.update(withBarItem:self.tag, .item2) {
            reloadData(withButton: btn_2, styles: styles)
        }
        if let styles = self.delegate?.update(withBarItem:self.tag, .item3) {
            reloadData(withButton: btn_3, styles: styles)
        }
    }
    /// 此更新方法一般用于 callBack 类回调更新
    public func reloadData(with item:CD_TopNavigationBarItem.Item, styles:[CD_TopNavigationBarItem.Item.Style]) {
        switch item {
        case .item1:
            reloadData(withButton: btn_1, styles: styles)
        case .item2:
            reloadData(withButton: btn_2, styles: styles)
        case .item3:
            reloadData(withButton: btn_3, styles: styles)
        case .itemNone:
            break
        }
    }
    
    private func reloadData(withButton button:UIButton, styles:[CD_TopNavigationBarItem.Item.Style]) {
        guard style != .valueNone else {return}
        guard style != .valueTitle else {return}
        guard self.subviews.contains(button) else { return }
        _ = styles.map{reloadData(withButton: button, style:$0)}
    }
    private func reloadData(withButton button:UIButton, style:CD_TopNavigationBarItem.Item.Style){
        switch style {
        case .title(let txts):
            _ = txts.map{button.cd.text($0.txt, $0.state).text($0.color, $0.state).text($0.font)}
        case .image(let imgs):
            _ = imgs.map{button.cd.image($0.img, for: $0.state)}
        case .bgImage(let imgs):
            _ = imgs.map{button.cd.background($0.img, for: $0.state)}
        case .bgColor(let c):
            button.cd.background(c)
        case .border(let c, let w):
            button.cd.border(w, color: c)
        case .corner(let r, let c):
            button.cd.corner(r, clips:c)
        case .width( let w):
            let i = CD_TopNavigationBarItem.Item(rawValue: button.tag)
            switch i {
            case .item1?:
                _width1 = w
            case .item2?:
                _width2 = w
            case .item3?:
                _width3 = w
            case .none:
                break
            case .some(.itemNone):
                break
            }
        case .space(let s, let top, let side):
            _space = s
            _spaceTop = top
            _spaceSide = side
        case .spaceTop(let top):
            reloadSpace(CD_TopNavigationBarItem.Item(rawValue: button.tag) ?? .itemNone, top)
        case .style(let style):
            self.style = style
        }
    }
    
    private func reloadSpace(_ item:CD_TopNavigationBarItem.Item, _ top:CGFloat){
        guard style != .valueNone else {return}
        guard style != .valueTitle else {return}
        switch item {
        case .item1:
            guard self.subviews.contains(btn_1) else { return }
            btn_1.snp.updateConstraints { (make) in
                make.top.equalToSuperview().offset(_spaceTop)
            }
        case .item2:
            guard self.subviews.contains(btn_2) else { return }
            btn_2.snp.updateConstraints { (make) in
                make.top.equalToSuperview().offset(_spaceTop)
            }
        case .item3:
            guard self.subviews.contains(btn_3) else { return }
            btn_3.snp.updateConstraints { (make) in
                make.top.equalToSuperview().offset(_spaceTop)
            }
        default:
            break
        }
    }
}
