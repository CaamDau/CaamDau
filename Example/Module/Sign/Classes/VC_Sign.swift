//Created  on 2018/12/16  by LCD :https://github.com/liucaide .

import UIKit

import CaamDau
import Util
public extension VC_Sign{
    static func show() -> VC_Sign{
        return VC_Sign.cd_storyboard("SignStoryboard", from: "Sign") as! VC_Sign
    }
    
    @discardableResult
    static func isSignUp(_ canBack:Bool = true, _ blockEnd:(()->Void)? = nil) -> Bool {
        
        let vc = VC_Sign.show()
        vc.canBack = canBack
        vc.blockEnd = blockEnd
        let pvc = CD.visibleVC
        pvc?.present(vc, animated: true, completion: nil)
        return false
    }
}

public class VC_Sign: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btn_back: UIButton!
    var canBack:Bool = true
    var blockEnd:(()->Void)?
    var vm:VM_Sign = VM_Sign()
    
    override public func viewDidLoad() {
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
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.form.count
    }
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return vm.form[indexPath.row].h
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = vm.form[indexPath.row]
        let cell = tableView.cd.cell(row.viewClass)!
        row.bind(cell)
        return cell
    }
    
}

