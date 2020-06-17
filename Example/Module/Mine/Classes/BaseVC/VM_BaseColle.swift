//Created  on 2018/12/11  by LCD :https://github.com/liucaide .

import Foundation
import UIKit
import CaamDau

class Cell_BaseColleTitle:UICollectionViewCell {
    lazy var btn: UIButton = {
        return UIButton(frame: CGRect(x: 0, y: 10, w: 50, h: 30)).cd.text(UIColor.red).build
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.cd
            .background(UIColor.white)
            .add(btn)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
extension Cell_BaseColleTitle:RowCellUpdateProtocol {
    typealias DataSource = (UIImage,String)
    typealias ConfigModel = Any
    func row_update(dataSource data: DataSource) {
        btn.cd.image(data.0).text(data.1).text(Config.color.txt_1)
    }
}


public class Header_BaseCollectionReusableView: UICollectionReusableView {
    static let id:String = "CollectionReusableViewNone"
    
}
extension Header_BaseCollectionReusableView:RowCellUpdateProtocol{
    public typealias DataSource = UIColor
    public typealias ConfigModel = Any
    public func row_update(dataSource data: DataSource) {
        self.backgroundColor = data
    }
}


class VM_BaseColle {
    var form:[[CellProtocol]] = []
    //var formHeader:[CellProtocol]
    //var formFooter:[CellProtocol]
    var mjRefreshType:[RefreshModel.RefreshType] = [.tBegin, .tHiddenFoot(true)]
    
    var reloadData:(()->Void)?
    var reloadDataIndexPath:(([IndexPath],UITableView.RowAnimation)->Void)?
    
    var topBarCustom:((TopBar)->Void)?
    var topBarDidSelect:((TopBar,TopNavigationBar.Item)->Void)?
    
    init() {
        
        
    }
}

extension VM_BaseColle: ViewModelRefreshDelegater {
    var _mjRefreshType: [RefreshModel.RefreshType] {
        return mjRefreshType
    }
}

extension VM_BaseColle: ViewModelCollectionViewDelegater {
    
    
    var _collectionRegisters: [CaamDau<UICollectionView>.View] {
        return [.tCell(Cell_BaseColleTitle.self, nil, nil),
                .tView(Header_BaseCollectionReusableView.self, nil, .tHeader, nil)]
    }
    
}

extension VM_BaseColle: ViewModelTopBarDelegater {}

extension VM_BaseColle: ViewModelDataSource {
    
    
    func requestData(_ refresh: Bool) {
        
        for item in 0..<10 {
            let row = RowCell<Cell_BaseColleTitle>(data: (Assets().logo_30, "String"), frame: CGRect(x: 5, y: 5, w: 50, h: 50))
            form.append([row,row,row,row,row,row,row,row,row,row,row,row])
        }
        
        Time.after(3) {[weak self] in
            self?.mjRefreshType = [.tEnd]
            self?.reloadData?()
        }
    }
    
    var _forms: [[CellProtocol]] {
        return form
    }
    
    var _formHeader: [CellProtocol] {
        return [RowCell<Header_BaseCollectionReusableView>(data: UIColor.yellow, frame: CGRect(x: 15, y: 15, w: 100, h: 40)),
                RowCell<Header_BaseCollectionReusableView>.init(data: UIColor.red, frame: CGRect(x: 5, y: 5, w: 100, h: 40), insets: UIEdgeInsets(t: 20, l: 20, b: 20, r: 20))]
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
    
    var _reloadDataIndexPath: (([IndexPath], UITableView.RowAnimation) -> Void)? {
        get {
            return reloadDataIndexPath
        }
        set(newValue) {
            reloadDataIndexPath = newValue
        }
    }
}
