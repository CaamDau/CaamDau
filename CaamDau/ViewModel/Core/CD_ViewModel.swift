//Created  on 2018/12/11  by LCD :https://github.com/liucaide .

import Foundation
import UIKit

public protocol CD_VMProtocol {
    associatedtype Input
    associatedtype Output
    func put(_ input: Input) -> Output
}


// 历史项目原因，依然保留使用旧的Row协议
public protocol CD_ViewModelDataSource: CD_FormProtocol {
    /// 使用旧的的 Row 协议 CD_RowProtocol
    var _form:[[CD_RowProtocol]] { get }
    /// 使用旧的的 Row 协议 CD_RowProtocol
    var _formHeader:[CD_RowProtocol] { get }
    /// 使用旧的的 Row 协议 CD_RowProtocol
    var _formFooter:[CD_RowProtocol] { get }
    
    func requestData(_ refresh:Bool)
}


extension CD_ViewModelDataSource {
    public var _form:[[CD_RowProtocol]] { get{return []} }
    public var _formHeader:[CD_RowProtocol] { get{return []} }
    public var _formFooter:[CD_RowProtocol] { get{return []} }
    
    public func requestData(_ refresh:Bool) {}
}

