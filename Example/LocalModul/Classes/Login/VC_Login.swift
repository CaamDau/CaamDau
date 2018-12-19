//Created  on 2018/12/16  by LCD :https://github.com/liucaide .

import UIKit



public extension VC_Login{
    static func show() -> VC_Login{
        return VC_Login.cd_storyboardWithBundle(from:"CD", name:"LoginStoryboard") as! VC_Login
    }
    
    @discardableResult static func isLogin(_ pvc:UIViewController,_ canPop:Bool, _ blockLoginEnd:(()->Void)? = nil) -> Bool {
        
        let vc = VC_Login.show()
        vc.canPop = canPop
        vc.blockLoginEnd = blockLoginEnd
        pvc.present(vc, animated: true, completion: nil)
        return false
        
    }
}
public class VC_Login: UIViewController {

    
    @IBOutlet weak var btn_back: UIButton!
    var canPop:Bool = true
    var blockLoginEnd:(()->Void)?
    override public func viewDidLoad() {
        super.viewDidLoad()

        btn_back.isHidden = !canPop
    }
    
    @IBAction func clickButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
