//Created  on 2020/1/2 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 *
 */




import UIKit

struct R_FormsTableViewB {
    static func push() {
        let vc = VC_FormsTableViewB()
        vc.vm = VM_FormsTableViewB()
        CD.push(vc)
    }
}
class VM_FormsTableViewB {
}
extension VM_FormsTableViewB: ViewModelTableViewProtocol {
    
}
class VC_FormsTableViewB: TableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print_cd(self.tableView.subviews)
        
        self.tableView.backgroundView = UIView()
        
        print_cd(self.tableView.subviews)
    }

}


