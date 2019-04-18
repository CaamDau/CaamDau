//Created  on 2019/4/13 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 *
 */




import UIKit
extension VC_PageC {
    static func show() -> VC_PageC {
        return VC_PageC.cd_storyboard(withBundle: "Mine", name: "PageStoryboard") as! VC_PageC
    }
}
class VC_PageC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.cd.background(UIColor.orange)
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
