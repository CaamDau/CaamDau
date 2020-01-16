//Created  on 2018/12/16  by LCD :https://github.com/liucaide .

import UIKit

import CaamDau

public struct R_Sign: CD_RowVCProtocol {
    public var vc: UIViewController {
        return VC_Sign.cd_storyboard("SignStoryboard", from: "Sign") as! VC_Sign
    }
    
    @discardableResult
    public static func isSignUp(_ canBack:Bool = true, _ blockEnd:(()->Void)? = nil) -> Bool {
        let vc = R_Sign().vc as! VC_Sign
        vc.canBack = canBack
        vc.blockEnd = blockEnd
        let pvc = CD.visibleVC
        pvc?.present(vc, animated: true, completion: nil)
        return false
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
        let cell = tableView.cd.cell(row.viewClass)!
        row.bind(cell)
        return cell
    }
    
}


