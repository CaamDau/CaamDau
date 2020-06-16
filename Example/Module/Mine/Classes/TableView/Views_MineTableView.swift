//Created  on 2019/3/16 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 *
 */


import Foundation
import UIKit
import CaamDau

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
    var openTime = false
    weak var model:VM_MineTableView.Model? {
        didSet{
            if let m = oldValue {
                Time.remove(m.id)
            }
            print_cd("old->",oldValue?.id)
            makeTimer()
        }
    }
    
    func makeTimer() {
        guard let m = self.model, m.timeOpen else {
            return
        }
        print_cd("new->", m.id)
        let end = m.endTime.cd_date("yyyy-MM-dd HH:mm:ss:SSS")!.cd_timestamp()
        let time = end - Date().cd_timestamp()
        Time.make(Time.Style.delegate(self, m.id, time, m.second))
    }
    
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
        model?.timeOpen = true
        makeTimer()
    }
    
    deinit {
        if let m = model {
            Time.remove(m.id)
        }
    }
}

extension Cell_MineCountDown:TimeProtocol{
    func time(withModel model: Time.Model, id:String) {
        if self.model?.id == id {
            makeDown(model)
        }
    }
    func makeDown(_ model:Time.Model) {
        self.lab_day.cd.text(model.day > 0 ? "\(model.day)天" : "")
        self.lab_hour.cd.text(model.hour > 9 ? "\(model.hour)" : "0\(model.hour)")
        self.lab_minute.cd.text(model.minute > 9 ? "\(model.minute)" : "0\(model.minute)")
        self.lab_second.cd.text(model.second > 9 ? "\(model.second)" : "0\(model.second)")
        self.lab_msecond.cd.text(model.millisecond > 0 ? (model.millisecond > 99 ? "\(model.millisecond)" : "0\(model.millisecond)") : "000")
    }
}

extension Cell_MineCountDown:RowCellUpdateProtocol{
    typealias ConfigModel = Any
    typealias DataSource = VM_MineTableView.Model
    
    func row_update(dataSource data: VM_MineTableView.Model) {
        self.img_icon.image = data.img
        self.lab_msecond.isHidden = data.second >= 1
        self.lab_dot.isHidden = data.second >= 1
        
        self.lab_day.cd.text("")
        self.lab_hour.cd.text("00")
        self.lab_minute.cd.text("00")
        self.lab_second.cd.text("00")
        self.lab_msecond.cd.text("000")
        
        self.model = data
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
            .text(IconFont.tadd(18).font)
            .text(IconFont.tadd(18).text)
        
        self.btn_sub.cd
            .text(IconFont.tmove(18).font)
            .text(IconFont.tmove(18).text)
        
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
extension Cell_MineInput: RowCellUpdateProtocol{
    typealias ConfigModel = Any
    
    typealias DataSource = VM_MineTableView.Model
    func row_update(dataSource data: VM_MineTableView.Model) {
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

extension Cell_MineSwitch:RowCellUpdateProtocol{
    typealias ConfigModel = Any
    
    typealias DataSource = VM_MineTableView.Model
    func row_update(dataSource data: VM_MineTableView.Model) {
        self.model = data
    }
    func row_update(_ data: VM_MineTableView.Model, id: String, tag: Int, frame: CGRect, callBack: RowCallBack?) {
        self.model = data
    }
}

//MARK:--- 标签 ----------
class Cell_MineDetail:UITableViewCell{
    @IBOutlet weak var lab_title: UILabel!
    
}

extension Cell_MineDetail:RowCellUpdateProtocol{
    typealias ConfigModel = Any
    
    typealias DataSource = String
    func row_update(dataSource data: String) {
        self.lab_title.cd.text(data)
    }
}



