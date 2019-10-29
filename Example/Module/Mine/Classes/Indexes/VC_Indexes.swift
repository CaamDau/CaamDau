//Created  on 2019/10/12 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 *
 */




import UIKit
import CaamDau
import Util

extension VC_Indexes: CD_RouterProtocol {
    static func router(_ param: [AnyHashable : Any]? = nil, callback: (([AnyHashable : Any]?) -> Void)? = nil) {
        let vc = VC_Indexes.cd_storyboard("MineStoryboard", from: "Mine") as! VC_Indexes
        CD.push(vc)
    }
}

class VC_Indexes: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    lazy var headers:[String] = {
        return ["选", "主"] + CD.atoz(true) + ["#"]
    }()
    
    lazy var indexesView: CD_IndexesView = {
        return CD_IndexesView()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.cd.add(indexesView)
        indexesView.snp.makeConstraints {
            $0.right.equalToSuperview().offset(10)
            $0.centerY.equalTo(tableView)
            $0.top.greaterThanOrEqualTo(tableView).offset(20)
        }
        indexesView.items = headers.map{ CD_IndexesView.Item(title:$0, color:Config.color.txt_1)}
        //indexesView.firstIndex = 1
        indexesView.selectHandler = { [weak self](item, idx)in
            let i = self!.headers.index(of: item.title)!
            self?.tableView.scrollToRow(at: IndexPath(row: 0, section: i), at: .top, animated: false)
        }
    }
    
    @IBAction func click(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            indexesView.hudStyle.style = .bubble
            indexesView.hudStyle.alphaMax = 0.3
            indexesView.hudStyle.size = CGSize(w: 60, h: 50)
        case 1:
            indexesView.hudStyle.style = .hud
            indexesView.hudStyle.alphaMax = 0.6
            indexesView.hudStyle.size = CGSize(w: 80, h: 80)
        default:
            break
        }
    }
    
}

extension VC_Indexes: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return headers.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return headers[section]
    }
}
