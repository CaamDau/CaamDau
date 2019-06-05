//Created  on 2019/5/29 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 * CD_PageControl 默认标签
 */




import UIKit
import CD
public struct CD_PageControlItemDataSource {
    public var id:String = ""
    public var title:String = ""
    public var img:UIImage?
    public var imgBg:UIImage?
    public init() {}
}

//MARK:--- Item ----------
extension CD_PageControlItem {
    public struct Model {
        public var colorSelected:UIColor = UIColor.black
        public var colorNormal:UIColor = UIColor.gray
        public var fontSelected: UIFont = UIFont.systemFont(ofSize: 15)
        public var fontNormal: UIFont = UIFont.systemFont(ofSize: 15)
        public var scaleTransform:CGFloat = 1
        
        public var lineColor:UIColor = UIColor.black
        public var lineRadiusClips:(CGFloat,Bool) = (1.5,true)
        public var lineSize:(w:CD_Page.Size,h:CD_Page.Size) = (w:CD_Page.Size.auto,h:CD_Page.Size.size(3))
        public var linePosition:Position = .top(0)
        public enum Animotion {
            case zoom
            case lineZoom
            case none
        }
        public enum Position {
            case left(_ offset:CGFloat)
            case right(_ offset:CGFloat)
            case top(_ offset:CGFloat)
            case center(_ offsetX:CGFloat,_ offsetY:CGFloat)
            case bottom(_ offset:CGFloat)
        }
        public var animotion:Animotion = .zoom
        public init() {}
    }
}

extension CD_PageControlItem: CD_PageControlItemProtocol {
    public var click: CD_PageControlDidSelectBlock? {
        get {
            return _didSelect
        }
        set {
            _didSelect = newValue
        }
    }
    public var config: CD_PageControlItem.Model? {
        get {
            return _config
        }
        set {
            _config = newValue
        }
    }
    public var dataSource: CD_PageControlItemDataSource? {
        get {
            return _dataSource
        }
        set {
            _dataSource = newValue
        }
    }
    
    public var scale: CGFloat {
        get {
            return _scale
        }
        set {
            _scale = newValue
        }
    }
    public typealias DataSource = CD_PageControlItemDataSource
    public typealias ConfigModel = CD_PageControlItem.Model
}

public class CD_PageControlItem: UIButton {
    private lazy var line: UIView = {
        return UIView().cd.background(UIColor.black).build
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        makeDefault()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        makeDefault()
    }
    convenience init() {
        self.init(frame:CGRect.zero)
    }
    
    private func makeDefault() {
        self._config = CD_PageControlItem.Model()
        self.addTarget(nil, action: #selector(clickButton(_:)), for: UIControl.Event.touchUpInside)
    }
    @objc private func clickButton(_ sender:CD_PageControlItem) {
        _didSelect?()
    }
    
    private func makeLine() {
        guard let m = _config else { return }
        switch m.animotion {
        case .lineZoom:
            guard !self.subviews.contains(line) else { return }
            self.cd.add(line)
            self.bringSubviewToFront(line)
            line.cd
                .background(UIColor.black)
                .corner(m.lineRadiusClips.0, clips: m.lineRadiusClips.1)
            makeLayoutLine(line,m)
            self.layoutIfNeeded()
        default:
            break
        }
    }
    
    
    private var _didSelect: CD_PageControlDidSelectBlock?
    private var _selectedRed:CGFloat   = 0.0
    private var _selectedGreen:CGFloat = 0.0
    private var _selectedBlue:CGFloat  = 0.0
    private var _selectedAlpha:CGFloat = 1.0
    private var _normalRed:CGFloat     = 0.0
    private var _normalGreen:CGFloat   = 0.0
    private var _normalBlue:CGFloat    = 0.0
    private var _normalAlpha:CGFloat   = 1.0
    
    ///选中颜色
    private var colorSelected:UIColor = UIColor.black {
        didSet{
            colorSelected.getRed(&_selectedRed, green: &_selectedGreen, blue: &_selectedBlue, alpha: &_selectedAlpha)
        }
    }
    ///未选中颜色
    private var colorNormal:UIColor = UIColor.gray {
        didSet{
            colorNormal.getRed(&_normalRed, green: &_normalGreen, blue: &_normalBlue, alpha: &_normalAlpha)
        }
    }
    ///选中字体
    private var fontSelected: UIFont = UIFont.systemFont(ofSize: 15)
    ///未选中字体
    private var fontNormal: UIFont = UIFont.systemFont(ofSize: 15)
    private var scaleTransform:CGFloat = 1
    
    private var _scale:CGFloat = 1 {
        didSet{
            switch _config?.animotion {
            case .some(.zoom):
                transformSelf = _scale
            case .some(.lineZoom):
                transformLine = _scale
            default:
                break
            }
            if (_scale == 1.0) {
                self.cd.text(fontSelected).text(colorSelected)
            }else if (_scale == 0.0){
                self.cd.text(fontNormal).text(colorNormal)
            }
        }
    }
    
    private var transformSelf:CGFloat = 1 {
        didSet{
            if colorSelected != colorNormal {
                let r = _normalRed + (_selectedRed - _normalRed) * transformSelf
                let g = _normalGreen + (_selectedGreen - _normalGreen) * transformSelf
                let b = _normalBlue + (_selectedBlue - _normalBlue) * transformSelf
                let a = _normalAlpha + (_selectedAlpha - _normalAlpha) * transformSelf
                self.cd.text(UIColor(red: r, green: g, blue: b, alpha: a))
            }
            let trueScale = scaleTransform + (1 - scaleTransform) * transformSelf
            transform = CGAffineTransform(scaleX: trueScale, y: trueScale)
        }
    }
    private var transformLine:CGFloat = 1 {
        didSet{
            guard let m = _config else { return }
            let trueScale = scaleTransform + (1 - scaleTransform) * transformLine
            var xx = trueScale
            var yy = trueScale
            switch m.linePosition {
            case .left, .right:
                xx = 1
            case .top, .bottom:
                yy = 1
            case .center:
                break
            }
            line.transform = CGAffineTransform(scaleX: xx, y: yy)
        }
    }
    
    private var _dataSource:CD_PageControlItemDataSource? {
        didSet{
            guard let item = _dataSource else { return }
            self.cd.text(item.title)
        }
    }
    
    private var _config:CD_PageControlItem.Model? {
        didSet {
            guard let m = _config else {return}
            colorSelected = m.colorSelected
            colorNormal = m.colorNormal
            fontSelected = m.fontSelected
            fontNormal = m.fontNormal
            scaleTransform = m.scaleTransform
            _scale = 0
            makeLine()
        }
    }
}



