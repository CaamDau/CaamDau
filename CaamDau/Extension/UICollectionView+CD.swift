//Created  on 2019/2/28 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 *
 */

import Foundation
import UIKit

public extension CaamDau where Base: UICollectionView {
    
    @discardableResult
    func background(view v: UIView?) -> CaamDau {
        base.backgroundView = v
        return self
    }
    
    @discardableResult
    func layout(_ l: UICollectionViewLayout) -> CaamDau {
        base.collectionViewLayout = l
        return self
    }
    
    @discardableResult
    func dataSource(_ d: UICollectionViewDataSource?) -> CaamDau {
        base.dataSource = d
        return self
    }
    
    @discardableResult
    func delegate(_ d: UICollectionViewDelegate?) -> CaamDau {
        base.delegate = d
        return self
    }
    
    @discardableResult
    func prefetch(dataSource d: UICollectionViewDataSourcePrefetching?) -> CaamDau {
        if #available(iOS 10.0, *) {
            base.prefetchDataSource = d
        } else {
            // Fallback on earlier versions
        }
        return self
    }
    
    @discardableResult
    func isPrefetching(enabled e: Bool) -> CaamDau {
        if #available(iOS 10.0, *) {
            base.isPrefetchingEnabled = e
        } else {
            // Fallback on earlier versions
        }
        return self
    }
    
}


public extension CaamDau where Base: UICollectionView {
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
    
    @discardableResult
    func register(_ model:[CD_View]) -> CaamDau {
        for (_, item) in model.enumerated() {
            switch item {
            case .tCell(let cellClass, let id, let from):
                let identifier = id ?? String(describing: cellClass)
                let bundleFrom = from ?? ""
                if bundleFrom.isEmpty {
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
                if bundleFrom.isEmpty {
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
        return self
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
