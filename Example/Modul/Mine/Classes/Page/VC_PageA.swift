//Created  on 2019/4/13 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 *
 */




import UIKit
import CD
import Assets

extension VC_PageA {
    static func show() -> VC_PageA {
        return VC_PageA.cd_storyboard(withBundle: "Mine", name: "PageStoryboard") as! VC_PageA
    }
}
class VC_PageA: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.cd.background(UIColor.red)
        
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
    
    
    
    lazy var assets: Assets = {
        return Assets()
    }()
}


extension VC_PageA: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell")
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "UITableViewCell")
        }
        cell?.textLabel?.text = "\(indexPath.row)"
        cell?.imageView?.image = assets.logo_60
        return cell!
    }
//    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
//        
//        if velocity.y > 1.0 {
//            self.tapBar.hidden(navigationBar: true)
//        }else if velocity.y < -1.0 {
//            self.tapBar.hidden(navigationBar: false)
//        }
//    }
    
    
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        guard let supVC = cd_visibleVC() as? VC_Page else {
            return
        }
        if velocity.y > 1.0 {
            supVC.hidden(navigationBar: true)
        }else if velocity.y < -1.0 {
            supVC.hidden(navigationBar: false)
        }
        
    }
}

extension VC_PageA: CD_UIViewControllerProtocol {
    static func row_init(withDataSource dataSource: Any?, config: Any?, callBack: CD_RowCallBack?, tapBlock: CD_RowDidSelectBlock?) -> UIViewController {
        let vc = VC_PageA.show()
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

