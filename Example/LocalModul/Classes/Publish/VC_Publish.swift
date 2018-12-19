//Created  on 2018/12/16  by LCD :https://github.com/liucaide .

import UIKit

public extension VC_Publish{
    static func show() -> VC_Publish{
        return VC_Publish.cd_storyboardWithBundle(from:"CD", name:"PublishStoryboard") as! VC_Publish
    }
}

public class VC_Publish: UIViewController {
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.darkGray
    }
}


