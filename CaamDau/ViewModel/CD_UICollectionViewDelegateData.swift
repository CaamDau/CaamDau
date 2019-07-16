//Created  on 2019/7/12 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 *
 */




import Foundation

public class CD_UICollectionViewDelegateData: NSObject {
    public var vm:CD_ViewModelCollectionViewProtocol?
    private override init(){}
    public init(_ vm:CD_ViewModelCollectionViewProtocol?) {
        self.vm = vm
    }
}

extension CD_UICollectionViewDelegateData: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return vm?._form.count ?? 0
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return vm?._form[section].count ?? 0
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return vm?._form[indexPath.section][indexPath.row].size ?? .zero
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let row = vm?._form[indexPath.section][indexPath.row] else {
            return collectionView.cd.cell(CD_CollectionViewCellNone.id, indexPath)
        }
        let cell = collectionView.cd.cell(row.viewId, indexPath)
        row.bind(cell)
        return cell
    }
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let row = vm?._form[indexPath.section][indexPath.row] else {
            return
        }
        row.didSelect?()
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if let count = vm?._formHeader.count, count > section {
            return vm!._formHeader[section].y
        }else{
            return vm?._form[section].first?.y ?? 0
        }
        
    }
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if let count = vm?._formHeader.count, count > section {
            return vm!._formHeader[section].x
        }else{
            return vm?._form[section].first?.x ?? 0
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if let count = vm?._formHeader.count, count > section {
            return vm!._formHeader[section].insets
        }else{
            return vm?._form[section].first?.insets ?? .zero
        }
    }
    
    
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize{
        if let count = vm?._formHeader.count, count > section {
            return vm!._formHeader[section].size
        }else{
            return .zero
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize{
        if let count = vm?._formFooter.count, count > section {
            return vm!._formFooter[section].size
        }else{
            return .zero
        }
    }
    
    
    public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case CaamDau<UICollectionView>.CD_Kind.tHeader.stringValue:
            guard let count = vm?._formHeader.count, count > indexPath.section, let row = vm?._formHeader[indexPath.section] else {
                return collectionView.cd.view(CD_CollectionReusableViewNone.id, kind, indexPath)
            }
            let v = collectionView.cd.view(row.viewId, kind, indexPath)
            row.bind(v)
            return v
        default:
            guard let count = vm?._formFooter.count, count > indexPath.section, let row = vm?._formFooter[indexPath.section] else {
                return collectionView.cd.view(CD_CollectionReusableViewNone.id, kind, indexPath)
            }
            let v = collectionView.cd.view(row.viewId, kind, indexPath)
            row.bind(v)
            return v
        }
    }
}
