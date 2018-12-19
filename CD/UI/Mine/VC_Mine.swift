//Created  on 2018/12/16  by LCD :https://github.com/liucaide .

import UIKit

public extension VC_Mine{
    static func show() -> VC_Mine{
        return VC_Mine.cd_storyboardWithBundle(from:"CD", name:"MineStoryboard") as! VC_Mine
    }
}

public class VC_Mine: UIViewController {
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.orange
    }
}
