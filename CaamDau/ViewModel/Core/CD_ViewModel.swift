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
    /// 空数据视图
    var _emptyView:((Any?) -> UIView?)? { get }
    
    func requestData(_ refresh:Bool)
}


extension CD_ViewModelDataSource {
    
    public var _emptyView:((Any?) -> UIView?)? { get { nil } }
    
    public func requestData(_ refresh:Bool) {}
}

