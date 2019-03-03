//Created  on 2018/12/16  by LCD :https://github.com/liucaide .

import UIKit
import CD

public extension VC_Mine{
    
    static func show() -> VC_Mine{
        return VC_Mine.cd_storyboard(withBundle:"Mine", name:"MineStoryboard") as! VC_Mine
    }
}

public class VC_Mine: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var vm:VM_Mine = VM_Mine()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.reloadData()
    }
}

extension VC_Mine:UITableViewDelegate,UITableViewDataSource {
    public func numberOfSections(in tableView: UITableView) -> Int {
        return vm.form.count
    }
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.form[section].count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = vm.form[indexPath.section][indexPath.row]
        let cell = tableView.cd.cell(row.viewClass)!
        row.bind(cell)
        return cell;
    }
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = vm.form[indexPath.section][indexPath.row]
        row.didSelect?()
    }
}
