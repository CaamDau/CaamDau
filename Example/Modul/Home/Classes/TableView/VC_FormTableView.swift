//Created  on 2018/12/16  by LCD :https://github.com/liucaide .

import UIKit
import CD

extension VC_FormTableView{
    static func show() -> VC_FormTableView{
        return VC_FormTableView.cd_storyboard(withBundle:"Home", name:"HomeStoryboard") as! VC_FormTableView
    }
    static func push(){
        let vc = VC_FormTableView.show()
        vc.hidesBottomBarWhenPushed = true
        cd_topVC()?.navigationController?.pushViewController(vc, animated: true)
    }
}

class VC_FormTableView: UITableViewController {
    
    lazy var vm:VM_FormTableView = {
        return VM_FormTableView()
    }()
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.cd
            .estimatedAll()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        let num = vm.forms.count
        return num
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.forms[section].count
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let row = vm.forms[indexPath.section][indexPath.row]
        return row.h
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = vm.forms[indexPath.section][indexPath.row]
        let cell = tableView.cd.cell(row.viewClass)
        row.bind(cell!)
        return cell!
    }
}
