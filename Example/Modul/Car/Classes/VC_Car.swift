//Created  on 2018/12/16  by LCD :https://github.com/liucaide .

import UIKit
import CD

public extension VC_Car{
    static func show() -> VC_Car{
        return VC_Car.cd_storyboardWithBundle(from:"Car", name:"CarStoryboard") as! VC_Car
    }
}

public class VC_Car: UIViewController {

    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.red
    }
}
