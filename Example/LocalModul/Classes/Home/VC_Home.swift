//Created  on 2018/12/16  by LCD :https://github.com/liucaide .

import UIKit

public extension VC_Home{
    static func show() -> VC_Home{
        //return VC_Home.cd_storyboard(name: "HomeStoryboard") as! VC_Home
        
        return VC_Home.cd_storyboardWithBundle(from:"CD", name:"HomeStoryboard") as! VC_Home
    }
}

public class VC_Home: UIViewController {
    override public func viewDidLoad() {
        super.viewDidLoad()

    }
}
