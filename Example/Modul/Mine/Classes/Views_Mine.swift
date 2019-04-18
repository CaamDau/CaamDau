//Created  on 2019/2/27 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 *
 */




import Foundation
import CD
import Config
//MARK:--- 登录 ----------
class Cell_MineSign:UITableViewCell{
    @IBOutlet weak var lab_title: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        lab_title.cd
            .text(Config.font.fontMedium(15).fit())
            .text(Config.color.main_1)
    }
}
extension Cell_MineSign:CD_RowUpdateProtocol{
    typealias DataSource = String
    func row_update(_ data: String, id: String, tag: Int, frame: CGRect, callBack: CD_RowCallBack?) {
        lab_title.cd.text(data)
    }
}

//MARK:--- 标签 ----------
class Cell_MineTitle:UITableViewCell{
    override func awakeFromNib() {
        super.awakeFromNib()
        textLabel?.cd
            .text(Config.font.fontRegular(15).fit())
            .text(Config.color.txt_1)
        
        detailTextLabel?.cd
            .text(Config.font.fontRegular(12).fit())
            .text(Config.color.txt_3)
    }
}
extension Cell_MineTitle:CD_RowUpdateProtocol{
    typealias DataSource = (String,String)
    func row_update(_ data: (String,String), id: String, tag: Int, frame: CGRect, callBack: CD_RowCallBack?) {
        self.textLabel?.cd.text(data.0)
        self.detailTextLabel?.cd.text(data.1)
    }
}


//MARK:--- Form ----------
class Cell_MineForm: UITableViewCell {
    @IBOutlet weak var lab_title: UILabel!
    @IBOutlet weak var btn_github: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.lab_title.cd
            .text(Config.font.fontRegular(15).fit())
            .text(Config.color.txt_1)
        
        self.btn_github.cd
            .text(Config.font.fontRegular(15).fit())
            .background(Config.color.main_3)
    }
    var callBack: CD_RowCallBack?
    @IBAction func buttonClick(_ sender: Any) {
        callBack?("")
    }
    
}
extension Cell_MineForm:CD_RowUpdateProtocol{
    typealias DataSource = String
    func row_update(_ data: String, id: String, tag: Int, frame: CGRect, callBack: CD_RowCallBack?) {
        self.lab_title.cd.text(data)
        self.callBack = callBack
    }
    
}


//MARK:--- 分割线 ----------
class Cell_MineLine:UITableViewCell{
    enum Style {
        case bgF0
        case bgFF
        case bgDD
        
        var colorValue:UIColor {
            switch self {
            case .bgF0:
                return UIColor.cd_hex("#f0")
            case .bgFF:
                return UIColor.cd_hex("#f")
            case .bgDD:
                return UIColor.cd_hex("#d")
            }
        }
    }
}
extension Cell_MineLine:CD_RowUpdateProtocol{
    typealias DataSource = Cell_MineLine.Style
    func row_update(_ data: Cell_MineLine.Style, id: String, tag: Int, frame: CGRect, callBack: CD_RowCallBack?) {
        self.contentView.cd.background(data.colorValue)
    }
}
