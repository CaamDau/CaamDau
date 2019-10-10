//Created  on 2018/12/16  by LCD :https://github.com/liucaide .

import UIKit
import CaamDau
public extension VC_Demo{
    static func show() -> VC_Demo{
        return VC_Demo.cd_storyboard("DemoStoryboard", from: "Demo") as! VC_Demo
    }
    static func push(_ pvc:UIViewController){
        let vc = VC_Demo.show()
        vc.hidesBottomBarWhenPushed = true
        pvc.navigationController?.pushViewController(vc, animated: true)
    }
}

public class VC_Demo: UITableViewController {
    public override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}

