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
        R_CDBaseTableViewController.push(vm)
    }
}
class VM_PageList {
    lazy var form: [CD_RowProtocol] = {
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
            let row = CD_Row<CD_TableViewCellBase>(data: CD_TableViewCellBase.Model(title:item), frame: CGRect(h:45), didSelect: {
                VC_Page.push(VC_Page.Style(rawValue: i) ?? .hh)
            })
            form.append(row)
        }
    }
    
}

extension VM_PageList: CD_ViewModelTopBarDelegater {
    var _topBarCustom: ((CD_TopBar) -> Void)? {
        return { bar in
            bar._title = "CD_Page"
        }
    }
    var _topBarUpdate: ((CD_TopBar, CD_TopNavigationBar.Item) -> [CD_TopNavigationBarItem.Item.Style]?)? {
        return nil
    }
    
    
}
extension VM_PageList: CD_ViewModelRefreshDelegater {
    var _mjRefreshType: [CD_MJRefreshModel.RefreshType] {
        return []
    }
    
    var _mjRefresh: (header: Bool, footer: Bool, headerGif: Bool, footerGif: Bool) {
        return (header: false, footer: false, headerGif: false, footerGif: false)
    }
    
}

extension VM_PageList: CD_ViewModelTableViewDelegater {
    var _tableViewCustom: ((UITableView) -> Void)? {
        return { _ in
            //tab.cd.separator(style: .none)
        }
    }
}
extension VM_PageList: CD_ViewModelDataSource {
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
    
    var _form: [[CD_RowProtocol]] {
        return [form]
    }
    
    var _formHeader: [CD_RowProtocol] {
        return []
    }
    
    var _formFooter: [CD_RowProtocol] {
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



