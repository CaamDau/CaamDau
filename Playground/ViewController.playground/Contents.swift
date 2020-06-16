//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport
/*
extension UIColor {
    var cd_rgba:(CGFloat,CGFloat,CGFloat,CGFloat) {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 1
        self.getRed(&r, green: &g, blue: &b, alpha: &a)
        return (r,g,b,a)
    }
}

class CD_GradientLayer:CALayer {
    var point: CGPoint = CGPoint.zero
    var colorSpace = CGColorSpaceCreateDeviceRGB()
    var locations:[CGFloat] = [0.0, 1.0]
    var colors:[CGFloat] = [0.0,0.0,0.0,0.0,0.0,0.0,0.0,1.0]
    lazy var radius: CGFloat = {
        return max(self.bounds.size.width, self.bounds.size.height)
    }()
    override func draw(in ctx: CGContext) {
        guard let gradient = CGGradient(colorSpace: colorSpace, colorComponents: colors, locations: locations, count: locations.count) else {
            return
        }
        ctx.drawRadialGradient(gradient, startCenter: point, startRadius: 0, endCenter: point, endRadius: radius, options: .drawsAfterEndLocation)
    }
}

extension UIView {
    /// 设置背景线性渐变 默认横向渐变 point -> 0 - 1
    func gradient(layerAxial gradients:[(color:UIColor,location:Float)], point:(start:CGPoint, end:CGPoint) = (start:CGPoint(x: 0, y: 0), end:CGPoint(x: 1, y: 0)), at: UInt32 = 0, updateIndex:Int? = nil, then:((CAGradientLayer)->Void)? = nil)  {
        func gradient(_ layer:CAGradientLayer) {
            self.layoutIfNeeded()
            layer.colors = gradients.map{$0.color.cgColor}
            layer.locations = gradients.map{NSNumber(value:$0.location)}
            layer.startPoint = point.start
            layer.endPoint = point.end
            layer.frame = self.bounds
        }
        let layers:[CAGradientLayer] = self.layer.sublayers?.filter{$0.isKind(of: CAGradientLayer.self)}.map{$0} as? [CAGradientLayer] ?? []
        if layers.count <= at {
            let layer = CAGradientLayer()
            gradient(layer)
            self.layer.insertSublayer(layer, at: at)
            then?(layer)
        }else{
            let layer = layers[updateIndex ?? 0]
            gradient(layer)
            then?(layer)
        }
    }
    
    func gradient(layerRadial gradients:[(color:UIColor,location:CGFloat)], point:CGPoint = CGPoint(x: 0, y: 0), radius:CGFloat? = nil, at: UInt32 = 0, updateIndex:Int? = nil, then:((CD_GradientLayer)->Void)? = nil) {
        
        
        func gradient(_ layer:CD_GradientLayer) {
            self.layoutIfNeeded()
            layer.locations = gradients.map{$0.location}
            layer.colors =  Array(gradients.map({ (c) -> [CGFloat] in
                let cc = c.color.cd_rgba
                return [cc.0,cc.1,cc.2,cc.3]
            }).joined())
            layer.frame = self.bounds
            layer.point = point
            layer.radius = radius ?? max(self.bounds.size.width, self.bounds.size.height)
            layer.setNeedsDisplay()
        }
        let layers:[CD_GradientLayer] = self.layer.sublayers?.filter{$0.isKind(of: CD_GradientLayer.self)}.map{$0} as? [CD_GradientLayer] ?? []
        if layers.count <= at {
            let layer = CD_GradientLayer()
            gradient(layer)
            self.layer.insertSublayer(layer, at: at)
            then?(layer)
        }else{
            let layer = layers[updateIndex ?? 0]
            gradient(layer)
            then?(layer)
        }
    }
}

extension UIImage {
    /// - 由颜色 生成图片
    static func cd_color(_ color: UIColor) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img!
    }
}

class BeView:UIView {
    override func draw(_ rect: CGRect) {
        let p = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 50, height: 50))
        UIColor.blue.setFill()
        p.fill()
    }
}

public struct UIRectSide : OptionSet {
    
    public let rawValue: Int
    
    public static let left = UIRectSide(rawValue: 1 << 0)
    
    public static let top = UIRectSide(rawValue: 1 << 1)
    
    public static let right = UIRectSide(rawValue: 1 << 2)
    
    public static let bottom = UIRectSide(rawValue: 1 << 3)
    
    public static let all: UIRectSide = [.top, .right, .left, .bottom]
    
    
    
    public init(rawValue: Int) {
        
        self.rawValue = rawValue;
        
    }
    
}

extension UIView{
    ///画虚线边框
    func drawDashLine(strokeColor: UIColor, lineWidth: CGFloat = 1, lineLength: Int = 10, lineSpacing: Int = 5, corners: UIRectSide) {
        
        let shapeLayer = CAShapeLayer()
        
        shapeLayer.bounds = self.bounds
        
        shapeLayer.anchorPoint = CGPoint(x: 0, y: 0)
        
        shapeLayer.fillColor = UIColor.blue.cgColor
        
        shapeLayer.strokeColor = strokeColor.cgColor
        
        
        
        shapeLayer.lineWidth = lineWidth
        
        shapeLayer.lineJoin = CAShapeLayerLineJoin.round
        
        
        
        //每一段虚线长度 和 每两段虚线之间的间隔
        
        shapeLayer.lineDashPattern = [NSNumber(value: lineLength), NSNumber(value: lineSpacing)]
        
        
        
        let path = CGMutablePath()
        
        if corners.contains(.left) {
            
            path.move(to: CGPoint(x: 0+lineWidth, y: self.layer.bounds.height))
            
            path.addLine(to: CGPoint(x: 0+lineWidth, y: 0))
            
        }
        
        if corners.contains(.top){
            
            path.move(to: CGPoint(x: 0, y: 0+lineWidth))
            
            path.addLine(to: CGPoint(x: self.layer.bounds.width, y: 0+lineWidth))
            
        }
        
        if corners.contains(.right){
            
            path.move(to: CGPoint(x: self.layer.bounds.width-lineWidth, y: 0))
            
            path.addLine(to: CGPoint(x: self.layer.bounds.width-lineWidth, y: self.layer.bounds.height))
            
        }
        
        if corners.contains(.bottom){
            
            path.move(to: CGPoint(x: self.layer.bounds.width, y: self.layer.bounds.height-lineWidth))
            
            path.addLine(to: CGPoint(x: 0, y: self.layer.bounds.height-lineWidth))
            
        }
        
        shapeLayer.path = path
        
        self.layer.addSublayer(shapeLayer)
        
    }
    
    ///画实线边框
    
    func drawLine(strokeColor: UIColor, lineWidth: CGFloat = 1, corners: UIRectSide) {
        
        
        
        if corners == UIRectSide.all {
            
            self.layer.borderWidth = lineWidth
            
            self.layer.borderColor = strokeColor.cgColor
            
        }else{
            
            let shapeLayer = CAShapeLayer()
            
            shapeLayer.bounds = self.bounds
            
            shapeLayer.anchorPoint = CGPoint(x: 0, y: 0)
            
            shapeLayer.fillColor = UIColor.blue.cgColor
            
            shapeLayer.strokeColor = strokeColor.cgColor
            
            
            
            shapeLayer.lineWidth = lineWidth
            
            shapeLayer.lineJoin = CAShapeLayerLineJoin.round
            
            
            
            let path = CGMutablePath()
            
            
            
            if corners.contains(.left) {
                
                path.move(to: CGPoint(x: 0, y: self.layer.bounds.height))
                
                path.addLine(to: CGPoint(x: 0, y: 0))
                
            }
            
            if corners.contains(.top){
                
                path.move(to: CGPoint(x: 0, y: 0))
                
                path.addLine(to: CGPoint(x: self.layer.bounds.width, y: 0))
                
            }
            
            if corners.contains(.right){
                
                path.move(to: CGPoint(x: self.layer.bounds.width, y: 0))
                
                path.addLine(to: CGPoint(x: self.layer.bounds.width, y: self.layer.bounds.height))
                
            }
            
            if corners.contains(.bottom){
                
                path.move(to: CGPoint(x: self.layer.bounds.width, y: self.layer.bounds.height))
                
                path.addLine(to: CGPoint(x: 0, y: self.layer.bounds.height))
                
            }
            
            
            
            shapeLayer.path = path
            
            self.layer.addSublayer(shapeLayer)
            
            
            
        }
        
        
        
    }
    
}

class MyViewController : UIViewController {
    override func loadView() {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 320, height: 568))
        view.backgroundColor = .white
        do{
            let vv = UIView(frame: CGRect(x: 0, y: 20, width: 150, height: 50))
            view.addSubview(vv)
            vv.gradient(layerAxial: [(UIColor.red, 0.0),
                                     (UIColor.yellow, 0.5),
                                     (UIColor.blue, 1.0)], at:0)
            
            vv.gradient(layerAxial: [(UIColor.black, 0.0),
                                     (UIColor.yellow, 0.5),
                                     (UIColor.black, 1.0)], at:1)
            
            vv.gradient(layerAxial: [(UIColor.blue, 0.0),
                                     (UIColor.gray, 0.5),
                                     (UIColor.orange, 1.0)], updateIndex:1)
        }
        do{
            let vvv = UIView(frame: CGRect(x: 160, y: 20, width: 150, height: 50))
            view.addSubview(vvv)
            let vv = UIView(frame: vvv.bounds)
            vvv.addSubview(vv)
            vv.gradient(layerRadial: [
                (UIColor.black.withAlphaComponent(0.0), 0.0),
                (UIColor.red.withAlphaComponent(0.6), 1.0)
                ],point:CGPoint(x: 0, y: 30), radius:200, at:0)
            
            vv.gradient(layerRadial: [
                (UIColor.black.withAlphaComponent(0.0), 0.0),
                (UIColor.yellow.withAlphaComponent(0.6), 1.0)
                ],point:CGPoint(x: 0, y: 30), radius:150, at:1)
            
            vv.gradient(layerRadial: [
                (UIColor.black.withAlphaComponent(0.0), 0.0),
                (UIColor.blue.withAlphaComponent(0.6), 1.0)
                ],point:CGPoint(x: 0, y: 30), radius:100, at:2)
            
        }
        
        do{
            let vv = UIView(frame: CGRect(x: 0, y: 100, width: 150, height: 30))
            view.addSubview(vv)
            
            let str = "我们国家是世界上最强大的"
            let lab = UILabel(frame: CGRect(x: 0, y: 0, width: 150, height: 30))
            //lab.backgroundColor = UIColor.gray
            lab.text = str
            vv.addSubview(lab)
            /*vv.gradient(layerAxial: [(UIColor.red, 0.0),
            (UIColor.yellow, 0.5),
            (UIColor.blue, 1.0)], at:0, then:{ layer in
                layer.mask = lab.layer
            })*/
            
            vv.gradient(layerRadial: [
            (UIColor.black.withAlphaComponent(0.2), 0.0),
            (UIColor.red.withAlphaComponent(0.9), 1.0)
            ],point:CGPoint(x: 0, y: 10), radius:200, at:0, then:{ layer in
                layer.mask = lab.layer
            })
            
            
            
            let str64 = str.data(using: String.Encoding.utf8, allowLossyConversion: true)?.base64EncodedString() ?? ""
            
            let data = Data(base64Encoded: str64)
            let img = UIImage(data: data ?? Data())
            let imageView = UIImageView(frame: CGRect(x: 10, y: 150, width: 100, height: 30))
            imageView.backgroundColor = UIColor.red
            imageView.image = img
            
            imageView.drawDashLine(strokeColor: UIColor.black, lineWidth: 1, lineLength: 3, lineSpacing: 2, corners: [.left, .bottom, .right, .top])
            imageView.layer.cornerRadius = 6
            imageView.clipsToBounds = true
            view.addSubview(imageView)
            
        }
        do{
            let imgView = BeView(frame: CGRect(x: 160, y: 100, width: 150, height: 30))
            
            let size = imgView.bounds.size
            let width = size.width
            let height = size.height
            
            let path = UIBezierPath()
            path.move(to: CGPoint(x: 0, y: height))
            path.addLine(to: CGPoint(x: 0 , y: height+3))
            path.addLine(to: CGPoint(x: width/2-3, y: height+3))
            path.addLine(to: CGPoint(x: width/2, y: height+6))
            path.addLine(to: CGPoint(x: width/2+3, y: height+3))
            path.addLine(to: CGPoint(x:width, y: height))
            
            path.addLine(to: CGPoint(x: width, y: height+3))
            path.addLine(to: CGPoint(x:width, y: height))
            path.addLine(to: CGPoint(x: width/2+3, y: height))
            path.addLine(to: CGPoint(x: width/2, y: height+3))
            path.addLine(to: CGPoint(x: width/2-3, y: height))
           path.addLine(to: CGPoint(x: 0, y: height))
            path.close()
            
            imgView.layer.shadowPath = path.cgPath
            imgView.layer.shadowColor = UIColor.black.cgColor
            imgView.layer.shadowOpacity = 1
            imgView.layer.shadowRadius = 3
            imgView.layer.shadowOffset = CGSize(width: 0, height: 0)
            
            view.addSubview(imgView)
        }
        
        self.view = view
    }
}*/

