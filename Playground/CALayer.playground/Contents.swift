//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

class RingView:UIView {
    let ww:CGFloat = 60,
    radius:CGFloat = 30,
    startAngle:CGFloat = CGFloat.pi*1.5,
    endAngle:CGFloat = CGFloat.pi*1.5
    
    lazy var ringLayer: CAShapeLayer = {
        let path = UIBezierPath(arcCenter: CGPoint(x: ww/2, y: ww/5), radius: radius , startAngle: startAngle, endAngle: endAngle, clockwise: false)
        let ring = CAShapeLayer()
        ring.frame = CGRect(x: 0, y: 0, width: ww, height: ww)
        ring.fillColor = UIColor.gray.cgColor
        ring.strokeColor = UIColor.white.cgColor
        ring.lineWidth = 3
        ring.lineCap = .round
        ring.lineJoin = .bevel
        ring.path = path.cgPath
        return ring
    }()
    
    func ringLayerAnimated() {
        let widthDiff = self.bounds.size.width - layer.bounds.size.width
        let heightDiff = self.bounds.size.height - layer.bounds.size.height
        ringLayer.position = CGPoint(x:self.bounds.size.width - layer.bounds.size.width / 2 - widthDiff / 2, y:self.bounds.size.height - layer.bounds.size.height / 2 - heightDiff / 2)
        
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.addSublayer(ringLayer)
        ringLayerAnimated()
        print(ringLayer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

class LoadingView: UIView {
    let pi = CGFloat.pi
    public var lineWidth: Int = 2  //线的宽度  默认为2
    public var lineColor: UIColor = UIColor.white //线的颜色  默认是红色
    fileprivate var timer: Timer?
    fileprivate var originStart: CGFloat = CGFloat.pi*1.5 //开始位置
    fileprivate var originEnd: CGFloat = CGFloat.pi*1.5   //结束位置  都是顶部
    fileprivate var isDraw: Bool = true
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 10 //圆角  纯属好看
        self.layer.masksToBounds = true
        
        self.timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(LoadingView.updateLoading), userInfo: nil, repeats: true)  //创建计时器
        RunLoop.main.add(self.timer!, forMode: .default)//计时器需要加入到RunLoop中：RunLoop的目的是让你的线程在有工作的时候忙碌，没有工作的时候休眠
        self.timer?.fire()
        
    }
    
    @objc func updateLoading () {
        if (self.originEnd == pi*1.5 && isDraw) {//从无到有的过程
            self.originStart += (pi/10)
            if (self.originStart == pi*1.5 + 2*pi) {
                self.isDraw = false
                self.setNeedsDisplay() //调用 draw(_ rect: CGRect) 方法
                return
            }
        }
        
        if (self.originStart == pi*1.5 + 2*pi && !self.isDraw) { //从有到无
            self.originEnd += (pi/10)
            if (self.originEnd == pi*1.5 + 2*pi) {
                self.isDraw = true
                self.originStart = pi*1.5
                self.originEnd = pi*1.5
                self.setNeedsDisplay() //调用 draw(_ rect: CGRect) 方法
                return
            }
        }
        self.setNeedsDisplay() //调用 draw(_ rect: CGRect) 方法
    }
    
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext() //获取上下文
        let center: CGPoint = CGPoint(x: self.frame.size.width / 2, y: self.frame.size.height / 2) // 确定圆心
        let radius = min(self.frame.size.width, self.frame.size.height) / 2 - CGFloat(self.lineWidth); //半径
        let path: UIBezierPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: self.originStart, endAngle: self.originEnd, clockwise: false) //弧的路径
        context?.addPath(path.cgPath) //将路径、宽度、颜色添加到上下文
        context?.setLineWidth(CGFloat(self.lineWidth)) //
        context?.setStrokeColor(self.lineColor.cgColor) //
        context?.strokePath() //显示弧
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


public class HUDProgressView: UIView {
    
    let ww:CGFloat = 60,
    radius:CGFloat = 30
    
    lazy var trackLayer: CAShapeLayer = {
        let lay = CAShapeLayer()
        //绘制进度槽
        lay.frame = bounds
        lay.fillColor = UIColor.clear.cgColor
        lay.strokeColor = Model.colorTrack.cgColor
        lay.lineWidth = Model.lineWidth
        
        self.layer.addSublayer(lay)
        return lay
    }()
    
    lazy var progressLayer:CAShapeLayer = {
        let lay = CAShapeLayer()
        //绘制进度条
        lay.frame = bounds
        lay.fillColor = UIColor.clear.cgColor
        lay.strokeColor = Model.colorProgress.cgColor
        lay.lineWidth = Model.lineWidth
        lay.lineCap = .round
        self.layer.addSublayer(lay)
        return lay
    }()
    let path = UIBezierPath()
    
    //当前进度
    var progress: CGFloat = 0 {
        didSet {
            if progress > 100 {
                progress = 100
            }else if progress < 0 {
                progress = 0
            }
            setProgress(progress, animated: true, duration: 0.5)
        }
    }
    
    
    private func setProgress(_ pro: CGFloat, animated: Bool, duration: Double) {
        print("setProgress")
        UIView.animate(withDuration: duration, animations: {
            self.progressLayer.strokeEnd = self.progress/100.0
        }) { (bool) in
            
        }
        /*
        CATransaction.begin()
        CATransaction.setDisableActions(!animated)
        CATransaction.setAnimationTimingFunction(CAMediaTimingFunction(name:
            .easeInEaseOut))
        CATransaction.setAnimationDuration(duration)
        progressLayer.strokeEnd = progress/100.0
        CATransaction.commit()*/
    }
    
