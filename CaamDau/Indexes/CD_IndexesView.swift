//Created  on 2019/9/5 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 *
 */




import UIKit
import SnapKit

extension CD_IndexesView{
    public struct Item {
        private init(){
            self.init(title:"")
        }
        public init(title:String,
                    icon:UIImage? = nil,
                    font:UIFont = .boldSystemFont(ofSize: 12),
                    color:UIColor = .darkText,
                    colorBg:UIColor? = nil,
                    iconHighlighted:UIImage? = nil,
                    fontHighlighted:UIFont? = nil,
                    colorHighlighted:UIColor? = nil,
                    colorBgHighlighted:UIColor? = nil,
                    heightEqualWidth:Bool? = nil,
                    size:CGSize? = nil) {
            self.title = title
            self.icon = icon
            self.font = font
            self.color = color
            self.colorBg = colorBg
            self.iconHighlighted = iconHighlighted ?? icon
            self.fontHighlighted = fontHighlighted ?? font
            self.colorHighlighted = colorHighlighted ?? color
            self.colorBgHighlighted = colorBgHighlighted
            self.heightEqualWidth = heightEqualWidth
            self.size = size
        }
        
        public var title:String
        public var icon:UIImage?
        public var font:UIFont
        public var color:UIColor
        public var colorBg:UIColor?
        
        public var iconHighlighted:UIImage?
        public var fontHighlighted:UIFont?
        public var colorHighlighted:UIColor?
        public var colorBgHighlighted:UIColor?
        public var heightEqualWidth:Bool?
        public var size:CGSize? //= CGSize(w: 15, h: 15)
    }
    
    public struct HUD {
        public init(icon:UIImage? = nil,
                    colorBg:UIColor = UIColor.black,
                    alphaMax:CGFloat = 0.3,
                    color:UIColor = UIColor.white,
                    font:UIFont = UIFont.boldSystemFont(ofSize: 40),
                    size:CGSize = CGSize(w: 60, h: 50),
                    cornerRadius:CGFloat = 6,
                    style:Style = .bubble) {
            self.icon = icon
            self.colorBg = colorBg
            self.alphaMax = alphaMax
            
            self.color = color
            self.font = font
            self.size = size
            self.cornerRadius = cornerRadius
            self.style = style
        }
        /// 背景图片
        public var icon:UIImage?
        public var colorBg:UIColor
        public var alphaMax:CGFloat
        
        public var color:UIColor
        public var font:UIFont
        
        public var size:CGSize
        public var cornerRadius:CGFloat
        public var style:Style
        public enum Style {
            /// 气泡
            case bubble
            /// HUD
            case hud
        }
    }
}
public class CD_IndexesView: UIView {
    /// 索引
    open var items:[Item] = [] {
        didSet {
            reloadData()
            lastIndex = items.count - 1
        }
    }
    /// 选中
    open var selectIndex:Int = 0 {
        didSet {
            highlighting( highlight(with: selectIndex) )
        }
    }
    /// 设置起始选项 - 当选中的<firstIndex时候不显示 HUD
    open var firstIndex = 0
    /// 设置起始选项 - 当选中>lastIndex的时候不显示 HUD
    open var lastIndex = 0
    open var selectHandler:((_ item:Item, _ index:Int)->Void)?
    lazy var stack:UIStackView = {
        return UIStackView().cd
            .axis(.vertical)
            .alignment(.center)
            .distribution(.fillProportionally)
            .build
    }()
    // - HUD
    open var hudStyle:HUD = HUD()
    var _hud: CD_IndexesViewHUD?
    var hud: CD_IndexesViewHUD? {
        set{
           _hud = newValue
        }
        get{
            return _hud == nil ? makeHUD() : _hud
        }
    }
    func makeHUD() -> CD_IndexesViewHUD {
        _hud = CD_IndexesViewHUD(hudStyle)
        self.superview?.addSubview(_hud!)
        
        switch hudStyle.style {
        case .hud:
            _hud?.snp.makeConstraints {
                $0.centerX.equalTo(self.superview!)
                $0.centerY.equalTo(self.stack)
                $0.width.equalTo(hudStyle.size.width)
                $0.height.equalTo(hudStyle.size.height)
            }
        case .bubble:
            guard let btn = (stack.arrangedSubviews
                .filter{ ($0 as! UIButton).isSelected }
                .compactMap{$0}
                .first) else{break}
            
            _hud?.snp.remakeConstraints {
                $0.right.equalTo(self.snp.left).offset(-10)
                $0.centerY.equalTo(btn)
                $0.width.equalTo(hudStyle.size.width)
                $0.height.equalTo(hudStyle.size.height)
            }
        }
        return _hud!
    }
    public convenience init() {
        self.init(frame:.zero)
    }
    override public init(frame: CGRect) {
        super.init(frame: frame)
        makeUI()
    }
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        makeUI()
    }
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        highlight(with: touches)
    }
    override public func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        highlight(with: touches)
    }
    override public func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        hud?.animationFade(true, completion: { [weak self] in
            self?.hud = nil
        })
    }
    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.touchesCancelled(touches, with: event)
    }
}

