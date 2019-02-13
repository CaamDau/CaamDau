//Created  on 2018/12/16  by LCD :https://github.com/liucaide .

import UIKit
import CD
public extension VC_News{
    static func show() -> VC_News{
        return VC_News.cd_storyboard(withBundle: "News", name:"NewsStoryboard") as! VC_News
    }
    static func push(_ pvc:UIViewController){
        let vc = VC_News.show()
        vc.hidesBottomBarWhenPushed = true
        pvc.navigationController?.pushViewController(vc, animated: true)
    }
}

public class VC_News: UIViewController {
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.gray
    }
}

