//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

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
extension UIView {
    /// 设置背景线性渐变 默认横向渐变 point -> 0 - 1
    func gradient(layerAxial gradients:[(color:UIColor,location:Float)], point:(start:CGPoint, end:CGPoint) = (start:CGPoint(x: 0, y: 0), end:CGPoint(x: 1, y: 0)), at: UInt32 = 0, updateIndex:Int? = nil) {
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
        }else{
            gradient(layers[updateIndex ?? 0])
        }
    }
    
    func gradient(layerRadial gradients:[(color:UIColor,location:CGFloat)], point:CGPoint = CGPoint(x: 0, y: 0), radius:CGFloat? = nil, at: UInt32 = 0, updateIndex:Int? = nil) {
        
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
        }else{
            gradient(layers[updateIndex ?? 0])
        }
    }
}


class MyViewController : UIViewController {
    override func loadView() {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 320, height: 568))
        view.backgroundColor = .white
        do{
            let vv = UIView(frame: CGRect(x: 0, y: 40, width: 200, height: 60))
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
            let vvv = UIView(frame: CGRect(x: 100, y: 200, width: 200, height: 60))
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
            let str = "国"
            let lab = UILabel(frame: CGRect(x: 20, y: 300, width: 100, height: 30))
            lab.text = str
            view.addSubview(lab)
            let str64 = str.data(using: String.Encoding.utf8, allowLossyConversion: true)?.base64EncodedString() ?? ""
            
            let data = Data(base64Encoded: str64)
            let img = UIImage(data: data ?? Data())
            let imageView = UIImageView(frame: CGRect(x: 20, y: 350, width: 100, height: 30))
            imageView.backgroundColor = UIColor.red
            imageView.image = img
            view.addSubview(imageView)
        }
        
        self.view = view
    }
}
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