class VC_Button : UIViewController {
    override func loadView() {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 320, height: 568))
        view.backgroundColor = .white
        do{
            let button = UIButton(frame: CGRect(x: 30, y: 30, width: 60, height: 30))
            button.backgroundColor = UIColor.red
            button.addTarget(self, action: #selector(buttonClick(_:)), for: .touchUpOutside)
            view.addSubview(button)
        }
        self.view = view
    }
    
    @objc func buttonClick(_ sender:Any) {
        print("点击了")
    }
}
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = VC_Button()

/*
UIBezierPath *maskPath=[[UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(10, 10)] bezierPathByReversingPath];
CAShapeLayer *border = [CAShapeLayer layer];
// 线条颜色
border.strokeColor = [UIColor hexStringToColor:@"#999999"].CGColor;
border.masksToBounds = YES;

border.fillColor = nil;
border.path = maskPath.CGPath;
border.frame = view.bounds;

border.lineWidth = 1;
border.lineCap = @"square";
// 第一个是 线条长度 第二个是间距 nil时为实线
border.lineDashPattern = @[@6, @4];
[view.layer addSublayer:border];
---------------------
作者：haluRay
来源：CSDN
原文：https://blog.csdn.net/qq_31258413/article/details/77834667
版权声明：本文为博主原创文章，转载请附上博文链接！
*/