//MARK:--- highlight ----------
extension CD_IndexesView {
    func highlight(with touches: Set<UITouch>) {
        guard let touch = touches.first else {
            return
        }
        let point:CGPoint = touch.location(in: self.stack)
        
        highlighting( highlight(with: point) )
    }
    
    func highlight(with index:Int) -> UIButton? {
        guard index >= 0 , index < stack.arrangedSubviews.count else {
            return nil
        }
        return stack.arrangedSubviews[index] as? UIButton
    }
    
    func highlight(with point:CGPoint) -> UIButton? {
        var btn = stack.arrangedSubviews
            .filter{
                $0.frame.minY < point.y
                    && point.y < $0.frame.maxY
            }
            .map{($0 as! UIButton)}.first
        if btn == nil, let first = stack.arrangedSubviews.first as? UIButton, let last = stack.arrangedSubviews.last as? UIButton  {
            btn = point.y < first.frame.minY ? first : point.y > last.frame.maxY ? last : nil
        }
        return btn
    }
    
    func highlighting(_ btn:UIButton?) {
        stack.arrangedSubviews
            .forEach{
                let btn = $0 as! UIButton
                btn.isSelected = false
                btn.cd
                    .text(items[btn.tag].font)
                    .background(items[btn.tag].colorBg)
        }
        guard let btn = btn else{return}
        if self.selectIndex != btn.tag {
            self.selectIndex = btn.tag
            selectHandler?(items[btn.tag], btn.tag)
        }
        
        guard btn.tag >= firstIndex, btn.tag <= lastIndex else {
            hud?.removeFromSuperview()
            hud = nil
            return
        }
        btn.cd
            .text(items[btn.tag].fontHighlighted)
            .background(items[btn.tag].colorBgHighlighted)
            .corner(btn.bounds.size.height/2.0, clips: true)
        btn.isSelected = true
        
        switch hudStyle.style {
        case .hud:
            break
        case .bubble:
            _hud?.snp.remakeConstraints {
                $0.right.equalTo(self.snp.left).offset(-10)
                $0.centerY.equalTo(btn)
                $0.width.equalTo(hudStyle.size.width)
                $0.height.equalTo(hudStyle.size.height)
            }
        }
        hud?.show(item: items[btn.tag])
        hud?.animationFade(false)
    }
}

