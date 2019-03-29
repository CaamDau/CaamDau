//Created  on 2018/12/13  by LCD :https://github.com/liucaide .

import Foundation
import UIKit

public extension CD where Base: UICollectionView {
    public enum CD_Kind:Int {
        case tHeader = 0
        case tFooter = 1
        
        public var stringValue:String{
            switch self {
            case .tHeader:
                return UICollectionView.elementKindSectionHeader
            default:
                return UICollectionView.elementKindSectionFooter
            }
        }
    }
    public enum CD_View {
        case tCell(_ cellClass:AnyClass, _ id:String?, _ bundleFrom:String?)
        case tView(_ viewClass:AnyClass, _ id:String?, _ kind:CD_Kind, _ bundleFrom:String?)
        
    }
    
    func register(_ model:[CD_View]){
        for (_, item) in model.enumerated() {
            switch item {
            case .tCell(let cellClass, let id, let from):
                let identifier = id ?? String(describing: cellClass)
                let bundleFrom = from ?? ""
                if bundleFrom.count == 0 {
                    let bundle = Bundle.main.path(forResource:identifier, ofType: "nib")
                    if bundle == nil{
                        base.register(cellClass, forCellWithReuseIdentifier: identifier)
                    }else{
                        let nib = UINib(nibName:identifier, bundle: nil)
                        base.register(nib, forCellWithReuseIdentifier: identifier)
                    }
                }else{
                    let nib = UINib(nibName:identifier, bundle: Bundle.cd_bundle(cellClass, bundleFrom))
                    base.register(nib, forCellWithReuseIdentifier: identifier)
                }
            case .tView(let viewClass, let id, let kind, let from):
                let identifier = id ?? String(describing: viewClass)
                let bundleFrom = from ?? ""
                if bundleFrom.count == 0 {
                    let bundle = Bundle.main.path(forResource:identifier, ofType: "nib")
                    if bundle == nil{
                        base.register(viewClass, forSupplementaryViewOfKind: kind.stringValue, withReuseIdentifier: identifier)
                    }else{
                        let nib = UINib(nibName:identifier, bundle: nil)
                        base.register(nib, forSupplementaryViewOfKind: kind.stringValue, withReuseIdentifier: identifier)
                    }
                }else{
                    let nib = UINib(nibName:identifier, bundle: Bundle.cd_bundle(viewClass, bundleFrom))
                    base.register(nib, forSupplementaryViewOfKind: kind.stringValue, withReuseIdentifier: identifier)
                }
            }
        }
    }
    func cell(_ id:String, _ index:IndexPath) -> UICollectionViewCell{
        return base.dequeueReusableCell(withReuseIdentifier: id, for: index)
    }
    func view(_ id:String,_ kind:CD_Kind, _ index:IndexPath) -> UICollectionReusableView{
        return base.dequeueReusableSupplementaryView(ofKind: kind.stringValue, withReuseIdentifier: id, for: index)
    }
    func view(_ id:String,_ kind:String, _ index:IndexPath) -> UICollectionReusableView{
        return base.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: id, for: index)
    }
}


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
