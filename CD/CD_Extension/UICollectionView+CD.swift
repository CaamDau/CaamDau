//Created  on 2018/12/13  by LCD :https://github.com/liucaide .

import Foundation
import UIKit


public extension UICollectionView {
    
}
//MARK:--- 默认的空 UICollectionViewCell CD_CollectionReusableView ----------
public class CD_CollectionViewCellNone: UICollectionViewCell{
    static let id:String = "CD_CollectionViewCellNone"
    func update(_ data: Any, id: String, tag: Int, frame: CGRect, callBack: CD_RowCallBack?) {
    }
}
extension CD_CollectionViewCellNone:CD_RowUpdateProtocol{
    public typealias DataSource = Any
    public func row_update(_ data: Any, id: String, tag: Int, frame: CGRect, callBack: CD_RowCallBack?) {
        self.update(data, id: id, tag: tag, frame: frame, callBack: callBack)
    }
}
public class CD_CollectionReusableViewNone: UICollectionReusableView {
    static let id:String = "CD_CollectionReusableViewNone"
    func update(_ data: Any, id: String, tag: Int, frame: CGRect, callBack: CD_RowCallBack?) {
    }
}
extension CD_CollectionReusableViewNone:CD_RowUpdateProtocol{
    public typealias DataSource = Any
    public func row_update(_ data: Any, id: String, tag: Int, frame: CGRect, callBack: CD_RowCallBack?) {
        self.update(data, id: id, tag: tag, frame: frame, callBack: callBack)
    }
}


//MARK:--- 瀑布流 ----------
