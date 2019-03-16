//Created  on 2018/12/16  by LCD :https://github.com/liucaide .

import UIKit
import CD



public extension VC_Find{
    static func show() -> VC_Find{
        return VC_Find.cd_storyboard(withBundle:"Find", name: "FindStoryboard") as! VC_Find
    }
}

public class VC_Find: UIViewController {
    public override func viewDidLoad() {
        super.viewDidLoad()
    }
}
