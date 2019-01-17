//Created  on 2018/12/16  by LCD :https://github.com/liucaide .

import UIKit
import CD



public extension VC_Find{
    static func show() -> VC_Find{
        return VC_Find.cd_storyboardWithBundle(from:"Find", name: "FindStoryboard") as! VC_Find
    }
}

public class VC_Find: UIViewController {
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.blue
    }
    
    
    @IBAction func clickButton(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            break
            //VC_Login.isLogin(self, true)
        case 1:
            break
            //VC_News.push(self)
        default:
            break
        }
    }
}
