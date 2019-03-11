//Created  on 2018/12/16  by LCD :https://github.com/liucaide .

import UIKit
import CD
import M_Sign
import Config

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

extension Cell_SignInput:CD_RowUpdateProtocol{
    typealias DataSource = (Style, M_Sign)
    func row_update(_ data: (Style, M_Sign), id: String, tag: Int, frame: CGRect, callBack: CD_RowCallBack?) {
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
extension Cell_SignOption:CD_RowUpdateProtocol{
    typealias DataSource = Any
    func row_update(_ data: Any, id: String, tag: Int, frame: CGRect, callBack: CD_RowCallBack?) {
        
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
extension Cell_SignSubmit:CD_RowUpdateProtocol{
    typealias DataSource = M_Sign
    func row_update(_ data: M_Sign, id: String, tag: Int, frame: CGRect, callBack: CD_RowCallBack?) {
        self.btn_submit.cd
            .background(Config.color.btnBgEnabledNo)
        
        data.blockSubmitEnabled = { [unowned self] b in
            self.btn_submit.cd
                .background(b ? Config.color.btnBgEnabledYes : Config.color.btnBgEnabledNo)
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
        btn_agree.cd.text(Config.color.btnBgNormal)
    }
    @IBAction func agreeClick(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        self.signModel?.isAgreement = sender.isSelected
        if sender.isSelected {
            btn_agree.cd
                .text(CD_IconFont.tround_check_fill(20).font)
                .text(CD_IconFont.tround_check_fill(20).text)
                .text(Config.color.btnBgNormal)
        }else{
            btn_agree.cd
                .text(CD_IconFont.tround(20).font)
                .text(CD_IconFont.tround(20).text)
                .text(Config.color.btnBgNormal)
            
        }
    }
}
extension Cell_SignAgreement:CD_RowUpdateProtocol{
    typealias DataSource = M_Sign
    func row_update(_ data: M_Sign, id: String, tag: Int, frame: CGRect, callBack: CD_RowCallBack?) {
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
extension Cell_SignOther:CD_RowUpdateProtocol{
    typealias DataSource = Any
    func row_update(_ data: Any, id: String, tag: Int, frame: CGRect, callBack: CD_RowCallBack?) {
        
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
            .text(Config.color.btnBgNormal)
        self.btn_2.cd
            .text(CD_IconFont.temoji(45).font)
            .text(CD_IconFont.temoji(45).text)
            .text(Config.color.btnBgNormal)
        self.btn_3.cd
            .text(CD_IconFont.tinfo_fill(45).font)
            .text(CD_IconFont.tinfo_fill(45).text)
            .text(Config.color.btnBgNormal)
    }
}
extension Cell_SignOtherBtn:CD_RowUpdateProtocol{
    typealias DataSource = Any
    func row_update(_ data: Any, id: String, tag: Int, frame: CGRect, callBack: CD_RowCallBack?) {
        
    }
}
//MARK:--- 留白 ----------
class Cell_SignLine: UITableViewCell {
    
}
extension Cell_SignLine:CD_RowUpdateProtocol{
    typealias DataSource = Any
    func row_update(_ data: Any, id: String, tag: Int, frame: CGRect, callBack: CD_RowCallBack?) {
        
    }
}
