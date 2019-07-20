//Created  on 2018/12/11  by LCD :https://github.com/liucaide .

import Foundation
import UIKit

public protocol CD_VMProtocol {
    associatedtype Input
    associatedtype Output
    func put(_ input: Input) -> Output
}



public typealias CD_ViewModelTableViewProtocol = (CD_ViewModelDataSource & CD_ViewModelRefreshDelegater & CD_ViewModelTopBarDelegater & CD_ViewModelTableViewDelegater)
public typealias CD_ViewModelCollectionViewProtocol = (CD_ViewModelDataSource & CD_ViewModelRefreshDelegater & CD_ViewModelTopBarDelegater & CD_ViewModelCollectionViewDelegater)

public protocol CD_ViewModelDataSource {
    var _forms:[[CD_CellProtocol]] { get }
    var _formHeaders:[CD_CellProtocol] { get }
    var _formFooters:[CD_CellProtocol] { get }
    
    var _form:[[CD_RowProtocol]] { get }
    var _formHeader:[CD_RowProtocol] { get }
    var _formFooter:[CD_RowProtocol] { get }
    
    var _reloadData:(()->Void)? { set get }
    var _reloadDataIndexPath:(([IndexPath],UITableView.RowAnimation)->Void)? { set get }
    var _reloadSections:((IndexSet,UITableView.RowAnimation)->Void)? { set get }
    func requestData(_ refresh:Bool)
}
extension CD_ViewModelDataSource {
    public var _forms:[[CD_CellProtocol]] { get{return []} }
    public var _formHeaders:[CD_CellProtocol] { get{return []} }
    public var _formFooters:[CD_CellProtocol] { get{return []} }
    
    public var _form:[[CD_RowProtocol]] { get{return []} }
    public var _formHeader:[CD_RowProtocol] { get{return []} }
    public var _formFooter:[CD_RowProtocol] { get{return []} }
    public var _reloadDataIndexPath: (([IndexPath], UITableView.RowAnimation) -> Void)? {
        get {
            return nil
        }
        set(newValue) {
            
        }
    }
    public var _reloadSections:((IndexSet,UITableView.RowAnimation)->Void)? {
        get {
            return nil
        }
        set(newValue) {
            
        }
    }
}

public protocol CD_ViewModelRefreshDelegater {
    var _mjRefresh:(header:Bool, footer:Bool, headerGif:Bool, footerGif:Bool) { get }
    var _mjRefreshModel:CD_MJRefreshModel { get }
    var _mjRefreshType:[CD_MJRefreshModel.RefreshType] { get }
}
public extension CD_ViewModelRefreshDelegater {
    public var _mjRefresh: (header: Bool, footer: Bool, headerGif: Bool, footerGif: Bool) {
        return (header: true, footer: true, headerGif: false, footerGif: false)
    }
    public var _mjRefreshModel: CD_MJRefreshModel {
        return CD_MJRefresh.shared.model
    }
}


public protocol CD_ViewModelTableViewDelegater {
    var _tableViewCustom:((UITableView)->Void)? { get }
    var _safeAreaLayout:Bool { get }
}
public extension CD_ViewModelTableViewDelegater {
    public var _tableViewCustom:((UITableView)->Void)? {
        return { _ in
        }
    }
    public var _safeAreaLayout:Bool {
        get{
            return true
        }
    }
}


public protocol CD_ViewModelCollectionViewDelegater {
    var _collectionRegisters:[CaamDau<UICollectionView>.CD_View] { get }
    var _collectionViewCustom:((UICollectionView)->Void)? { get }
    var _safeAreaLayout:Bool { get }
}
public extension CD_ViewModelCollectionViewDelegater {
    public var _collectionRegisters:[CaamDau<UICollectionView>.CD_View] {
        return []
    }
    public var _collectionViewCustom:((UICollectionView)->Void)? {
        return { _ in
        }
    }
    public var _safeAreaLayout:Bool {
        get{
            return true
        }
    }
}


public protocol CD_ViewModelTopBarDelegater {
    var _topBarCustom:((CD_TopBar)->Void)? { get }
    var _topBarDidSelect:((CD_TopBar,CD_TopNavigationBar.Item)->Void)? { get }
    var _topBarUpdate:((CD_TopBar,CD_TopNavigationBar.Item)->[CD_TopNavigationBarItem.Item.Style]?)? { get }
}
public extension CD_ViewModelTopBarDelegater {
    public var _topBarCustom:((CD_TopBar)->Void)? {
        return { _ in
        }
    }
    
    public var _topBarDidSelect: ((CD_TopBar, CD_TopNavigationBar.Item) -> Void)? {
        return { (top, item) in
            top.super_topBarClick(item)
        }
    }
    
    public var _topBarUpdate:((CD_TopBar,CD_TopNavigationBar.Item)->[CD_TopNavigationBarItem.Item.Style]?)? {
        return nil
    }
}

