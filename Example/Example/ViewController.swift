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
            CD_PencilDraw.show(UIImage(named: "launchScreen")!)
        } else {
            
        }
    }
    
}

