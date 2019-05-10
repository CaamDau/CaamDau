//Created  on 2018/12/11  by LCD :https://github.com/liucaide .

import Foundation
import UIKit
import CD
import Assets
import Config

class Cell_BaseTabTitle:UITableViewCell {
    lazy var btn: UIButton = {
        return UIButton(frame: CGRect(x: 20, y: 10, w: 100, h: 30)).cd.text(UIColor.red).build
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(btn)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
extension Cell_BaseTabTitle:CD_RowUpdateProtocol {
    typealias DataSource = (UIImage,String)
    func row_update(_ data: (UIImage,String), id: String, tag: Int, frame: CGRect, callBack: CD_RowCallBack?) {
        btn.cd.image(data.0).text(data.1).text(Config.color.txt_1)
    }
}



class VM_BaseTab {
    var form:[[CD_RowProtocol]] = []
    //var formHeader:[CD_RowProtocol]
    //var formFooter:[CD_RowProtocol]
    var mjRefreshType:[CD_MJRefreshModel.RefreshType] = [.tBegin, .tHiddenFoot(true)]
    
    var reloadData:(()->Void)?
    var reloadDataIndexPath:(([IndexPath],UITableView.RowAnimation)->Void)?
    
    var topBarCustom:((CD_TopBar)->Void)?
    var topBarDidSelect:((CD_TopBar,CD_TopNavigationBar.Item)->Void)?
    
    init() {
        
        
    }
}

extension VM_BaseTab: CD_ViewModelRefreshDelegater {
    var _mjRefreshType: [CD_MJRefreshModel.RefreshType] {
        return mjRefreshType
    }
    
    
}

extension VM_BaseTab: CD_ViewModelTableViewDelegater {
    var _tableViewCustom: ((UITableView) -> Void)? {
        return { tab in
            tab.cd.background(UIColor.lightGray)
        }
    }
}

extension VM_BaseTab: CD_ViewModelTopBarDelegater {
    var _topBarCustom: ((CD_TopBar) -> Void)? {
        return { bar in
            bar._style = "22"
        }
    }
    var _topBarUpdate: ((CD_TopBar, CD_TopNavigationBar.Item) -> [CD_TopNavigationBarItem.Item.Style]?)? {
        return { (top,item) -> [CD_TopNavigationBarItem.Item.Style]?  in
            switch item {
            case .leftItem1:
                return [.title([(CD_IconFont.tclose(30).text,CD_IconFont.tclose(30).font,.black,.normal), (CD_IconFont.tclose(30).text,CD_IconFont.tclose(30).font,.lightGray,.highlighted), (CD_IconFont.tclose(30).text,CD_IconFont.tclose(30).font,.lightGray,.selected)])]
            case .leftItem2:
                return [.title([(CD_IconFont.tclose(30).text,CD_IconFont.tclose(30).font,.black,.normal), (CD_IconFont.tclose(30).text,CD_IconFont.tclose(30).font,.lightGray,.highlighted), (CD_IconFont.tclose(30).text,CD_IconFont.tclose(30).font,.lightGray,.selected)])]
            default:
                return nil
            }
        }
    }
}

extension VM_BaseTab: CD_ViewModelDataSource {
    
    func requestData(_ refresh: Bool) {
        
        for item in 0..<10 {
            let row = CD_Row<Cell_BaseTabTitle>(data: (Assets().logo_30, "String"), frame: CGRect( h: 50))
            form.append([row])
        }
        CD_CountDown.after(5) {[weak self] in
            self?.mjRefreshType = [.tEnd]
            self?.reloadData?()
        }
    }
    
    var _collectionRegisters: [CD<UICollectionView>.CD_View] {
        return []
    }
    
    var _form: [[CD_RowProtocol]] {
        return form
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
    
    var _reloadDataIndexPath: (([IndexPath], UITableView.RowAnimation) -> Void)? {
        get {
            return reloadDataIndexPath
        }
        set(newValue) {
            reloadDataIndexPath = newValue
        }
    }
}
