//Created  on 2019/5/14 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 *
 */




import UIKit


public class CD_HUD: UIView {
    override public init(frame: CGRect) {
        super.init(frame: frame)
    }
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    public convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    var contentView:UIView?
    
    open var style:CD_HUD.Style = .text,
    title:String = "",
    detail:String = "",
    model:CD_HUD.Model = CD_HUD.modelDefault
}

extension CD_HUD {
    @discardableResult
    public func show(with supView:UIView? = cd_window(), style:CD_HUD.Style = .text, title:String = "", detail:String = "", model:CD_HUD.Model = CD_HUD.modelDefault) -> CD_HUD {
        self.style = style
        self.title = title
        self.detail = detail
        self.model = model
        return self.show(with: supView)
    }
    @discardableResult
    public func show(with supView:UIView? = cd_window()) -> CD_HUD {
        guard let view = supView else { return self }
        view.cd.add(self)
        makeUI()
        return self
    }
    
    func makeUI() {
        self.cd.background(model._colorMask)
        switch style {
        case .text, .loading, .info, .succeed, .warning, .error, .progress:
            let vv = CD_HUDContentView().cd
                .corner(model._radius, clips: true)
                .background(model._colorBg)
                .build
            contentView = vv
            self.cd.add(contentView)
            makeHUDLayot()
            vv.show(style, title: title, detail: detail, model: model)
        case .custom(let v):
            contentView = v
            self.cd.add(contentView)
            makeHUDLayot()
        }
        makeLayoutAnimation()
    }
    
    @discardableResult
    public func remove(_ duration:TimeInterval = -1) -> CD_HUD {
        guard duration != 0 else {
            self.removeAnimation()
            return self
        }
        var duration = duration
        if duration == -1 {
            let count:TimeInterval = Double((title.count + detail.count)) * 0.1
            let time = count < model._duration.min
                ? model._duration.min
                : (count > model._duration.max
                    ? model._duration.max
                    : count)
            duration = time
        }
        CD_CountDown.after(duration) {[weak self] in
            self?.removeAnimation()
        }
        return self
    }
    
    private func removeAnimation() {
        makeLayoutAnimation(true)
    }
}


public extension CD_HUD {
    public enum Style {
        case text
        case loading(_ l:Loading?)
        case info
        case succeed
        case warning
        case error
        case progress(_ l:Progress)
        case custom(_ view:UIView)
        
        public enum Loading {
            /// 系统菊花
            case activity
            /// 环
            case ring
            /// 钻戒
            case diamond
            /// 毛笔墨
            case brush
            /// 写轮眼
            case roundEyes
            /// refresh 箭头
            case arrow
            /// 自定义 Gif 动画组
            case images(_ images:[UIImage], _ duration:TimeInterval, _ repeatCount:Int)
            /// 自定义 View
            case view(_ view:UIView)
        }
        
        public enum Progress {
            /// 默认
            case `default`(model:CD_HUDProgressView.Model, handler:((CD_HUDProgressView?)->Void)?)
            /// 自定义 View
            case view(_ view:UIView)
        }
    }
}

public extension CD_HUD {
    public enum Axis {
        case vertical
        case horizontal
    }
    
    public enum Position {
        case top
        case center
        case bottom
        /// offsetY > 0 以top为参照  < 0 以bottom为参照
        case custom(_ offsetY:CGFloat)
    }
    
    public enum Animation {
        case fade
        case slide
        case zoom
        /// 弹簧动画 只适用 HUD显示 & Position .top .bottom .custom(_ point:CGPoint)
        case spring
        /// 自定义动画
        case custom(_ animat:((_ hud:CD_HUD?, _ contentView:UIView?)->Void)?)
        case none
    }
}

