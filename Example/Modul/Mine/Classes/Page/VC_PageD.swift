//Created  on 2019/4/13 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 *
 */




import UIKit
import CD
extension VC_PageD {
    static func show() -> VC_PageD {
        return VC_PageD.cd_storyboard(withBundle: "Mine", name: "PageStoryboard") as! VC_PageD
    }
}

class VC_PageD: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.cd.background(UIColor.gray)
        
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

extension VC_PageD: CD_UIViewControllerProtocol {
    var scale: CGFloat {
        get {
            return 0
        }
        set {
            
        }
    }
    
    static func initialize(withDataSource dataSource: Any?, config: Any?) -> UIViewController {
        let vc = VC_PageD()
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

