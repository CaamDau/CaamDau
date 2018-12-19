//Created  on 2018/12/16  by LCD :https://github.com/liucaide .

import UIKit

public extension VC_Car{
    static func show() -> VC_Car{
        return VC_Car.cd_storyboardWithBundle(from:"CD", name:"CarStoryboard") as! VC_Car
    }
}
public class VC_Car: UIViewController {

    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.red
    }
}