public extension CD_HUD {
    public static var modelDefault:Model = CD_HUD.Model()
    public struct Model {
        public init() {}
        /// HUD 蒙板 边距
        public var _margeMask:CGFloat = 40
        /// HUD 蒙板 背景色
        public var _colorMask:UIColor = UIColor.black.cd_alpha(0)
        /// HUD 蒙板 背景 是否允许 透传交互
        public var _isEnabledMask = false
        /// HUD 持续时间
        public var _duration:(min:TimeInterval, max:TimeInterval) = (min:1.5, max:10)
        /// 动画时长
        public var _animoteDuration = 0.2
        /// Position .top 下 顶部边距
        public var _offsetTopY:CGFloat = cd_sysNavigationH()
        /// Position .bottom 下 底部边距
        public var _offsetBottomY:CGFloat = cd_sysTabBarH()
        
        /// contentView 布局样式
        public var _position:CD_HUD.Position = .center
        /// contentView 显示方式
        public var _showAnimation:CD_HUD.Animation = .zoom
        /// contentView 消失方式
        public var _hiddenAnimat:CD_HUD.Animation = .zoom
        /// contentView 布局样式
        public var _axis:CD_HUD.Axis = .vertical
        /// contentView 背景色
        public var _colorBg:UIColor = UIColor.black.cd_alpha(0.9)
        /// contentView radius
        public var _radius:CGFloat = 6
        /// contentView marge 内边距
        public var _marge:CGFloat = 10
        /// contentView marge 内间距
        public var _space:CGFloat = 10
        /// contentView 保持方形
        /// 对 Axis vertical 布局Style:loading、info、succeed、warning、error有效
        public var _isSquare:Bool = true
        /// contentView title 行数限制
        public var _linesTitle:Int = 0
        /// contentView detail 行数限制
        public var _linesDetail:Int = 0
        /// contentView title detail 对齐方式
        public var _textAlignment:NSTextAlignment = .center
        /// contentView title font
        public var _fontTitle:UIFont = UIFont.systemFont(ofSize: 16)
        /// contentView title font
        public var _fontDetail:UIFont = UIFont.systemFont(ofSize: 14)
        
        /// contentView title textColor
        public var _colorTitle:UIColor = UIColor.white
        /// contentView detail textColor
        public var _colorDetail:UIColor = UIColor.white
        /// contentView activity/loading icon color
        public var _colorActivity:UIColor = UIColor.white
        /// contentView 是否背景毛玻璃
        public var _isBlurEffect:Bool = false
        /// contentView 是否设置阴影
        public var _isShadow:Bool = false
        /// contentView 阴影
        public var _shadow:(UIColor, Float, CGSize, CGFloat) = (UIColor.gray, 1, .zero, 6)
        
        
    }
}


public extension CD where Base: UIView {
    @discardableResult
    func hud(_ style:CD_HUD.Style = .text,
             title:String = "",
             detail:String = "",
             model:CD_HUD.Model = CD_HUD.modelDefault,
             duration:TimeInterval = -1) -> CD {
        let v = CD_HUD()
        v.show(with:base, style:style, title: title, detail: detail, model: model)
        switch style {
        case .text, .info, .succeed, .warning, .error:
            v.remove(duration)
        default:
            break
        }
        return self
    }
    @discardableResult
    func hud_remove(_ duration:TimeInterval = 0, animation:Bool = true) -> CD  {
        base.subviews.forEach { (v) in
            guard let vv = v as? CD_HUD else{return}
            if !animation {
                vv.model._hiddenAnimat = .none
            }
            vv.remove(duration)
        }
        return self
    }
}

public extension CD_HUD {
    public static func show(with view:UIView,
                            style:CD_HUD.Style = .text,
                            title:String = "",
                            detail:String = "",
                            model:CD_HUD.Model = CD_HUD.modelDefault,
                            duration:TimeInterval = -1) {
        let v = CD_HUD()
        v.show(with:view, style:style, title: title, detail: detail, model: model)
        switch style {
        case .text, .info, .succeed, .warning, .error:
            v.remove(duration)
        default:
            break
        }
    }
    
    public static func remove(for view:UIView, duration:TimeInterval = 0, animation:Bool = true) {
        view.subviews.forEach { (v) in
            guard let vv = v as? CD_HUD else{return}
            if !animation {
                vv.model._hiddenAnimat = .none
            }
            vv.remove(duration)
        }
    }
}
