//Created  on 2019/7/12 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 * 针对旧的表单协议 CD_RowProtocol, 建议使用新的，但旧的依然可用，但计划在正式版本1.0中删除
 */




import Foundation
import UIKit
import SnapKit

//MARK:--- 针对旧的表单协议 CD_RowProtocol，但计划在正式版本1.0中删除 ----------
/// 使用旧的 协议，弃用
@available(*, deprecated, message: "旧的，弃用")
open class CD_UICollectionViewDelegateData: NSObject {
    public var vm:CD_ViewModelCollectionViewProtocol?
    private override init(){}
    public init(_ vm:CD_ViewModelCollectionViewProtocol?) {
        self.vm = vm
    }
}

extension CD_UICollectionViewDelegateData {
    /// 使用旧的 协议，弃用
    @available(*, deprecated, message: "旧的，弃用")
    open func makeReloadData(_ collectionView:UICollectionView) {
        vm?._reloadData = {[weak self, weak collectionView] in
            collectionView?.reloadData()
            collectionView?.cd.mjRefreshTypes(self?.vm?._mjRefreshType ?? [.tEnd])
        }
        
        vm?._reloadRows = { [weak self, weak collectionView] (indexPath, animation) in
            collectionView?.reloadItems(at: indexPath)
            collectionView?.cd.mjRefreshTypes(self?.vm?._mjRefreshType ?? [.tEnd])
        }
        
        vm?._reloadSections = { [weak collectionView, weak self] (sections, animation) in
            collectionView?.reloadSections(sections)
            collectionView?.cd.mjRefreshTypes(self?.vm?._mjRefreshType ?? [.tEnd])
        }
        
        guard let refresh = vm?._mjRefresh else {
            return
        }
        
        if refresh.header {
            if refresh.headerGif {
                collectionView.cd.headerMJGifWithModel({[weak self] in
                    self?.vm?.requestData(true)
                    }, model: vm!._mjRefreshModel)
            }else{
                collectionView.cd.headerMJWithModel({[weak self] in
                    self?.vm?.requestData(true)
                    }, model: vm!._mjRefreshModel)
            }
        }
        if refresh.footer {
            if refresh.footerGif {
                collectionView.cd.footerMJGifAutoWithModel({[weak self] in
                    self?.vm?.requestData(false)
                    }, model: vm!._mjRefreshModel)
            }else{
                collectionView.cd.footerMJAutoWithModel({[weak self] in
                    self?.vm?.requestData(false)
                    }, model: vm!._mjRefreshModel)
            }
        }
        
        collectionView.cd.mjRefreshTypes(vm!._mjRefreshType)
    }
}
extension CD_UICollectionViewDelegateData: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    open func numberOfSections(in collectionView: UICollectionView) -> Int {
        return vm?._form.count ?? 0
    }
    
    open func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return vm?._form[section].count ?? 0
    }
    
    open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return vm?._form[indexPath.section][indexPath.row].size ?? .zero
    }
    
    open func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let row = vm?._form[indexPath.section][indexPath.row] else {
            return collectionView.cd.cell(CD_CollectionViewCellNone.id, indexPath)
        }
        let cell = collectionView.cd.cell(row.viewId, indexPath)
        row.bind(cell)
        return cell
    }
    open func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let row = vm?._form[indexPath.section][indexPath.row] else {
            return
        }
        row.didSelect?()
    }
    
    open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if let count = vm?._formHeader.count, count > section {
            return vm!._formHeader[section].y
        }else{
            return vm?._form[section].first?.y ?? 0
        }
        
    }
    open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if let count = vm?._formHeader.count, count > section {
            return vm!._formHeader[section].x
        }else{
            return vm?._form[section].first?.x ?? 0
        }
    }
    
    open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if let count = vm?._formHeader.count, count > section {
            return vm!._formHeader[section].insets
        }else{
            return vm?._form[section].first?.insets ?? .zero
        }
    }
    
    
    
    open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize{
        if let count = vm?._formHeader.count, count > section {
            return vm!._formHeader[section].size
        }else{
            return .zero
        }
    }
    
    open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize{
        if let count = vm?._formFooter.count, count > section {
            return vm!._formFooter[section].size
        }else{
            return .zero
        }
    }
    
    
    open func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case CaamDau<UICollectionView>.Kind.tHeader.stringValue:
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


//MARK:--- 提供一个基础的 CollectionViewController 简单的页面不需要编写 ViewController----------
/// 使用旧的 协议，弃用
@available(*, deprecated, message: "旧的，弃用")
public struct R_CDBaseCollectionViewController {
    public static func push(_ vm:CD_ViewModelCollectionViewProtocol) {
        let vc = CD_BaseCollectionViewController()
        vc.vm = vm
        CD.push(vc)
    }
}
/// 使用旧的 协议，弃用
@available(*, deprecated, message: "旧的，弃用")
class CD_BaseCollectionViewController: CD_FormCollectionViewController {
    open var vm:CD_ViewModelCollectionViewProtocol?
    open var delegateData: CD_UICollectionViewDelegateData?
    
    open lazy var topBar: CD_TopBar = {
        return CD_TopBar()
    }()
    open lazy var bottomBar: UIView = {
        let v = UIView()
        v.clipsToBounds = true
        return v
    }()
    
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        makeLayout()
        
        delegateData = CD_UICollectionViewDelegateData(vm)
        delegateData?.makeReloadData(collectionView)
        collectionView.cd
            .register(
                [.tCell(CD_CollectionViewCellNone.self, nil, nil),
                .tView(CD_CollectionReusableViewNone.self, nil, .tHeader, nil),
                .tView(CD_CollectionReusableViewNone.self, nil, .tFooter, nil)
                ]
        )
            .register(vm?._collectionRegisters ?? [])
            .background(UIColor.cd_hex("f", dark: "0"))
            .delegate(delegateData)
            .dataSource(delegateData)
        topBar.delegate = self
        vm?._collectionViewCustom?(collectionView)
        vm?._bottomBarCustom?(bottomBar)
    }
    override open func makeCollectionView() {
        self.cd.navigationBar(hidden: true)
        stackView.addArrangedSubview(collectionView)
        self.stackView.insertArrangedSubview(topBar, at: 0)
        self.stackView.addArrangedSubview(bottomBar)
    }
    open func makeLayout(){
        bottomBar.snp.makeConstraints {
            $0.height.equalTo(vm?._bottomBarHeignt ?? 0)
        }
    }
}

extension CD_BaseCollectionViewController: CD_TopBarProtocol {
    open func topBarCustom() {
        vm?._topBarCustom?(self.topBar)
    }
    
    open func didSelect(withTopBar item: CD_TopNavigationBar.Item) {
        //super_topBarClick(item)
        vm?._topBarDidSelect?(self.topBar, item)
    }
    
    open func update(withTopBar item: CD_TopNavigationBar.Item) -> [CD_TopNavigationBarItem.Item.Style]? {
        return vm?._topBarUpdate?(self.topBar, item)
    }
}
