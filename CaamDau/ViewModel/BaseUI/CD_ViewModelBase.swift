//Created  on 2018/12/11  by LCD :https://github.com/liucaide .

import Foundation
import UIKit



public typealias CD_ViewModelTableViewProtocol = (CD_ViewModelDataSource & CD_ViewModelRefreshDelegater & CD_ViewModelTopBarDelegater & CD_ViewModelTableViewDelegater)
public typealias CD_ViewModelCollectionViewProtocol = (CD_ViewModelDataSource & CD_ViewModelRefreshDelegater & CD_ViewModelTopBarDelegater & CD_ViewModelCollectionViewDelegater)


public protocol CD_ViewModelRefreshDelegater {
    var _mjRefresh:(header:Bool, footer:Bool, headerGif:Bool, footerGif:Bool) { get }
    var _mjRefreshModel:CD_MJRefreshModel { get }
    var _mjRefreshType:[CD_MJRefreshModel.RefreshType] { get }
}
extension CD_ViewModelRefreshDelegater {
    public var _mjRefresh: (header: Bool, footer: Bool, headerGif: Bool, footerGif: Bool) {
        return (header: true, footer: true, headerGif: false, footerGif: false)
    }
    public var _mjRefreshModel: CD_MJRefreshModel {
        return CD_MJRefresh.shared.model
    }
    public var _mjRefreshType:[CD_MJRefreshModel.RefreshType] {
        return []
    }
}


public protocol CD_ViewModelViewDelegater {
    //var _safeAreaLayout:(top:Bool, bottom:Bool) { get }
    var _bottomBarHeignt:CGFloat { get }
    var _bottomBarCustom:((UIView)->Void)? { get }
}

extension CD_ViewModelViewDelegater {
//    public var _safeAreaLayout:(top:Bool, bottom:Bool) {
//        get{
//            return (true, true)
//        }
//    }
    public var _bottomBarCustom:((UIView)->Void)? {
        return { _ in
        }
    }
    public var _bottomBarHeignt:CGFloat {
        get{
            return 0
        }
    }
}

public protocol CD_ViewModelTableViewDelegater: CD_ViewModelViewDelegater {
    var _tableViewCustom:((UITableView)->Void)? { get }
}
public extension CD_ViewModelTableViewDelegater {
    public var _tableViewCustom:((UITableView)->Void)? {
        return { _ in
        }
    }
}


public protocol CD_ViewModelCollectionViewDelegater: CD_ViewModelViewDelegater {
    var _collectionRegisters:[CaamDau<UICollectionView>.View] { get }
    var _collectionViewCustom:((UICollectionView)->Void)? { get }
}
extension CD_ViewModelCollectionViewDelegater {
    public var _collectionRegisters:[CaamDau<UICollectionView>.View] {
        return []
    }
    public var _collectionViewCustom:((UICollectionView)->Void)? {
        return { _ in
        }
    }
}


public protocol CD_ViewModelTopBarDelegater {
    var _topBarCustom:((CD_TopBar)->Void)? { get }
    var _topBarDidSelect:((CD_TopBar,CD_TopNavigationBar.Item)->Void)? { get }
    var _topBarUpdate:((CD_TopBar,CD_TopNavigationBar.Item)->[CD_TopNavigationBarItem.Item.Style]?)? { get }
}
extension CD_ViewModelTopBarDelegater {
    public var _topBarCustom:((CD_TopBar)->Void)? {
        return { _ in
        }
    }
    
    public var _topBarDidSelect: ((CD_TopBar, CD_TopNavigationBar.Item) -> Void)? {
        return { (top, item) in
            top.topBarItemClick(item)
        }
    }
    
    public var _topBarUpdate:((CD_TopBar,CD_TopNavigationBar.Item)->[CD_TopNavigationBarItem.Item.Style]?)? {
        return nil
    }
}

