//Created  on 2018/12/13  by LCD :https://github.com/liucaide .
/***** 模块文档 *****
* Form : TableView、CollectionView 流式排版协议，
 将 数据源 转化为 CD_RowCell / CD_RowCellClass 模型，即可将排版内容模型化，将 Delegate DataSource 多点关系，转化为单点关系，更便于扩展、维护、数据精准绑定。
 CD_FormProtocol 是为普通MVVM模式准备
*/


import Foundation
import UIKit

public typealias CD_Form = [CD_CellProtocol]
public typealias CD_Forms = [[CD_CellProtocol]]

public typealias CD_FormProtocol = (CD_FormDataSource & CD_FormDelegate)
public typealias CD_FormRowAnimation = UITableView.RowAnimation

public protocol CD_FormDataSource {
    /// 单元格数据组配置
    var _forms:[[CD_CellProtocol]] { get }
    /// 页首数据组配置
    var _formHeaders:[CD_CellProtocol] { get }
    /// 页尾数据组配置
    var _formFooters:[CD_CellProtocol] { get }
}

public protocol CD_FormDelegate {
    /// 数据刷新
    var _reloadData:(()->Void)? { set get }
    /// 指定单元格刷新 Animation 适用于 TableView, CollectionView无效
    var _reloadRows:(([IndexPath],CD_FormRowAnimation)->Void)? { set get }
    /// 指定组刷新  Animation 适用于 TableView, CollectionView无效
    var _reloadSections:((IndexSet,CD_FormRowAnimation)->Void)? { set get }
}


extension CD_FormDataSource {
    public var _forms:[[CD_CellProtocol]] { get{return []} }
    public var _formHeaders:[CD_CellProtocol] { get{return []} }
    public var _formFooters:[CD_CellProtocol] { get{return []} }
}


extension CD_FormDelegate {
    public var _reloadData:(()->Void)? {
        get {
            return nil
        }
        set(newValue) {
            
        }
    }
    public var _reloadRows:(([IndexPath],CD_FormRowAnimation)->Void)? {
        get {
            return nil
        }
        set(newValue) {
            
        }
    }
    public var _reloadSections:((IndexSet,CD_FormRowAnimation)->Void)? {
        get {
            return nil
        }
        set(newValue) {
            
        }
    }
    
}



