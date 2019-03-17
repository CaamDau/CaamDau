//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

extension UIView {
    /// 设置背景渐变 默认横向渐变 point -> 0 - 1
    func gradientLayer(_ gradient:[(color:UIColor,location:Float)], point:(start:CGPoint, end:CGPoint) = (CGPoint(x: 0, y: 0),CGPoint(x: 1, y: 0))) {
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = gradient.map{$0.color.cgColor}
        gradientLayer.locations = gradient.map{NSNumber(value:$0.location)}
        
        gradientLayer.startPoint = point.start
        gradientLayer.endPoint = point.end
        
        gradientLayer.frame = self.frame
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
}

class MyViewController : UIViewController {
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white

        let label = UILabel()
        label.frame = CGRect(x: 0, y: 0, width: 200, height: 40)
        label.text = "Hello World!"
        label.textColor = .black
        view.addSubview(label)
        
        let gradientView = UIView(frame: CGRect(x: 0, y: 40, width: 200, height: 60))
        view.addSubview(gradientView)
        
        gradientView.gradientLayer([(UIColor.red, 0.0),
                                    (UIColor.yellow, 0.5),
                                    (UIColor.blue, 1.0)])
        
        self.view = view
    }
}
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
