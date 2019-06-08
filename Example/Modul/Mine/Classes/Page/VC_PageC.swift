//Created  on 2019/4/13 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 *
 */




import UIKit
import CD
extension VC_PageC {
    static func show() -> VC_PageC {
        return VC_PageC.cd_storyboard(withBundle: "Mine", name: "PageStoryboard") as! VC_PageC
    }
}
class VC_PageC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.cd.background(UIColor.orange)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }


}

extension VC_PageC: CD_UIViewControllerProtocol {
    static func row_init(withDataSource dataSource: Any?, config: Any?, callBack: CD_RowCallBack?, tapBlock: CD_RowDidSelectBlock?) -> UIViewController {
        let vc = VC_PageC()
        vc.dataSource = dataSource
        vc.config = config
        return vc
    }
    
    
    
    
    typealias DataSource = Any
    typealias ConfigModel = Any
    var config: ConfigModel? {
        get { return nil }
        set {}
    }
    var dataSource: DataSource? {
        get { return nil }
        set {}
    }
}

