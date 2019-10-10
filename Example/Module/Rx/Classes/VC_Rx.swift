//Created  on 2018/12/16  by LCD :https://github.com/liucaide .

import UIKit
import CaamDau



public extension VC_Rx{
    static func show() -> VC_Rx{
        return VC_Rx.cd_storyboard("RxStoryboard", from: "Rx") as! VC_Rx
    }
}

public class VC_Rx: UIViewController {
    public override func viewDidLoad() {
        super.viewDidLoad()
    }
}
