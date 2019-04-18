//Created  on 2019/4/13 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 *
 */




import UIKit
import CD

extension VC_PageA {
    static func show() -> VC_PageA {
        return VC_PageA.cd_storyboard(withBundle: "Mine", name: "PageStoryboard") as! VC_PageA
    }
}
class VC_PageA: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.cd.background(UIColor.red)
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
    
    lazy var supVC:VC_Page? = {
        return cd_visibleVC() as? VC_Page ?? nil
    }()
}


extension VC_PageA: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell")
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "UITableViewCell")
        }
        cell?.textLabel?.text = "\(indexPath.row)"
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
        if velocity.y > 1.0 {
            supVC?.hidden(navigationBar: true)
        }else if velocity.y < -1.0 {
            supVC?.hidden(navigationBar: false)
        }
        
    }
}
