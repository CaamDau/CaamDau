//Created  on 2018/12/16  by LCD :https://github.com/liucaide .

import UIKit

public extension VC_Find{
    static func show() -> VC_Find{
        return VC_Find.cd_storyboard(from:"CD", name: "FindStoryboard") as? VC_Find ?? VC_Find()
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
            VC_Login.isLogin(self, true)
        case 1:
            VC_News.push(self)
        default:
            break
        }
    }
}
