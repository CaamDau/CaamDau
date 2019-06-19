//Created  on 2018/12/11  by LCD :https://github.com/liucaide .

import Foundation
import UIKit
import CD
import Util

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
extension Cell_BaseColleTitle:CD_RowUpdateProtocol {
    typealias DataSource = (UIImage,String)
    func row_update(_ data: (UIImage,String), id: String, tag: Int, frame: CGRect, callBack: CD_RowCallBack?) {
        btn.cd.image(data.0).text(data.1).text(Config.color.txt_1)
    }
}


public class Header_BaseCollectionReusableView: UICollectionReusableView {
    static let id:String = "CD_CollectionReusableViewNone"
    
}
extension Header_BaseCollectionReusableView:CD_RowUpdateProtocol{
    public typealias DataSource = UIColor
    public func row_update(_ data: UIColor, id: String, tag: Int, frame: CGRect, callBack: CD_RowCallBack?) {
        self.backgroundColor = data
    }
}


class VM_BaseColle {
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

extension VM_BaseColle: CD_ViewModelRefreshDelegater {
    var _mjRefreshType: [CD_MJRefreshModel.RefreshType] {
        return mjRefreshType
    }
}

extension VM_BaseColle: CD_ViewModelCollectionViewDelegater {
    var _collectionRegisters: [CD<UICollectionView>.CD_View] {
        return [.tCell(Cell_BaseColleTitle.self, nil, nil),
                .tView(Header_BaseCollectionReusableView.self, nil, .tHeader, nil)]
    }
    
}

extension VM_BaseColle: CD_ViewModelTopBarDelegater {}

extension VM_BaseColle: CD_ViewModelDataSource {
    
    func requestData(_ refresh: Bool) {
        
        for item in 0..<10 {
            let row = CD_Row<Cell_BaseColleTitle>(data: (Assets().logo_30, "String"), frame: CGRect(x: 5, y: 5, w: 50, h: 50))
            form.append([row,row,row,row,row,row,row,row,row,row,row,row])
        }
        
        CD_CountDown.after(3) {[weak self] in
            self?.mjRefreshType = [.tEnd]
            self?.reloadData?()
        }
    }
    
    var _form: [[CD_RowProtocol]] {
        return form
    }
    
    var _formHeader: [CD_RowProtocol] {
        return [CD_Row<Header_BaseCollectionReusableView>(data: UIColor.yellow, frame: CGRect(x: 15, y: 15, w: 100, h: 40)),
                CD_Row<Header_BaseCollectionReusableView>.init(data: UIColor.red, frame: CGRect(x: 5, y: 5, w: 100, h: 40), insets: UIEdgeInsets(t: 20, l: 20, b: 20, r: 20))]
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
