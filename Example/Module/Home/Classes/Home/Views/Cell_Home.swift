//Created  on 2018/12/16  by LCD :https://github.com/liucaide .

import UIKit
import CaamDau
import Util

//MARK:--- 标签 ----------
class Cell_HomeTitle: UITableViewCell {
    @IBOutlet weak var lab_title: UILabel!
    @IBOutlet weak var btn_github: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.lab_title.cd
            .text(Config.font.font(14).cd.fit)
            .text(Config.color.txt_1)
        
        self.btn_github.cd
            .text(Config.font.font(14).cd.fit)
    }
    var callBack: CD_RowCallBack?
    @IBAction func buttonClick(_ sender: Any) {
        callBack?("")
    }
    
}
extension Cell_HomeTitle:CD_RowUpdateProtocol{
    typealias DataSource = String
    func row_update(_ data: String, id: String, tag: Int, frame: CGRect, callBack: CD_RowCallBack?) {
        self.lab_title.cd.text(data)
        self.callBack = callBack
    }
    
}



class View_Header: UITableViewHeaderFooterView {
    
}
extension View_Header: CD_RowUpdateProtocol {
    typealias DataSource = String
    func row_update(_ data: String, id: String, tag: Int, frame: CGRect, callBack: CD_RowCallBack?) {
        self.textLabel?.cd
            .text(data)
            .text(Config.color.txt_2)
            .text(Config.font.fontBold(13).cd.fit)
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