extension CD_IndexesView{
    func makeUI() {
        self.cd
            .background(.clear)
            .add(stack)
        stack.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.top.greaterThanOrEqualToSuperview()
            $0.right.equalToSuperview().offset(-8)
            $0.left.equalToSuperview()
        }
    }
    
    func reloadData(){
        stack.arrangedSubviews.forEach{$0.removeFromSuperview()}
        for (i, item) in items.enumerated() {
            let button = UIButton(type: .custom)
            button.cd
                .tag(i)
                .isUser(false)
                .image(item.icon, for: .normal)
                .image(item.iconHighlighted, for: .highlighted)
                .image(item.iconHighlighted, for: .selected)
                .text(item.color, .normal)
                .background(item.colorBg)
                .text(item.colorHighlighted, .highlighted)
                .text(item.colorHighlighted, .selected)
                .text(item.font)
                .text(item.title)
            button.translatesAutoresizingMaskIntoConstraints = false
            if let size = item.size {
                button.heightAnchor.constraint(equalToConstant: size.height).isActive = true
                button.widthAnchor.constraint(equalToConstant: size.width).isActive = true
            }else if let equal = item.heightEqualWidth, equal {
                button.heightAnchor.constraint(equalTo: button.widthAnchor, multiplier: 1).isActive = true
            }
            stack.cd.addArranged(subview: button)
        }
        
    }
}


//MARK:--- HUD ----------
class CD_IndexesViewHUD: UIView {
    lazy var button: UIButton  = {
        let button = UIButton(type: .custom)
        self.cd.add(button)
        button.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
        return button
    }()
    
    lazy var imageView: UIImageView  = {
        let imageView = UIImageView()
        self.cd.add(imageView)
        self.sendSubviewToBack(imageView)
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        return imageView
    }()
    
    var style:CD_IndexesView.HUD = CD_IndexesView.HUD() {
        didSet{
            
        }
    }
    var completion:(()->Void)?
    var remove:Bool = false
    func show(item:CD_IndexesView.Item) {
        button.cd
            .image(item.icon)
            .text(item.title)
    }
    convenience init(_ style:CD_IndexesView.HUD) {
        self.init(frame:.zero)
        self.style = style
        makeUI()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        makeUI()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        makeUI()
    }
    func makeUI() {
        if let icon = style.icon {
            self.imageView.cd.image(icon)
        }
        switch style.style {
        case .hud:
            self.cd
                .corner(style.cornerRadius, clips: true)
                .background(style.colorBg.cd_alpha(style.alphaMax))
            button.snp.updateConstraints {
                $0.centerX.equalToSuperview()
            }
        case .bubble:
            self.cd.background(style.colorBg.cd_alpha(0))
            button.snp.updateConstraints {
                $0.centerX.equalToSuperview()
                .offset((style.size.height-style.size.width)/2)
            }
        }
        button.cd
            .text(style.font)
            .text(style.color)
    }
    
    var isShow = false
    func animationFade(_ remove:Bool, completion:(()->Void)? = nil) {
        self.completion = completion
        self.remove = remove
        self.isShow = remove ? false : isShow
        guard !isShow else { return }
        isShow = remove ? false : true
        let animote = CABasicAnimation(keyPath: "opacity")
        animote.duration = 0.2
        animote.isRemovedOnCompletion = false
        animote.fillMode = .forwards
        animote.fromValue = remove ? 1 : 0
        animote.toValue = remove ? 0 : 1
        animote.delegate = self
        self.layer.add(animote, forKey: animote.keyPath)
    }
    
    override func draw(_ rect: CGRect) {
        guard style.style == .bubble, style.icon == nil else { return }
        /// 绘制气泡
        let mid = (rect.size.height/2.0)
        let a = CGPoint(x:rect.size.width, y: mid)
        let bezierPath = UIBezierPath(arcCenter: CGPoint(x: mid, y: mid), radius: mid, startAngle: CGFloat.pi/4, endAngle: CGFloat.pi*7/4, clockwise: true)
        bezierPath.lineCapStyle = .round
        bezierPath.addLine(to: a)
        bezierPath.close()
        style.colorBg.cd_alpha(style.alphaMax).setFill()
        bezierPath.fill()
    }
}
extension CD_IndexesViewHUD: CAAnimationDelegate {
    func animationDidStart(_ anim: CAAnimation) {
    }
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if remove {
            self.removeFromSuperview()
        }
        self.completion?()
    }
}
