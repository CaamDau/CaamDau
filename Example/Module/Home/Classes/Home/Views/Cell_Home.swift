//Created  on 2018/12/16  by LCD :https://github.com/liucaide .

import UIKit

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
    var callBack: RowCallBack?
    @IBAction func buttonClick(_ sender: Any) {
        callBack?("")
    }
    
}
extension Cell_HomeTitle:RowCellUpdateProtocol{
    typealias ConfigModel = Any
    typealias DataSource = String
    func row_update(dataSource data: String) {
        self.lab_title.cd.text(data)
        
    }
    func row_update(callBack block: RowCallBack?) {
        self.callBack = block
    }
    
    
}



class View_Header: UITableViewHeaderFooterView {
    
}
extension View_Header: RowCellUpdateProtocol {
    typealias ConfigModel = Any
    
    typealias DataSource = String
    func row_update(dataSource data: String) {
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
extension Cell_HomeSwitch:RowCellUpdateProtocol{
    
    
    typealias DataSource = (String,Bool)
    typealias ConfigModel = Any
    func row_update(dataSource data: DataSource) {
        self.textLabel?.text = data.0
        self.switch.isOn = data.1
        self.imageView?.image = Assets().logo_launch
    }
}
