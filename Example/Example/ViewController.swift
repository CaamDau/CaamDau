//Created  on 2019/3/12 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 *
 */




import UIKit
import CaamDau
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func buttonClick(_ sender: Any) {
        if #available(iOS 13.0, *) {
            PencilDraw.show(UIImage(named: "launchScreen")!)
        } else {
            
        }
        
        
        
    }
    
}


class R_VVC1: RouterInterface {
    static func router(_ param: RouterParameter, callback: RouterCallback) {
        
    }
    
    func router(_ param: RouterParameter, callback: RouterCallback) {
        
    }
    
}


class R_VVC2: NSObject, RouterInterface {
    static func router(_ param: RouterParameter, callback: RouterCallback) {
        
    }
    
    func router(_ param: RouterParameter, callback: RouterCallback) {
        
    }
    
    var ob:Any?
    func notice() {
        ob = NotificationCenter.default.addObserver(forName: NSNotification.Name(self.description), object: nil, queue: .main, using: { (n) in
            
        })
    }
}
