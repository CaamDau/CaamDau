//Created  on 2019/6/4 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 *
 */

import Foundation
import CaamDau

//MARK:--- 接口 ----------
struct R_PageList {
    static func push() {
        let vm = VM_PageList()
        R_CDTableViewController.push(vm)
    }
}
class VM_PageList {
    lazy var form: [CellProtocol] = {
        return []
    }()
    var reloadData:(()->Void)?
    init() {
        makeForm()
    }
}

extension VM_PageList {
    func makeForm() {
        for (i,item) in ["默认-横向-横向","横向-纵向","纵向-纵向","纵向-横向"].enumerated() {
            let row = RowCell<RowTableViewCellBase>(data: RowTableViewCellBase.Model(title:item), frame: CGRect(h:45), didSelect: {
                VC_Page.push(VC_Page.Style(rawValue: i) ?? .hh)
            })
            form.append(row)
        }
    }
    
}

extension VM_PageList: ViewModelTopBarDelegater {
    var _topBarCustom: ((TopBar) -> Void)? {
        return { bar in
            bar._title = "Page"
        }
    }
    var _topBarUpdate: ((TopBar, TopNavigationBar.Item) -> [TopNavigationBarItem.Item.Style]?)? {
        return nil
    }
    
    
}
extension VM_PageList: ViewModelRefreshDelegater {
    var _mjRefreshType: [RefreshModel.RefreshType] {
        return []
    }
    
    var _mjRefresh: (header: Bool, footer: Bool, headerGif: Bool, footerGif: Bool) {
        return (header: false, footer: false, headerGif: false, footerGif: false)
    }
    
}

extension VM_PageList: ViewModelTableViewDelegater {
    var _tableViewCustom: ((UITableView) -> Void)? {
        return { _ in
            //tab.cd.separator(style: .none)
        }
    }
}
extension VM_PageList: ViewModelDataSource {
    var _reloadDataIndexPath: (([IndexPath], UITableView.RowAnimation) -> Void)? {
        get {
            return nil
        }
        set(newValue) {
            
        }
    }
    
    
    func requestData(_ refresh: Bool) {
        
    }
    
    var _collectionRegisters: [CaamDau<UICollectionView>.View] {
        return []
    }
    
    var _forms: [[CellProtocol]] {
        return [form]
    }
    
    var _formHeaders: [CellProtocol] {
        return []
    }
    
    var _formFooters: [CellProtocol] {
        return []
    }
    
    var _reloadData: (() -> Void)? {
        get {
            return reloadData
        }
        set(newValue) {
            reloadData = newValue
        }
    }
}



