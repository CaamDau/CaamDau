//Created  on 2018/12/13  by LCD :https://github.com/liucaide .

/***** 模块文档 *****
*  Form 数据代理类
* 将 TableView CollectionView 的 Delegate DataSource 设置为 CD_FormDelegateDataSource
 可实现Form模板化，无需 编写 Delegate DataSource 代码，
 特殊需求 可继承CD_FormDelegateDataSource，重写 Delegate DataSource 方法
 
*/


import Foundation
import UIKit

open class CD_FormDelegateDataSource: NSObject {
    open var form: CD_FormProtocol?
    private override init(){}
    public init(_ form:CD_FormProtocol?) {
        self.form = form
    }
}


//MARK:--- TableView DelegateDataSource ----------
open class CD_FormTableViewDelegateDataSource: CD_FormDelegateDataSource {
    
}

extension CD_FormTableViewDelegateDataSource {
    @objc open func makeReloadData(_ tableView:UITableView) {
        form?._reloadData = {[weak tableView, weak self] in
            tableView?.reloadData()
            //tableView?.backgroundView = self?.form?._emptyView?(tableView) ?? nil
        }
        form?._reloadRows = { [weak tableView, weak self] (indexPath, animation) in
            tableView?.reloadRows(at: indexPath, with: animation)
            //tableView?.backgroundView = self?.form?._emptyView?(tableView) ?? nil
            
        }
        form?._reloadSections = { [weak tableView, weak self] (sections, animation) in
            tableView?.reloadSections(sections, with: animation)
            //tableView?.backgroundView = self?.form?._emptyView?(tableView) ?? nil
        }
    }
}

extension CD_FormTableViewDelegateDataSource: UITableViewDelegate, UITableViewDataSource  {
    open func numberOfSections(in tableView: UITableView) -> Int {
        return form?._forms.count ?? 0
    }
    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return form?._forms[section].count ?? 0
    }
    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let row = form?._forms[indexPath.section][indexPath.row] else {
            return UITableViewCell()
        }
        let cell = tableView.cd.cell(row.cellClass, id:row.cellId, bundleFrom:row.bundleFrom ?? "") ?? UITableViewCell()
        row.bind(cell)
        return cell
    }
    open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let row = form?._forms[indexPath.section][indexPath.row] else {
            return
        }
        row.tapBlock?()
    }
    open func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let row = form?._forms[indexPath.section][indexPath.row] else {
            return 0
        }
        return row.h
    }
    open func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section < (form?._formHeaders.count ?? 0) {
            return form?._formHeaders[section].h ?? CD.sectionMinH
        }else{
            guard let count = form?._forms[section].count, count > 0, let top = form?._forms[section].first?.insets.top, top > 0 else {
                return CD.sectionMinH
            }
            return top
        }
    }
    open func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section < (form?._formFooters.count ?? 0) {
            return form?._formFooters[section].h ?? CD.sectionMinH
        }else{
            guard let count = form?._forms[section].count, count > 0, let bottom = form?._forms[section].first?.insets.bottom, bottom > 0 else {
                return CD.sectionMinH
            }
            return bottom
        }
    }
    open func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard section < (form?._formHeaders.count ?? 0) else {
            return nil
        }
        guard let row = form?._formHeaders[section] else {
            return nil
        }
        guard let v = tableView.cd.view(row.cellClass, id:row.cellId, bundleFrom:row.bundleFrom ?? "") else {
            return nil
        }
        row.bind(v)
        return v
    }
    open func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard section < (form?._formFooters.count ?? 0) else {
            return nil
        }
        guard let row = form?._formFooters[section] else {
            return nil
        }
        guard let v = tableView.cd.view(row.cellClass, id:row.cellId, bundleFrom:row.bundleFrom ?? "") else {
            return nil
        }
        row.bind(v)
        return v
    }
}




//MARK:--- CollectionView DelegateDataSource ----------
open class CD_FormCollectionViewDelegateDataSource: CD_FormDelegateDataSource {
    
}
extension CD_FormCollectionViewDelegateDataSource {
    @objc open func makeReloadData(_ collectionView:UICollectionView) {
        form?._reloadData = {[weak collectionView, weak self] in
            collectionView?.reloadData()
        }
        
        form?._reloadRows = { [weak collectionView, weak self] (indexPath, animation) in
            collectionView?.reloadItems(at: indexPath)
        }
        
        form?._reloadSections = { [weak collectionView, weak self] (sections, animation) in
            collectionView?.reloadSections(sections)
        }
    }
}

extension CD_FormCollectionViewDelegateDataSource: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    open func numberOfSections(in collectionView: UICollectionView) -> Int {
        return form?._forms.count ?? 0
    }
    
    open func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return form?._forms[section].count ?? 0
    }
    
    open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return form?._forms[indexPath.section][indexPath.row].size ?? .zero
    }
    
    open func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let row = form?._forms[indexPath.section][indexPath.row] else {
            return collectionView.cd.cell(CD_CollectionViewCellNone.id, indexPath)
        }
        let cell = collectionView.cd.cell(row.cellId, indexPath)
        row.bind(cell)
        return cell
    }
    open func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let row = form?._forms[indexPath.section][indexPath.row] else {
            return
        }
        row.tapBlock?()
    }
    
    open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if let count = form?._formHeaders.count, count > section {
            return form!._formHeaders[section].y
        }else{
            return form?._forms[section].first?.y ?? 0
        }
        
    }
    open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if let count = form?._formHeaders.count, count > section {
            return form!._formHeaders[section].x
        }else{
            return form?._forms[section].first?.x ?? 0
        }
    }
    
    open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if let count = form?._formHeaders.count, count > section {
            return form!._formHeaders[section].insets
        }
        else if let count = form?._formFooters.count, count > section {
            return form!._formFooters[section].insets
        }
        else{
            return form?._forms[section].first?.insets ?? .zero
        }
    }
    
    
    
    open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize{
        if let count = form?._formHeaders.count, count > section {
            return form!._formHeaders[section].size
        }else{
            return .zero
        }
    }
    
    open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize{
        if let count = form?._formFooters.count, count > section {
            return form!._formFooters[section].size
        }else{
            return .zero
        }
    }
    
    
    open func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case CaamDau<UICollectionView>.Kind.tHeader.stringValue:
            guard let count = form?._formHeaders.count, count > indexPath.section, let row = form?._formHeaders[indexPath.section] else {
                return collectionView.cd.view(CD_CollectionReusableViewNone.id, kind, indexPath)
            }
            let v = collectionView.cd.view(row.cellId, kind, indexPath)
            row.bind(v)
            return v
        default:
            guard let count = form?._formFooters.count, count > indexPath.section, let row = form?._formFooters[indexPath.section] else {
                return collectionView.cd.view(CD_CollectionReusableViewNone.id, kind, indexPath)
            }
            let v = collectionView.cd.view(row.cellId, kind, indexPath)
            row.bind(v)
            return v
        }
    }
}



