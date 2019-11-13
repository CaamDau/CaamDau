//Created  on 2018/12/11  by LCD :https://github.com/liucaide .

import Foundation
import UIKit

public protocol CD_VMProtocol {
    associatedtype Input
    associatedtype Output
    func put(_ input: Input) -> Output
}

public protocol CD_ViewModelDataSource {
    /// 使用新的 Row 协议 CD_CellProtocol
    var _forms:[[CD_CellProtocol]] { get }
    /// 使用新的 Row 协议 CD_CellProtocol
    var _formHeaders:[CD_CellProtocol] { get }
    /// 使用新的 Row 协议 CD_CellProtocol
    var _formFooters:[CD_CellProtocol] { get }
    
    /// 使用旧的的 Row 协议 CD_CellProtocol
    var _form:[[CD_RowProtocol]] { get }
    /// 使用旧的的 Row 协议 CD_CellProtocol
    var _formHeader:[CD_RowProtocol] { get }
    /// 使用旧的的 Row 协议 CD_CellProtocol
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
    public var _reloadData:(()->Void)? {
        get {
            return nil
        }
        set(newValue) {
            
        }
    }
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
    public func requestData(_ refresh:Bool) {}
}

