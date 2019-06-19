//Created  on 2019/2/27 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 *
 */




import Foundation
import CD
import Sign
import Web
import Util

//MARK:--- 分组 ----------
extension VM_Mine {
    enum Section:Int {
        case form = 0
        case other
        //case hud
        case me
        case num
        case end
        
        var headerTitle:String {
            switch self {
            case .form:
                return "CD_Form"
            default:
                return ""
            }
        }
        var headerColor:UIColor {
            switch self {
            case .form:
                return Config.color.bg
            default:
                return Config.color.bg
            }
        }
    }
}


struct VM_Mine {
    
    lazy var forms:[[CD_RowProtocol]] = {
        return (0..<Section.end.rawValue).map{_ in []}
    }()
    
    var block:(()->Void)?
    
    init() {
        makeForm()
    }
    mutating func makeForm() {
        makeSectionMe()
        makeSectionForm()
        
        block?()
    }
}



//MARK:--- 排版 ----------
extension VM_Mine{
    mutating func makeSectionMe(){
        do{
            let row = CD_Row<Cell_MineSign>(data: "登 录", frame: CGRect(h:45)) {
                VC_Sign.isSignUp(true)
            }
            self.forms[Section.me.rawValue].append(row)
        }
    }
}
extension VM_Mine{
    mutating func makeSectionForm() {
        let callBack:CD_RowCallBack = { _ in
            VC_Web.push(.http("https://github.com/liucaide/CD"))
        }
        
        do{
            let row = CD_Row<Cell_MineForm>(data: "Form-TableView", frame: CGRect(h:45), callBack: callBack) {
                VC_MineTableView.push()
            }
            self.forms[Section.form.rawValue].append(row)
        }
        do{
            let row = CD_RowClass<Cell_MineForm>(data: "Form-CollectionView", frame: CGRect(h:45), callBack:callBack) {
                VC_MineCollection.push()
            }
            self.forms[Section.form.rawValue].append(row)
        }
        
        // --------- IconFont CountDown ----------
        do{
            let row = CD_Row<Cell_MineTitle>(data: ("CD_CountDown","计时器"), frame: CGRect(h:45)) {
                VC_MineTableView.push()
            }
            self.forms[Section.other.rawValue].append(row)
        }
        do{
            let row = CD_RowClass<Cell_MineTitle>(data: ("CD_IconFont", "阿里矢量图标库 管理&使用"), frame: CGRect(h:45)) {
                VC_MineCollection.push()
            }
            self.forms[Section.other.rawValue].append(row)
        }
        do{
            let row = CD_RowClass<Cell_MineTitle>(data: ("CD_RegEx", "常用正则表达式"), frame: CGRect(h:45)) {
                VC_Web.push(.http("https://github.com/liucaide/CD/tree/master/CD/CD_RegEx"))
            }
            self.forms[Section.other.rawValue].append(row)
        }
        
        do{
            let row = CD_RowClass<Cell_MineTitle>(data: ("CD_Page", "分页"), frame: CGRect(h:45)) {
                R_PageList.push()
            }
            self.forms[Section.other.rawValue].append(row)
        }
        do{
            let row = CD_RowClass<Cell_MineTitle>(data: ("CD_HUD", "HUD"), frame: CGRect(h:45)) {
                let vm = VM_HUD()
                R_CDBaseTableViewController.push(vm)
            }
            self.forms[Section.other.rawValue].append(row)
        }
        do{
            let row = CD_RowClass<Cell_MineTitle>(data: ("CD_BaseTableViewController", "基础TableView"), frame: CGRect(h:45)) {
                let vm = VM_HUD()
                R_CDBaseTableViewController.push(vm)
            }
            self.forms[Section.other.rawValue].append(row)
        }
        do{
            let row = CD_RowClass<Cell_MineTitle>(data: ("CD_BaseCollectionViewController", "基础CollectionView"), frame: CGRect(h:45)) {
                let vm = VM_BaseColle()
                R_CDBaseCollectionViewController.push(vm)
            }
            self.forms[Section.other.rawValue].append(row)
        }
        do {
            for item in 0..<100 {
                let row = CD_RowClass<Cell_MineTitle>(data: ("\(item)", "\(item)"), frame: CGRect(h:45))
                self.forms[Section.num.rawValue].append(row)
            }
        }
    }
    
    
}
