//Created  on 2018/12/16  by LCD :https://github.com/liucaide .

import UIKit
import CD
import Assets
import SnapKit

public extension VC_Mine{
    
    static func show() -> VC_Mine{
        return VC_Mine.cd_storyboard(withBundle:"Mine", name:"MineStoryboard") as! VC_Mine
    }
}

public class VC_Mine: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var vm:VM_Mine = VM_Mine()
    
    lazy var modelMj:CD_MJRefreshModel = {
        var m = CD_MJRefreshModel()
        let ass = Assets()
        let arr = [ass.refresh_0,
                   ass.refresh_1,
                   ass.refresh_2,
                   ass.refresh_3,
                   ass.refresh_4,
                   ass.refresh_5,
                   ass.refresh_6,
                   ass.refresh_7]
        m.down_imgIdle = arr
        m.down_imgPulling = arr
        m.down_imgWillRefresh = arr
        m.down_imgRefreshing = arr
        return m
    }()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.cd
            .estimatedAll()
            .headerMJGifWithModel({ [weak self] in
                CD_CountDown.after(3, {[weak self] in
                    self?.tableView.cd.endRefreshing()
                    self?.tableView.reloadData()
                })
            }, model: modelMj)
            .beginRefreshing()
    }
}

extension VC_Mine:UITableViewDelegate,UITableViewDataSource {
    public func numberOfSections(in tableView: UITableView) -> Int {
        return vm.forms.count
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
        tableView.deselectRow(at: indexPath, animated: true)
        let row = vm.forms[indexPath.section][indexPath.row]
        row.didSelect?()
    }
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.001
    }
    public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
}
