//Created  on 2019/2/28 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 *
 */

import Foundation
import UIKit

public extension CD where Base: UICollectionView {
    enum CD_Kind:Int {
        case tHeader = 0
        case tFooter = 1
        
        var stringValue:String{
            switch self {
            case .tHeader:
                return UICollectionView.elementKindSectionHeader
            default:
                return UICollectionView.elementKindSectionFooter
            }
        }
    }
    enum CD_View {
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
    
    
    
    @discardableResult
    func background(view v: UIView?) -> CD {
        base.backgroundView = v
        return self
    }
    
    @discardableResult
    func layout(_ l: UICollectionViewLayout) -> CD {
        base.collectionViewLayout = l
        return self
    }
    
    @discardableResult
    func dataSource(_ d: UICollectionViewDataSource?) -> CD {
        base.dataSource = d
        return self
    }
    
    @discardableResult
    func delegate(_ d: UICollectionViewDelegate?) -> CD {
        base.delegate = d
        return self
    }
    
    @discardableResult
    func prefetch(dataSource d: UICollectionViewDataSourcePrefetching?) -> CD {
        base.prefetchDataSource = d
        return self
    }
    
    @discardableResult
    func isPrefetching(enabled e: Bool) -> CD {
        base.isPrefetchingEnabled = e
        return self
    }
    
}
