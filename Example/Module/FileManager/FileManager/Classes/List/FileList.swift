//Created  on 2019/12/4 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 *
 */




import Foundation
import CaamDau
import Utility

public struct R_FileList: CD_RouterInterface {
    public static func router(_ param: CD_RouterParameter = [:], callback: CD_RouterCallback = nil) {
        let style = Style(rawValue: param.stringValue("style")) ?? .look
        let vm = FileList(style)
        vm.fileName = param.string("file") ?? "file"
        vm.names = param.arrayValue("names") as? [String] ?? []
        vm.callback = callback
        R_CDTableViewController.push(vm)
        
    }
    
    public static func push(_ style:Style = .look, file:String = "file", names:[String] = [], callback:CD_RouterCallback = nil) {
        let vm = FileList(style)
        vm.names = names
        vm.callback = callback
        R_CDTableViewController.push(vm)
    }
    public enum Style:String {
        case select = "select"
        case look = "look"
        case manager = "manager"
        
        var hidden:Bool {
            switch self {
            case .select:
                return false
            case .look:
                return true
            case .manager:
                return false
            }
        }
    }
}



class FileList: NSObject {
    init(_ style:R_FileList.Style) {
        super.init()
        self.style = style
    }
    var fileName = "file"
    var style:R_FileList.Style = .look
    var names:[String] = []
    var callback:CD_RouterCallback = nil
    
    lazy var path: String = {
        let path = CDFileManager.pathForDocumentsDirectory(withPath: fileName) ?? fileName
        guard !CDFileManager.existsItem(atPath: path) else {
            return path
        }
        guard CDFileManager.createDirectories(forPath: path) else {
            hud_error("文件目录不存在")
            return path
        }
        return path
    }()
    
    var models:[Model] = []
    var forms:[[CD_CellProtocol]] = []
    var reloadData: (() -> Void)?
    var mjRefreshType: [CD_MJRefreshModel.RefreshType] = [.tBegin]
    
    func makeModels() {
        let old = models
        let list = CDFileManager.listFilesInDirectory(atPath: path, deep: true)
        models = list?.filter{ $0 is String}.map({ (url) -> Model in
            let url = url as! String
            let model = Model(url: url)
            if old.isEmpty {
                model.select = names.contains(model.name)
            }else{
                model.select = old.filter{ $0.url == url }.map{$0}.first?.select ?? false
            }
            return model
        }) ?? []
        
        makeForms()
    }
    
    func makeForms() {
        let f = models.map { (m) -> CD_CellProtocol in
            let row = CD_RowCell<Cell_FileList>.init(data: m, config: style.hidden, frame: CGRect(h:60), bundleFrom: "FileManager", callBack: { [weak self](a) in
                m.select = !m.select
                self?.reloadData?()
            }) { [weak self] in
                self?.didSelect(m)
            }
            return row
        }
        forms = [f]
        mjRefreshType = [.tEnd]
        reloadData?()
    }
    
    func didSelect(_ m:Model){
        let url = URL(fileURLWithPath: m.url)
        let vc = UIDocumentInteractionController(url: url)
        vc.delegate = self
        vc.presentPreview(animated: true)
    }
    
    func remove() {
        models.filter{$0.select}.forEach {
            CDFileManager.removeItem(atPath: $0.url)
        }
        requestData(true)
    }
}

extension FileList: UIDocumentInteractionControllerDelegate {
    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
        return CD.window!.rootViewController!
    }
}

extension FileList: CD_ViewModelTableViewProtocol {
    var _forms: [[CD_CellProtocol]] {
        return forms
    }
    var _mjRefresh: (header: Bool, footer: Bool, headerGif: Bool, footerGif: Bool) {
        return (true, false, false, false)
    }
    var _mjRefreshType: [CD_MJRefreshModel.RefreshType] {
        return mjRefreshType
    }
    var _reloadData: (() -> Void)? {
        set{
           reloadData = newValue
        }
        get{
            return reloadData
        }
    }
    func requestData(_ refresh: Bool) {
        makeModels()
    }
    
}

extension FileList {
    var _tableViewCustom: ((UITableView) -> Void)? {
        return { tab in
            tab.cd
                .background(Config.color.bg)
                .separator(color: Config.color.line_1)
        }
    }
    var _topBarCustom: ((CD_TopBar) -> Void)? {
        return { [weak self] (top) in
            top._title = "文件"
            top._style = "12"
            top._rightItemsSpaceSide = 10
            top._rightItemsWidth1 = 50
            top._rightItemsWidth2 = 50
            top.cd.white()
            top.bar_navigation.line.isHidden = true
            switch self?.style {
            case .select:
                top.bar_navigation.item_right.btn_2.cd
                    .text(Config.font.font(16))
                    .text(Config.color.txt_1)
                    .text("确定")
            case .look:
                top.bar_navigation.item_right.btn_2.cd
                    .text(Config.font.font(16))
                    .text(Config.color.txt_1)
                    .text("管理")
            case .manager:
                top.bar_navigation.item_right.btn_1.cd
                    .text(Config.font.font(16))
                    .text(Config.color.error)
                    .text("删除")
                top.bar_navigation.item_right.btn_2.cd
                    .text(Config.font.font(16))
                    .text(Config.color.txt_1)
                    .text("取消")
            default:
                break
            }
        }
    }
    var _topBarDidSelect: ((CD_TopBar, CD_TopNavigationBar.Item) -> Void)? {
        return { [weak self](top, item) in
            top.super_topBarClick(item)
            switch item {
            case .rightItem2 where self?.style == .select:
                self?.callback?(["models":self!.models.filter{$0.select}.map{$0.toJSON()}])
                CD.pop()
            case .rightItem2 where self?.style == .look:
                self?.style = .manager
                self?.makeForms()
                top.bar_navigation.item_right.btn_1.cd
                    .text(Config.font.font(16))
                    .text(Config.color.error)
                    .text("删除")
                top.bar_navigation.item_right.btn_2.cd
                    .text(Config.font.font(16))
                    .text(Config.color.txt_1)
                    .text("取消")
                
            case .rightItem1 where self?.style == .manager:
                self?.remove()
                
            case .rightItem2 where self?.style == .manager:
                self?.style = .look
                self?.makeForms()
                top.bar_navigation.item_right.btn_2.cd
                    .text(Config.font.font(16))
                    .text(Config.color.txt_1)
                    .text("管理")
                top.bar_navigation.item_right.btn_1.cd.text("")
            default:
                break
            }
        }
    }
}


extension FileList {
    class Model {
        let url:String
        var name:String = ""
        var color:UIColor = .blue
        var suffix:String = ""
        var select = false
        init(url:String) {
            self.url = url
            self.name = CDFileManager.name(forPath: url)
            self.suffix = CDFileManager.extension(forPath: url)
            
            color = Config.color.file(suffix) //App_File.color(suffix)
        }
        
        func toJSON() -> [String:Any]{
            return ["name":name,
                    "color":color,
                    "url":url,
                    "suffix":suffix]
        }
    }
}
