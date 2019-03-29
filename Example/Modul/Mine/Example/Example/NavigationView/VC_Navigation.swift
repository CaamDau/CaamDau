//Created  on 2019/3/24 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 *
 */




import UIKit
import CD

class VC_Navigation: UIViewController {

    @IBOutlet weak var topBar: CD_TopBar!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.isNavigationBarHidden = true
        
        //topBar.delegate = self
        /*
        topBar.callBack = { [weak self]idx in
            self?.topBar.super_topBarClick(idx)
            print(idx)
        }*/
        /*
        */
    }
    
    
    
}


