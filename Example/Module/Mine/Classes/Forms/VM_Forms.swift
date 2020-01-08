//Created  on 2019/12/20 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 *
 */




import Foundation
import CaamDau



struct R_Forms {
    static func push() {
        let vc = CD_FormTableViewController()
        vc._form = VM_Forms()
        CD.push(vc)
    }
}


struct VM_Forms {
    var forms: [[CD_CellProtocol]] = []
    var reloadData: (() -> Void)?
    
    init() {
        makeForm()
    }
    mutating func makeForm() {
        do{
            let row = CD_RowCell<CD_TableViewCellBase>.init(data: CD_TableViewCellBase.Model(title: "TableView"), frame: CGRect(h:45), callBack: { _ in
                /// Cell 内事件回调处理
            }) {
                /// Cell 点击事件处理
            }
            forms += [[row]]
        }
        do{
            let row = CD_RowCell<CD_TableViewCellBase>.init(data: CD_TableViewCellBase.Model(title: "CollectionView"), frame: CGRect(h:45)) {
                
            }
            forms += [[row]]
        }
        reloadData?()
    }
}

extension VM_Forms: CD_FormProtocol {
    var _forms: [[CD_CellProtocol]] {
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
