//Created  on 2019/4/13 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 *
 */




import UIKit
extension VC_PageB {
    static func show() -> VC_PageB {
        return VC_PageB.cd_storyboard(withBundle: "Mine", name: "PageStoryboard") as! VC_PageB
    }
}
class VC_PageB: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.cd.background(UIColor.yellow)
        print(self,"---> viewDidLoad")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(self,"---> viewWillAppear")
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print(self,"---> viewDidAppear")
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print(self,"---> viewWillDisappear")
    }


}
