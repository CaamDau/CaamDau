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
            .text(CD_Logo.t微信(40).font)
            .text(CD_Logo.t微信(40).text)
        self.btn_2.cd
            .text(CD_Logo.tweibo_circle_fill(45).font)
            .text(CD_Logo.tweibo_circle_fill(45).text)
        self.btn_3.cd
            .text(CD_Logo.ttaobao_circle_fill(45).font)
            .text(CD_Logo.ttaobao_circle_fill(45).text)
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
