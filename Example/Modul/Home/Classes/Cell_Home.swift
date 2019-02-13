//Created  on 2018/12/16  by LCD :https://github.com/liucaide .

import UIKit
import CD
import Assets
//MARK:--- 标签 ----------
class Cell_HomeTitle: UITableViewCell {
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
extension Cell_HomeTitle:CD_RowUpdateProtocol{
    typealias DataSource = String
    func row_update(_ data: String, id: String, tag: Int, frame: CGRect, callBack: CD_RowCallBack?) {
        self.textLabel?.text = data
    }
    
}
//MARK:--- 开关 ----------
class Cell_HomeSwitch: UITableViewCell {
    @IBOutlet weak var `switch`: UISwitch!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
extension Cell_HomeSwitch:CD_RowUpdateProtocol{
    typealias DataSource = (String,Bool)
    func row_update(_ data: (String,Bool), id: String, tag: Int, frame: CGRect, callBack: CD_RowCallBack?) {
        self.textLabel?.text = data.0
        self.switch.isOn = data.1
        self.imageView?.image = Assets().logo_launch
    }
}
