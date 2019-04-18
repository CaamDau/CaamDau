//Created  on 2019/4/13 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 *
 */




import UIKit
extension VC_PageD {
    static func show() -> VC_PageD {
        return VC_PageD.cd_storyboard(withBundle: "Mine", name: "PageStoryboard") as! VC_PageD
    }
}

class VC_PageD: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.cd.background(UIColor.gray)
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
