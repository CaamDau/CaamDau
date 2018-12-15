import UIKit
import Foundation


public struct CD<Base> {
    public let base: Base
    public init(_ base: Base) {
        self.base = base
    }
}
public protocol CD_Compatible:Any {
    associatedtype CompatibleType
    var cd: CompatibleType { get }
}
public extension CD_Compatible {
    public var cd: CD<Self> {
        return CD(self)
    }
}

extension NSObject: CD_Compatible {}


public extension CD where Base: UITableView {
    func cell(_ id:String, _ cellClass:AnyClass) -> UITableViewCell{
        var cell = base.dequeueReusableCell(withIdentifier: id)
        if cell == nil  {
            let bundle = Bundle.main.path(forResource:id, ofType: "nib")
            if bundle == nil{
                base.register(cellClass, forCellReuseIdentifier: id)
            }else{
                let nib = UINib(nibName: id, bundle: nil)
                base.register(nib, forCellReuseIdentifier: id)
            }
            cell = base.dequeueReusableCell(withIdentifier: id)
        }
        return cell ?? UITableViewCell()
    }
}



var tab = UITableView()

tab.cd.cell("", UITableViewCell.self)