    public override func draw(_ rect: CGRect) {
        print("ProgressView draw")
        
        path.addArc(withCenter: CGPoint(x: bounds.midX, y: bounds.midY),
                    radius: bounds.size.width/2 - Model.lineWidth,
                    startAngle: radius(-90), endAngle: radius(270), clockwise: true)
        trackLayer.path = path.cgPath
        progressLayer.path = path.cgPath
        progressLayer.strokeStart = 0
        progressLayer.strokeEnd = progress/100.0
        
        
    }
    
    
    private func radius(_ angle: CGFloat)->CGFloat {
        return angle/180.0 * CGFloat.pi
    }
}
extension HUDProgressView {
    func makeDefault() {
        self.heightAnchor.constraint(equalToConstant: 60).isActive = true
        self.widthAnchor.constraint(equalToConstant: 60).isActive = true
    }
}

extension HUDProgressView {
    struct Model {
        //进度条宽度
        static let lineWidth: CGFloat = 5
        //进度槽颜色
        static let colorTrack = UIColor.lightGray
        //进度条颜色
        static let colorProgress = UIColor.red
    }
}
@IBDesignable class OProgressView: UIView {
    
    struct Constant {
        //进度条宽度
        static let lineWidth: CGFloat = 10
        //进度槽颜色
        static let trackColor = UIColor(red: 245/255.0, green: 245/255.0, blue: 245/255.0,
                                        alpha: 1)
        //进度条颜色
        static let progressColoar = UIColor.orange
    }
    
    //进度槽
    let trackLayer = CAShapeLayer()
    //进度条
    let progressLayer = CAShapeLayer()
    //进度条路径（整个圆圈）
    let path = UIBezierPath()
    
    //当前进度
    @IBInspectable var progress: Int = 0 {
        didSet {
            if progress > 100 {
                progress = 100
            }else if progress < 0 {
                progress = 0
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func draw(_ rect: CGRect) {
        //获取整个进度条圆圈路径
        path.addArc(withCenter: CGPoint(x: bounds.midX, y: bounds.midY),
                    radius: bounds.size.width/2 - Constant.lineWidth,
                    startAngle: -(.pi/2), endAngle: .pi/2*3, clockwise: true)
        
        //绘制进度槽
        trackLayer.frame = bounds
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.strokeColor = Constant.trackColor.cgColor
        trackLayer.lineWidth = Constant.lineWidth
        trackLayer.path = path.cgPath
        layer.addSublayer(trackLayer)
        
        //绘制进度条
        progressLayer.frame = bounds
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.strokeColor = Constant.progressColoar.cgColor
        progressLayer.lineWidth = Constant.lineWidth
        progressLayer.path = path.cgPath
        progressLayer.strokeStart = 0
        progressLayer.strokeEnd = CGFloat(progress)/100.0
        layer.addSublayer(progressLayer)
    }
    
    //设置进度（可以设置是否播放动画）
    func setProgress(_ pro: Int,animated anim: Bool) {
        setProgress(pro, animated: anim, withDuration: 0.55)
    }
    
    //设置进度（可以设置是否播放动画，以及动画时间）
    func setProgress(_ pro: Int,animated anim: Bool, withDuration duration: Double) {
        progress = pro
        //进度条动画
        CATransaction.begin()
        CATransaction.setDisableActions(!anim)
        CATransaction.setAnimationTimingFunction(CAMediaTimingFunction(name:.easeInEaseOut))
        CATransaction.setAnimationDuration(duration)
        progressLayer.strokeEnd = 0.5
        CATransaction.commit()
    }
    
    //将角度转为弧度
    fileprivate func angleToRadian(_ angle: Double)->CGFloat {
        return CGFloat(angle/Double(180.0) * .pi)
    }
}


class MyViewController : UIViewController {
    override func loadView() {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 320, height: 568))
        view.backgroundColor = .white
        
        do{
            let vv = RingView(frame: CGRect(x: 100, y: 20, width: 60, height: 60))
            vv.backgroundColor = UIColor.black
            view.addSubview(vv)
            vv.ringLayerAnimated()
        }
        do{
            let vv = LoadingView(frame: CGRect(x: 100, y: 100, width: 60, height: 60))
            view.addSubview(vv)
            vv.backgroundColor = UIColor.black
        }
        do{
            let vv = HUDProgressView(frame: CGRect(x: 100, y: 200, width: 60, height: 60))
            view.addSubview(vv)
            vv.backgroundColor = UIColor.black
            vv.progress = 10
            DispatchQueue.main.asyncAfter(deadline: .now() + 4) {[weak vv] in
                //print("asyncAfter")
                //vv?.progressLayer.strokeStart = 0
                //vv?.progressLayer.strokeEnd = 0
                //vv?.trackLayer.strokeColor = HUDProgressView.Model.colorProgress.cgColor
                //vv?.progressLayer.strokeColor = HUDProgressView.Model.colorTrack.cgColor
                print("progressLayer")
                vv?.progress = 20
            }
        }
        do{
            let vv = OProgressView(frame: CGRect(x: 100, y: 300, width: 60, height: 60))
            view.addSubview(vv)
            vv.backgroundColor = UIColor.black
            vv.setProgress(1, animated: true)
            DispatchQueue.main.asyncAfter(deadline: .now() + 4) {[weak vv] in
                //print("asyncAfter")
                //vv?.progressLayer.strokeStart = 0
                //vv?.progressLayer.strokeEnd = 0
                //vv?.trackLayer.strokeColor = HUDProgressView.Model.colorProgress.cgColor
                //vv?.progressLayer.strokeColor = HUDProgressView.Model.colorTrack.cgColor
                print("progressLayer")
                vv?.setProgress(5, animated: true)
            }
        }
        
        
        
        self.view = view
    }
}
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
