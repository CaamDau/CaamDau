//Created  on 2018/12/13  by LCD :https://github.com/liucaide .

import Foundation
public extension CD where Base: UICollectionView {
    enum CD_Kind:Int {
        case header = 0
        case footer = 1
        var kindValue:String{
            switch self {
            case .header:
                return UICollectionElementKindSectionHeader
            default:
                return UICollectionElementKindSectionFooter
            }
        }
    }
    enum Cell_Model {
        case tClass(_ cell:AnyClass, _ id:String)
        case tXib1(_ id:String)
        case tXib2(_ name:String, _ id:String)
        case tViewClass(_ view:AnyClass, _ id:String, _ kind:String)
        case tViewXib1(_ id:String, _ kind:String)
        case tViewXib2(_ name:String,_ id:String, _ kind:String)
    }
    func cd_registerCells(_ identifiers:[Cell_Model]){
        for (_, model) in identifiers.enumerated() {
            switch model {
            case .tClass(let cell, let id):
                base.register(cell, forCellWithReuseIdentifier: id)
            case .tXib1(let id):
                base.register(UINib(nibName: id, bundle: nil), forCellWithReuseIdentifier: id)
            case .tXib2(let name, let id):
                base.register(UINib(nibName: name, bundle: nil), forCellWithReuseIdentifier: id)
            case .tViewClass(let view, let id, let kind):
                base.register(view, forSupplementaryViewOfKind: kind, withReuseIdentifier: id)
            case .tViewXib1(let id, let kind):
                base.register(UINib(nibName: id, bundle: nil), forSupplementaryViewOfKind: kind, withReuseIdentifier: id)
            case .tViewXib2(let name, let id, let kind):
                base.register(UINib(nibName: name, bundle: nil), forSupplementaryViewOfKind: kind, withReuseIdentifier: id)
            }
        }
    }
    func cell(_ id:String, _ index:IndexPath) -> UICollectionViewCell{
        return base.dequeueReusableCell(withReuseIdentifier: id, for: index)
    }
    func reusableView(_ id:String,_ kind:String, _ index:IndexPath) -> UICollectionReusableView{
        return base.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: id, for: index)
    }
}
