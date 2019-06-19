//Created  on 2019/3/16 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 *
 */


import Foundation
import UIKit
import CD
import Util

//MARK:--- 标签 ----------
class Cell_MineCountDown:UITableViewCell{
    @IBOutlet weak var img_icon: UIImageView!
    @IBOutlet weak var lab_day: UILabel!
    @IBOutlet weak var lab_hour: UILabel!
    @IBOutlet weak var lab_minute: UILabel!
    @IBOutlet weak var lab_second: UILabel!
    @IBOutlet weak var lab_msecond: UILabel!
    @IBOutlet weak var lab_dot: UILabel!
    
    @IBOutlet weak var view_space_W: NSLayoutConstraint!
    weak var model:VM_MineTableView.Model?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.lab_hour.cd
            .text(Config.font.fontMedium(12))
            .background(Config.color.main_4)
        self.lab_minute.cd
            .text(Config.font.fontMedium(12))
            .background(Config.color.main_4)
        self.lab_second.cd
            .text(Config.font.fontMedium(12))
            .background(Config.color.main_4)
        
        self.view_space_W.constant = Config.fit.fit(10)
    }
    
    @IBAction func countdownClick(_ sender: UIButton) {
        CD_CountDown.make(CD_CountDown.Style.delegate(self, self.model!.id, self.model!.time!, self.model!.second!))
        
    }
}

extension Cell_MineCountDown:CD_CountDownProtocol{
    func cd_countDown(withModel model: CD_CountDown.Model, id:String) {
        if self.model?.id == id {
            makeDown(model)
        }
    }
    func makeDown(_ model:CD_CountDown.Model) {
        self.lab_day.cd.text(model.day > 0 ? "\(model.day)天" : "")
        self.lab_hour.cd.text(model.hour > 9 ? "\(model.hour)" : "0\(model.hour)")
        self.lab_minute.cd.text(model.minute > 9 ? "\(model.minute)" : "0\(model.minute)")
        self.lab_second.cd.text(model.second > 9 ? "\(model.second)" : "0\(model.second)")
        self.lab_msecond.cd.text(model.millisecond > 0 ? (model.millisecond > 99 ? "\(model.millisecond)" : "0\(model.millisecond)") : "000")
        
        self.model?.time = model.remainTime
        self.model?.down = model
    }
}

extension Cell_MineCountDown:CD_RowUpdateProtocol{
    typealias DataSource = VM_MineTableView.Model
    func row_update(_ data: VM_MineTableView.Model, id: String, tag: Int, frame: CGRect, callBack: CD_RowCallBack?) {
        self.model = data
        self.img_icon.image = data.img
        self.lab_msecond.isHidden = data.second >= 1
        self.lab_dot.isHidden = data.second >= 1
        if let down = data.down {
            makeDown(down)
        }else{
            self.lab_day.cd.text("")
            self.lab_hour.cd.text("00")
            self.lab_minute.cd.text("00")
            self.lab_second.cd.text("00")
            self.lab_msecond.cd.text("000")
        }
    }
}


//MARK:--- 输入 ----------
class Cell_MineInput:UITableViewCell{
    @IBOutlet weak var lab_title: UILabel!
    @IBOutlet weak var btn_sub: UIButton!
    @IBOutlet weak var btn_add: UIButton!
    @IBOutlet weak var text_field: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.btn_add.cd
            .text(CD_IconFont.tadd(18).font)
            .text(CD_IconFont.tadd(18).text)
        
        self.btn_sub.cd
            .text(CD_IconFont.tmove(18).font)
            .text(CD_IconFont.tmove(18).text)
        
        self.text_field.cd.delegate(self)
    }
    
    weak var model:VM_MineTableView.Model? {
        didSet{
            num = model!.num
        }
    }
    var num:Int? {
        didSet{
            self.model?.num = num!
            self.lab_title.cd.text(model!.num.stringValue)
            self.text_field.cd.text(model!.num.stringValue)
        }
    }
    
    
    @IBAction func textChange(_ sender: UITextField) {
        num = text_field.text!.intValue
    }
    @IBAction func textEnd(_ sender: UITextField) {
        num = text_field.text!.intValue
    }
    
    @IBAction func subClick(_ sender: UIButton) {
        num = text_field.text!.intValue - 1
    }
    
    @IBAction func addClick(_ sender: UIButton) {
        num = text_field.text!.intValue + 1
    }
}
extension Cell_MineInput: UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        switch string {
        case "0","1","2","3","4","5","6","7","8","9","":
            return true
        default:
            return false
        }
    }
}
extension Cell_MineInput: CD_RowUpdateProtocol{
    typealias DataSource = VM_MineTableView.Model
    func row_update(_ data: VM_MineTableView.Model, id: String, tag: Int, frame: CGRect, callBack: CD_RowCallBack?) {
        self.model = data
    }
}


//MARK:--- 开关 ----------
class Cell_MineSwitch:UITableViewCell{
    @IBOutlet weak var lab_title: UILabel!
    @IBOutlet weak var swit: UISwitch!
    
    weak var model:VM_MineTableView.Model? {
        didSet{
            open = model!.open
        }
    }
    
    var open:Bool? {
        didSet{
            self.swit.isOn = open!
            self.lab_title.text = open! ? "开" : "关"
        }
    }
    
    @IBAction func switchChange(_ sender: UISwitch) {
        self.model?.open = sender.isOn
        open = sender.isOn
    }
}

extension Cell_MineSwitch:CD_RowUpdateProtocol{
    typealias DataSource = VM_MineTableView.Model
    func row_update(_ data: VM_MineTableView.Model, id: String, tag: Int, frame: CGRect, callBack: CD_RowCallBack?) {
        self.model = data
    }
}

//MARK:--- 标签 ----------
class Cell_MineDetail:UITableViewCell{
    @IBOutlet weak var lab_title: UILabel!
    
}

extension Cell_MineDetail:CD_RowUpdateProtocol{
    typealias DataSource = String
    func row_update(_ data: String, id: String, tag: Int, frame: CGRect, callBack: CD_RowCallBack?) {
        self.lab_title.cd.text(data)
    }
}



