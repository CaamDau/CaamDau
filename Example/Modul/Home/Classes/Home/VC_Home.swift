//Created  on 2018/12/16  by LCD :https://github.com/liucaide .

import UIKit
import CD

public extension VC_Home{
    static func show() -> VC_Home{
        //return VC_Home.cd_storyboard(name: "HomeStoryboard") as! VC_Home
        
        return VC_Home.cd_storyboard(withBundle:"Home", name:"HomeStoryboard") as! VC_Home
    }
}

public class VC_Home: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    lazy var vm:VM_Home = {
        return VM_Home()
    }()
    
//    lazy var modelMj:CD_MJRefreshModel = {
//        //var m = CD_MJRefreshModel()
//
//        return m
//    }()
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.cd
            .estimatedAll()
    }
}


extension VC_Home:UITableViewDelegate, UITableViewDataSource{
    public func numberOfSections(in tableView: UITableView) -> Int {
        let num = vm.forms.count
        return num
    }
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.forms[section].count
    }
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let row = vm.forms[indexPath.section][indexPath.row]
        return row.h
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = vm.forms[indexPath.section][indexPath.row]
        let cell = tableView.cd.cell(row.viewClass)
        row.bind(cell!)
        return cell!
    }
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = vm.forms[indexPath.section][indexPath.row]
        row.didSelect?()
    }
    
}
