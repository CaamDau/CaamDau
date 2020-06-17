//Created  on 2019/12/20 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 *
 */




import Foundation


struct R_Forms {
    static func push() {
        let vc = FormTableViewController()
        vc._form = VM_Forms()
        vc.title = "Form"
        CD.push(vc)
    }
}


struct VM_Forms {
    var forms: [[CellProtocol]] = []
    var reloadData: (() -> Void)?
    
    init() {
        makeForm()
    }
    mutating func makeForm() {
        do{
            let row = RowCell<RowTableViewCellBase>.init(data: RowTableViewCellBase.Model(title: "TableView"), frame: CGRect(h:45), callBack: { _ in
                /// Cell 内事件回调处理
            }) {
                /// Cell 点击事件处理
            }
            forms += [[row]]
        }
        do{
            let row = RowCell<RowTableViewCellBase>.init(data: RowTableViewCellBase.Model(title: "CollectionView"), frame: CGRect(h:45)) {
                
            }
            forms += [[row]]
        }
        reloadData?()
    }
}

extension VM_Forms: FormProtocol {
    var _forms: [[CellProtocol]] {
        return forms
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
