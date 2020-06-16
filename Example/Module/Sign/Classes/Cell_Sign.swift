//Created  on 2018/12/16  by LCD :https://github.com/liucaide .

import UIKit

import CaamDau


//MARK:--- 输入 ----------
class Cell_SignInput: UITableViewCell {
    
    enum Style {
        case account(_ title:String, _ placeholder:String)
        case pwd(_ title:String, _ placeholder:String)
        case code(_ title:String, _ placeholder:String)
    }
    @IBOutlet weak var lab_title: UILabel!
    @IBOutlet weak var text_input: UITextField!
    var style:Style?
    var signModel:M_Sign?
    
    @IBAction func textChange(_ sender: UITextField) {
        switch style {
        case .account?:
            self.signModel?.account = sender.text ?? ""
        case .pwd?:
            self.signModel?.password = sender.text ?? ""
        default:
            break
        }
    }
    
}

extension Cell_SignInput:CD_RowCellUpdateProtocol{
    typealias DataSource = (Style, M_Sign)
    typealias ConfigModel = Any
    func row_update(dataSource data: DataSource) {
        switch data.0 {
        case .account(let title, let placeholder),
             .pwd(let title, let placeholder),
             .code(let title, let placeholder):
            self.lab_title.cd.text(title)
            self.text_input.cd.placeholder(placeholder)
        }
        self.style = data.0
        self.signModel = data.1
        
    }
}


//MARK:--- 注册。。。选择 ----------
class Cell_SignOption: UITableViewCell {
    
}
extension Cell_SignOption:CD_RowCellUpdateProtocol{
    typealias DataSource = Any
    typealias ConfigModel = Any
    func row_update(dataSource data: DataSource) {
        
    }
}
//MARK:--- 提交 ----------
class Cell_SignSubmit: UITableViewCell {
    
    @IBOutlet weak var btn_submit: UIButton!
    var signModel:M_Sign?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}
extension Cell_SignSubmit:CD_RowCellUpdateProtocol{
    typealias DataSource = M_Sign
    typealias ConfigModel = Any
    func row_update(dataSource data: DataSource) {
        self.btn_submit.cd
            .background(Config.color.enabledFalse)
        
        data.blockSubmitEnabled = { [unowned self] b in
            self.btn_submit.cd
                .background(b ? Config.color.enabledTrue : Config.color.enabledFalse)
                .isUser(b)
        }
    }
}
//MARK:--- 用户协议 ----------
class Cell_SignAgreement: UITableViewCell {
    
    @IBOutlet weak var btn_agree: UIButton!
    var signModel:M_Sign?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        btn_agree.cd.text(Config.color.normal)
    }
    @IBAction func agreeClick(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        self.signModel?.isAgreement = sender.isSelected
        if sender.isSelected {
            btn_agree.cd
                .text(CD_IconFont.tround_check_fill(20).font)
                .text(CD_IconFont.tround_check_fill(20).text)
                .text(Config.color.normal)
        }else{
            btn_agree.cd
                .text(CD_IconFont.tround(20).font)
                .text(CD_IconFont.tround(20).text)
                .text(Config.color.normal)
            
        }
    }
}
extension Cell_SignAgreement:CD_RowCellUpdateProtocol{
    typealias DataSource = M_Sign
    typealias ConfigModel = Any
    func row_update(dataSource data: DataSource) {
        self.signModel = data
        if data.isAgreement {
            btn_agree.cd
                .text(CD_IconFont.tround_check_fill(20).font)
                .text(CD_IconFont.tround_check_fill(20).text)
        }else{
            btn_agree.cd
                .text(CD_IconFont.tround(20).font)
                .text(CD_IconFont.tround(20).text)
            
        }
        btn_agree.isSelected = data.isAgreement
    }
}
//MARK:--- 其他登录 ----------
class Cell_SignOther: UITableViewCell {
    
}
extension Cell_SignOther:CD_RowCellUpdateProtocol{
    typealias DataSource = Any
    typealias ConfigModel = Any
    func row_update(dataSource data: DataSource) {
        
    }
}
//MARK:--- 其他登录 ----------
class Cell_SignOtherBtn: UITableViewCell {
    
    @IBOutlet weak var btn_1: UIButton!
    @IBOutlet weak var btn_2: UIButton!
    @IBOutlet weak var btn_3: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.btn_1.cd
            .text(CD_IconFont.twarn_fill(45).font)
            .text(CD_IconFont.twarn_fill(45).text)
            .text(Config.color.normal)
        self.btn_2.cd
            .text(CD_IconFont.temoji(45).font)
            .text(CD_IconFont.temoji(45).text)
            .text(Config.color.normal)
        self.btn_3.cd
            .text(CD_IconFont.tinfo_fill(45).font)
            .text(CD_IconFont.tinfo_fill(45).text)
            .text(Config.color.normal)
    }
}
extension Cell_SignOtherBtn:CD_RowCellUpdateProtocol{
    typealias DataSource = Any
    typealias ConfigModel = Any
    func row_update(dataSource data: DataSource) {
        
    }
}
//MARK:--- 留白 ----------
class Cell_SignLine: UITableViewCell {
    
}
extension Cell_SignLine:CD_RowCellUpdateProtocol{
    
    
    typealias DataSource = Any
    typealias ConfigModel = Any
    func row_update(dataSource data: DataSource) {
        
    }
    
}
