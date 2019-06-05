//Created  on 2019/6/1 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 * CD_PageControl 默认浮漂
 */




import Foundation
import UIKit

public extension CD_PageControlBuoy {
    struct Model {
        public var frame:CGRect = CGRect(x: 0, y: 0, w: CD_Page.Size.auto.rawValue, h: 3)
        public var lineColor:UIColor = UIColor.black
        public var lineRadiusClips:(CGFloat,Bool) = (1.5,true)
        public var style:LineStyle = .line(.bottom(0))
        //public var scrollDirection:CD_Page.Model.ScrollDirection = .horizontal
        
        public enum LineStyle {
            case line(_ position:Position)
            case background(_ position:Position)
        }
        public enum Position {
            case left(_ offset:CGFloat)
            case right(_ offset:CGFloat)
            case center(_ offset:CGFloat)
            case top(_ offset:CGFloat)
            case bottom(_ offset:CGFloat)
        }
        public var animotion:Animotion = .crawl
        public enum Animotion {
            /// 平移滑动
            case slide
            /// 毛毛虫
            case crawl
            case none
        }
        
        public init() {}
    }
}
public class CD_PageControlBuoy: UIView {
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
    func makeDefault() {
    }
    var _config:CD_PageControlBuoy.Model? {
        didSet {
            guard let model = _config else {return}
            let x = model.frame.origin.x
            let y = model.frame.origin.x
            let w = model.frame.size.width == CD_Page.Size.auto.rawValue ? 0 : model.frame.size.width
            let h = model.frame.size.height == CD_Page.Size.auto.rawValue ? 0 : model.frame.size.height
            self.cd
                .frame(CGRect(x: x, y: y, w: w, h: h))
                .corner(model.lineRadiusClips.0, clips: model.lineRadiusClips.1)
                .background(model.lineColor)
        }
    }
    
    lazy var frameBegain:CGRect = {
        return self.frame
    }()
    var offsetBegin:CGFloat = 0
    var isLock:Bool = false
}



//MARK:--- CD_PageControlBuoyProtocol ----------
extension CD_PageControlBuoy: CD_PageControlBuoyProtocol {
    
    public func scroll(willBeginDragging view: UIScrollView?, offset:CGFloat){
        guard !isLock else {return}
        self.offsetBegin = offset
        frameBegain = self.frame
        isLock = true
    }
    
    public func scroll(didScroll view: UIScrollView?, contentOffset:CGFloat, offsetRatio:CGFloat, size:CGFloat, index:Int, offsetItemWidthScale scale:CGFloat, scrollDirection:CD_Page.Model.ScrollDirection) {
        
        guard let model = config else { return }
        let minus = contentOffset - offsetBegin < 0
        let offset = (contentOffset - offsetBegin) * scale
        switch model.animotion {
        case .slide:
            var f = frameBegain
            switch scrollDirection {
            case .horizontal:
                f.origin.x += offset
            case .vertical:
                f.origin.y += offset
            }
            self.frame = f
        case .crawl:
            var f = frameBegain
            switch scrollDirection {
            case .horizontal:
                f.size.width += abs(offset)
                if minus {
                    f.origin.x -= abs(offset)
                }
            case .vertical:
                f.size.height += abs(offset)
                if minus {
                    f.origin.y -= abs(offset)
                }
            }
            self.frame = f
        case .none:
            break
        }
    }
    public func scroll(endScroll view: UIScrollView?, index:Int, item:UIView?, scrollDirection:CD_Page.Model.ScrollDirection, animotion:Bool){
        guard let superV = self.superview, let item = item else {
            return
        }
        guard let model = config else { return }
        
        // frame 更新
        var f = self.frame
        let itemFrame = item.frame
        switch model.style {
        case .line(let position) where scrollDirection == .horizontal:
            let auto = model.frame.size.width == CD_Page.Size.auto.rawValue
            f.origin.x = auto
                ? itemFrame.minX
                : (itemFrame.maxX-itemFrame.minX-f.size.width)/2.0 + itemFrame.minX
            f.size.width = auto
                ? item.frame.size.width
                : model.frame.size.width
            switch position {
            case .top(let ff):
                f.origin.y = superV.frame.minY+ff
            case .bottom(let ff):
                f.origin.y = superV.frame.maxY-f.size.height-ff
            case .center(let ff):
                f.origin.y = superV.center.y + ff
            default:
                f.origin.y = superV.frame.minY-f.size.height
            }
        case .line(let position) where scrollDirection == .vertical:
            let auto = model.frame.size.height == CD_Page.Size.auto.rawValue
            f.origin.y = auto
                ? itemFrame.minY
                : (itemFrame.maxY-itemFrame.minY-f.size.height)/2.0 + itemFrame.minY
            f.size.height = auto
                ? item.frame.size.height
                : model.frame.size.height
            switch position {
            case .left(let ff):
                f.origin.x = superV.frame.minX + ff
            case .right(let ff):
                f.origin.x = superV.frame.maxX - f.size.width - ff
            case .center(let ff):
                f.origin.y = superV.center.x + ff
            default:
                f.origin.x = superV.frame.minX
            }
            
        case .background(let position) where scrollDirection == .horizontal:
            let auto = model.frame.size.width == CD_Page.Size.auto.rawValue
            f.origin.x = auto
                ? itemFrame.minX
                : (itemFrame.maxX-itemFrame.minX-f.size.width)/2.0 + itemFrame.minX
            f.size.width = auto
                ? item.frame.size.width
                : model.frame.size.width
            switch position {
            case .top(let ff):
                f.origin.y = superV.frame.minY+ff
            case .bottom(let ff):
                f.origin.y = (superV.frame.maxY-f.size.height)/2.0-ff
            case .center(let ff):
                f.origin.y = superV.center.y + ff
            default:
                f.origin.y = (superV.frame.maxY-f.size.height)/2.0
            }
            
        case .background(let position) where scrollDirection == .vertical:
            let auto = model.frame.size.height == CD_Page.Size.auto.rawValue
            f.origin.y = auto
                ? itemFrame.minY
                : (itemFrame.maxY-itemFrame.minY-f.size.height)/2.0 + itemFrame.minY
            f.size.height = auto
                ? item.frame.size.height
                : model.frame.size.height
            switch position {
            case .left(let ff):
                f.origin.x = superV.frame.minX + ff
            case .right(let ff):
                f.origin.x = (superV.frame.minX-f.size.width)/2.0 - ff
            case .center(let ff):
                f.origin.y = superV.center.x + ff
            default:
                f.origin.x = (superV.frame.minX-f.size.width)/2.0
            }
            
        default:
            break
        }
        
        switch model.animotion {
        case .slide:
            self.frame = f
        case .crawl:
            if animotion {
                UIView.animate(withDuration: 0.2, animations: {[weak self] in
                    self?.frame = f
                }) { [weak self](bool) in
                    self?.frameBegain = self!.frame
                }
            }else{
                self.frame = f
                frameBegain = self.frame
            }
        case .none:
            break
        }
        isLock = false
    }
    public var config: CD_PageControlBuoy.Model? {
        get {
            return _config
        }
        set {
            _config = newValue
        }
    }
    public typealias ConfigModel = CD_PageControlBuoy.Model
}

