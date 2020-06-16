//Created  on 2019/2/27 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 *
 */




import Foundation
import CaamDau

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
                return "Form"
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
    
    var forms:[[CellProtocol]] = (0..<Section.end.rawValue).map{_ in []}
    
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
            let row = RowCell<Cell_MineSign>(data: "登 录 - 不可返回", frame: CGRect(h:45)) {
                Router.Sign.up.router(["canBack":false]) { res in
                    
                }
                
            }
            self.forms[Section.me.rawValue].append(row)
        }
        
        do{
            let row = RowCell<Cell_MineSign>(data: "登 录 - 可以返回", frame: CGRect(h:45)) {
                Router.Sign.up.router(["canBack":true])
                
            }
            self.forms[Section.me.rawValue].append(row)
        }
        
        do{
            let row = RowCell<Cell_MineSign>(data: "登 录 - Router open url", frame: CGRect(h:45)) {
                Router.open(url: "caamdau://sign/up/out", param: ["canBack":true.stringValue, "haha":"好啊好啊"])
            }
            self.forms[Section.me.rawValue].append(row)
        }
    }
}
extension VM_Mine{
    mutating func makeSectionForm() {
        let callBack:RowCallBack = { _ in
            Router.Utility.http.router(["url":"https://github.com/liucaide/CaamDau", "title": "CaamDau"])
        }
        do{
            let row = RowCell<Cell_MineForm>(data: ("Form", Assets().com_点赞_已点), frame: CGRect(h:45), callBack: callBack) {
                R_Forms.push()
            }
            self.forms[Section.form.rawValue].append(row)
        }
        do{
            let row = RowCell<Cell_MineForm>(data: ("Form-TableView", Assets().com_点赞_已点), frame: CGRect(h:45), callBack: callBack) {
                VC_MineTableView.push()
            }
            self.forms[Section.form.rawValue].append(row)
        }
        do{
            let row = RowCell<Cell_MineForm>(data: ("Form-CollectionView", Assets().com_点赞_已点), frame: CGRect(h:45), callBack:callBack) {
                VC_MineCollection.push()
            }
            self.forms[Section.form.rawValue].append(row)
        }
        
        // --------- IconFont CountDown ----------
        do{
            let row = RowCell<RowTableViewCellBase>(data: RowTableViewCellBase.Model(title: "Timer", detail: "计时器"), frame: CGRect(h:45)) {
                VC_MineTableView.push()
            }
            self.forms[Section.other.rawValue].append(row)
        }
        do{
            let row = RowCell<Cell_MineTitle>(data: ("IconFont", "阿里矢量图标库 管理&使用"), frame: CGRect(h:45)) {
                VC_MineCollection.push()
            }
            self.forms[Section.other.rawValue].append(row)
        }
        do{
            let row = RowCell<Cell_MineTitle>(data: ("RegEx", "常用正则表达式"), frame: CGRect(h:45)) {
                Router.Utility.http.router(["url":"https://github.com/liucaide/CaamDau/RegEx", "title": "CaamDau"])
            }
            self.forms[Section.other.rawValue].append(row)
        }
        
        do{
            let row = RowCell<Cell_MineTitle>(data: ("Page", "分页"), frame: CGRect(h:45)) {
                R_PageList.push()
            }
            self.forms[Section.other.rawValue].append(row)
        }
        do{
            let row = RowCell<Cell_MineTitle>(data: ("HUD", "HUD"), frame: CGRect(h:45)) {
                let vm = VM_HUD()
                R_CDTableViewController.push(vm)
            }
            self.forms[Section.other.rawValue].append(row)
        }
        do{
            let row = RowCell<RowTableViewCellBase>(data: RowTableViewCellBase.Model(title:"BaseTableViewController", detail: "基础TableView"), frame: CGRect(h:45)) {
                let vm = VM_HUD()
                R_CDTableViewController.push(vm)
            }
            self.forms[Section.other.rawValue].append(row)
        }
        do{
            let row = RowCell<Cell_MineTitle>(data: ("BaseCollectionViewController", "基础CollectionView"), frame: CGRect(h:45)) {
                let vm = VM_BaseColle()
                R_CDCollectionViewController.push(vm)
            }
            self.forms[Section.other.rawValue].append(row)
        }
        do{
            let row = RowCell<Cell_MineTitle>(data: ("Indexes", "侧边索引"), frame: CGRect(h:45)) {
                VC_Indexes.router()
            }
            self.forms[Section.other.rawValue].append(row)
        }
        do{
            let row = RowCell<Cell_MineTitle>(data: ("DatePickerAlert - Alert", "时间选择器"), frame: CGRect(h:45)) {
                
                DatePickerAlert.show(.yyyyMM, date: Date(), preferredStyle: .alert, callback: { (da) in
                    print_cd(da)
                }) {
                    $0.colorLine = Config.color.line_1
                    $0.colorCancel = Config.color.txt_1
                    $0.colorDone = Config.color.main_1
                    $0.minDate = "2019-3-10".cd.date("yyyy-MM-dd")!
                }
            }
            self.forms[Section.other.rawValue].append(row)
        }
        do{
            let row = RowCell<Cell_MineTitle>(data: ("DatePickerAlert - Sheet", "时间选择器"), frame: CGRect(h:45)) {
                
                DatePickerAlert.show(.yyyyMM, date: Date(), preferredStyle: .sheet, callback: { (da) in
                    print_cd(da)
                }) {
                    $0.colorLine = Config.color.line_1
                    $0.colorCancel = Config.color.txt_1
                    $0.colorDone = Config.color.main_1
                    $0.minDate = "2019-3-10".cd_date("yyyy-MM-dd")!
                    $0.maxDate = "2020-11-20".cd_date("yyyy-MM-dd")!
                }
            }
            self.forms[Section.other.rawValue].append(row)
        }
        do{
            let row = RowCell<Cell_MineTitle>(data: ("PencilKit-PencilDraw", "点击头像查看"), frame: CGRect(h:45)) {
            }
            self.forms[Section.other.rawValue].append(row)
        }
        do{
            let la = Locale.preferredLanguages.first ?? ""
            let row = RowCell<Cell_MineTitle>(data: ("当前语言", la), frame: CGRect(h:45)) {
            }
            self.forms[Section.other.rawValue].append(row)
        }
        do {
            for item in Locale.preferredLanguages {
                let row = RowCell<Cell_MineTitle>(data: ("\(item)", "\(item)"), frame: CGRect(h:45))
                self.forms[Section.num.rawValue].append(row)
            }
            
            self.forms[Section.num.rawValue].append(RowCell<Cell_MineTitle>(data: ("--", "--"), frame: CGRect(h:45)))
            
            for item in UserDefaults.standard.stringArray(forKey: "AppleLanguages") ?? [] {
                let row = RowCell<Cell_MineTitle>(data: ("\(item)", "\(item)"), frame: CGRect(h:45))
                self.forms[Section.num.rawValue].append(row)
            }
        }
    }
    
    
}


extension VM_Mine: ViewModelTableViewProtocol {
    var _forms: [[CellProtocol]] {
        return forms
    }
    
    
}
