//Created  on 2019/3/16 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 *
 */




import UIKit
import CaamDau
//import RxSwift
//import RxCocoa

extension VC_MineTableView {
    static func show() -> VC_MineTableView {
        return VC_MineTableView.cd_storyboard( "MineStoryboard", from: "Mine") as! VC_MineTableView
    }
    static func push() {
        let vc = VC_MineTableView.show()
        CD.push(vc)
    }
}

class VC_MineTableView: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tabbar: TopBar!
    var vm:VM_MineTableView = VM_MineTableView()
    var delegateData:TableViewDelegateDataSource?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.cd.navigationBar(hidden: true)
        
        delegateData = TableViewDelegateDataSource(vm)
        self.tableView.cd
            .background(Config.color.bg)
            .estimatedAll(5)
            .delegate(delegateData)
            .dataSource(delegateData)
        delegateData?.makeReloadData(tableView)
            
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(tabbar.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            //$0.bottom.equalToSuperview()
            if #available(iOS 11.0, *) {
                $0.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
            } else {
                
                $0.bottom.equalTo(bottomLayoutGuide.snp.bottom)
            }
        }
        
        makeCounDown()
    }
    var obs:NSObjectProtocol?
    func makeCounDown(){
        /// 输出
        obs = CD.notice.addObserver(forName: Notification.Name(rawValue: "VC_MineTableView"), object: nil, queue: nil, using: { [weak self](n) in
            if let model = n.userInfo?["VC_MineTableView"] as? Time.Model {
                self?.tabbar._title = "\(model.day)天\(model.hour):\(model.minute):\(model.second)"
            }
        })
        /// 输入
        Time.make(.notification("VC_MineTableView", 172800, 1), qos: .background)
        
    }
    
    deinit {
        //如果不需要保持 可以移除
        //Timer.remove("VC_MineTableView")
    }
}


class Da: TableViewDelegateDataSource {
    
}
