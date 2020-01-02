//Created  on 2019/5/17 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 *
 */




import UIKit

public class CD_HUDProgressView: UIView {
    override public init(frame: CGRect) {
        super.init(frame: frame)
        makeDefault()
    }
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        makeDefault()
    }
    public convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    lazy var trackLayer: CAShapeLayer = {
        let lay = CAShapeLayer()
        lay.frame = bounds
        lay.fillColor = UIColor.clear.cgColor
        lay.strokeColor = model.colorTrack.cgColor
        lay.lineWidth = model.lineWidth
        lay.lineCap = model.isRoundTrack ? .round : .butt
        return lay
    }()
    
    lazy var progressLayer:CAShapeLayer = {
        let lay = CAShapeLayer()
        lay.frame = bounds
        lay.fillColor = UIColor.clear.cgColor
        lay.strokeColor = model.colorProgress.cgColor
        lay.lineWidth = model.lineWidth
        lay.lineCap = model.isRoundProgress ? .round : .butt
        self.layer.addSublayer(lay)
        return lay
    }()
    lazy var path:UIBezierPath = {
        return UIBezierPath()
    }()
    
    lazy var lab_num:UILabel = {
        return UILabel().cd
            .text(model.fontTitle)
            .text(model.colorTitle)
            .build
    }()
    
    open var model:CD_HUDProgressView.Model = CD_HUDProgressView.Model() {
        didSet{
            trackLayer.strokeColor = model.colorTrack.cgColor
            trackLayer.lineWidth = model.lineWidth
            trackLayer.lineCap = model.isRoundTrack ? .round : .butt
            progressLayer.strokeColor = model.colorProgress.cgColor
            progressLayer.lineWidth = model.lineWidth
            progressLayer.lineCap = model.isRoundProgress ? .round : .butt
            lab_num.cd.text(model.fontTitle).text(model.colorTitle)
            self.setNeedsDisplay()
        }
    }
    open var handler:((CD_HUDProgressView?) -> Void)? = nil {
        didSet{
            weak var vv:CD_HUDProgressView? = self
            handler?(vv)
        }
    }
    
    open var progress: CGFloat = 0 {
        didSet {
            if progress > 100 {
                progress = 100
            }else if progress < 0 {
                progress = 0
            }
            updateProgress(progress, duration: 0.5)
        }
    }
    
    override public func draw(_ rect: CGRect) {
        path.addArc(withCenter: CGPoint(x: bounds.midX, y: bounds.midY),
                    radius: bounds.size.width/2 - model.lineWidth,
                    startAngle: radian(-90), endAngle: radian(270), clockwise: true)
        lab_num.cd
            .bounds(CGRect( w: bounds.size.width - model.lineWidth*2, h: bounds.size.width - model.lineWidth*2))
            .center(self.center)
            .text(NSTextAlignment.center)
            .text(String(format: "%.1f", progress) + "%")
        trackLayer.path = path.cgPath
        progressLayer.path = path.cgPath
        progressLayer.strokeStart = 0
        progressLayer.strokeEnd = progress/100.0
    }
    
    
}
extension CD_HUDProgressView {
    private func makeDefault() {
        self.layer.addSublayer(trackLayer)
        self.layer.addSublayer(progressLayer)
        self.addSubview(lab_num)
    }
    private func radian(_ angle: CGFloat)->CGFloat {
        return angle/180.0 * CGFloat.pi
    }
    private func updateProgress(_ pro: CGFloat, duration: Double) {
        lab_num.cd.text(String(format: "%.1f", pro) + "%")
        CATransaction.begin()
        CATransaction.setDisableActions(false)
        CATransaction.setAnimationTimingFunction(CAMediaTimingFunction(name:
            .easeInEaseOut))
        CATransaction.setAnimationDuration(duration)
        progressLayer.strokeEnd = progress/100.0
        CATransaction.commit()
    }
}

extension CD_HUDProgressView {
    public struct Model {
        ///进度条宽度
        public var lineWidth: CGFloat = 5
        ///进度槽是否圆角
        public var isRoundTrack:Bool = false
        ///进度条是否圆角
        public var isRoundProgress:Bool = true
        ///进度槽颜色
        public var colorTrack = UIColor.cd_hex("f0", dark: "3").cd_alpha(0.3)
        ///进度条颜色
        public var colorProgress = UIColor.cd_hex("f", dark: "0")
        /// 数值 颜色
        public var colorTitle:UIColor = UIColor.cd_hex("f", dark: "0")
        /// 数值 字体
        public var fontTitle:UIFont = UIFont.systemFont(ofSize: 12)
        
        public init() {}
    }
}
