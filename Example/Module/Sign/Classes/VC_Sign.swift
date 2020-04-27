//Created  on 2018/12/16  by LCD :https://github.com/liucaide .

import UIKit

import CaamDau

extension VC_Sign: CD_RouterInterface {
    static func router(_ param: CD_RouterParameter, callback: CD_RouterCallback) {
        let enumm = param.stringValue("router_path")
        switch enumm {
        case "up":
            let vc = VC_Sign.cd_storyboard("SignStoryboard", from: "Sign") as! VC_Sign
            vc.canBack = param.boolValue("canBack")
            vc.blockEnd = {
                callback?([:])
            }
            vc.modalPresentationStyle = .fullScreen
            CD.visibleVC?.present(vc, animated: true, completion: nil)
        case "out":
            User.notice.signOut.post()
        default:
            break
        }
    }
}


class VC_Sign: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btn_back: UIButton!
    var canBack:Bool = true
    var blockEnd:(()->Void)?
    var vm:VM_Sign = VM_Sign()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        btn_back.isHidden = !canBack
        
        self.tableView.reloadData()
        
        self.btn_back.cd
            .text(CD_IconFont.tclose(30).font)
            .text(CD_IconFont.tclose(30).text)
            .text(UIColor.cd_hex("3"))
            .background(UIColor.cd_hex("f"))
    }
    
    @IBAction func clickButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension VC_Sign:UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.form.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return vm.form[indexPath.row].h
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = vm.form[indexPath.row]
        let cell = tableView.cd.cell(row.cellClass)!
        row.bind(cell)
        return cell
    }
    
}


