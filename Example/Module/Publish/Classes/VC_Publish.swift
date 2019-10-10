//Created  on 2018/12/16  by LCD :https://github.com/liucaide .

import UIKit
import CaamDau
public extension VC_Publish{
    static func show() -> VC_Publish{
        return VC_Publish.cd_storyboard("PublishStoryboard", from: "Publish") as! VC_Publish
    }
}

public class VC_Publish: UIViewController {
    public override func viewDidLoad() {
        super.viewDidLoad()
    }
}


