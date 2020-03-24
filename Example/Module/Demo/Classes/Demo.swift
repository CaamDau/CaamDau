//Created  on 2020/3/3 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 *
 */




import Foundation

public struct R_Demo {
    public init(){}
    public var vc: UIViewController {
        let vc = CD_TableViewController()
        vc.vm = VM_Demo()
        return vc
    }
}

class VM_Demo {
    var forms: [[CD_CellProtocol]] = []
    var reloadData: (() -> Void)?
    var address = "" {
        didSet {
            makeForm()
        }
    }
    init() {
        Router.Map.location.router { [weak self](res) in
            guard let location = res?.dictValue("address") else{return}
            print(location)
            self?.address = location.stringValue("country")+location.stringValue("province")+location.stringValue("city")
        }
        makeForm()
    }
    
    func makeForm() {
        forms = []
        do{
            let row = CD_RowCell<CD_TableViewCellBase>(data: CD_TableViewCellBase.Model(title: "我的位置", detail: address), frame: CGRect(h:60)) {
                
            }
            forms += [[row]]
        }
        do{
            let row = CD_RowCell<CD_TableViewCellBase>(data: CD_TableViewCellBase.Model(title: "CD_PencilDraw", detail: address), frame: CGRect(h:60)) {
                Router.Utility.pencilDraw.router()
            }
            forms += [[row]]
        }
        reloadData?()
    }
}

extension VM_Demo: CD_ViewModelTableViewProtocol {
    var _forms: [[CD_CellProtocol]] {
        return forms
    }
    
    var _mjRefresh: (header: Bool, footer: Bool, headerGif: Bool, footerGif: Bool) {
        return (false, false, false, false)
    }
    
    var _reloadData: (() -> Void)? {
        set{
            reloadData = newValue
        }
        get{
            return reloadData
        }
    }
}

extension VM_Demo {
    var _topBarCustom: ((CD_TopBar) -> Void)? {
        return { top in
            top._title = "Demo"
            top.bar_navigation._leftWidth1 = 0
        }
    }
}
