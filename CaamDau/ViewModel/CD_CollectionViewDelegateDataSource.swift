//Created  on 2019/7/12 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 *
 */




import Foundation
import UIKit
import SnapKit

//MARK:--- 针对新的表单协议 CD_CellProtocol ----------
public class CD_CollectionViewDelegateDataSource: NSObject {
    public var vm:CD_ViewModelCollectionViewProtocol?
    private override init(){}
    public init(_ vm:CD_ViewModelCollectionViewProtocol?) {
        self.vm = vm
    }
}

extension CD_CollectionViewDelegateDataSource: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return vm?._forms.count ?? 0
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return vm?._forms[section].count ?? 0
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return vm?._forms[indexPath.section][indexPath.row].size ?? .zero
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let row = vm?._forms[indexPath.section][indexPath.row] else {
            return collectionView.cd.cell(CD_CollectionViewCellNone.id, indexPath)
        }
        let cell = collectionView.cd.cell(row.cellId, indexPath)
        row.bind(cell)
        return cell
    }
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let row = vm?._forms[indexPath.section][indexPath.row] else {
            return
        }
        row.tapBlock?()
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if let count = vm?._formHeaders.count, count > section {
            return vm!._formHeaders[section].y
        }else{
            return vm?._forms[section].first?.y ?? 0
        }
        
    }
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if let count = vm?._formHeaders.count, count > section {
            return vm!._formHeaders[section].x
        }else{
            return vm?._forms[section].first?.x ?? 0
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if let count = vm?._formHeaders.count, count > section {
            return vm!._formHeaders[section].insets
        }else{
            return vm?._forms[section].first?.insets ?? .zero
        }
    }
    
    
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize{
        if let count = vm?._formHeaders.count, count > section {
            return vm!._formHeaders[section].size
        }else{
            return .zero
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize{
        if let count = vm?._formFooters.count, count > section {
            return vm!._formFooters[section].size
        }else{
            return .zero
        }
    }
    
    
    public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case CaamDau<UICollectionView>.Kind.tHeader.stringValue:
            guard let count = vm?._formHeaders.count, count > indexPath.section, let row = vm?._formHeaders[indexPath.section] else {
                return collectionView.cd.view(CD_CollectionReusableViewNone.id, kind, indexPath)
            }
            let v = collectionView.cd.view(row.cellId, kind, indexPath)
            row.bind(v)
            return v
        default:
            guard let count = vm?._formFooters.count, count > indexPath.section, let row = vm?._formFooters[indexPath.section] else {
                return collectionView.cd.view(CD_CollectionReusableViewNone.id, kind, indexPath)
            }
            let v = collectionView.cd.view(row.cellId, kind, indexPath)
            row.bind(v)
            return v
        }
    }
}






//MARK:--- 提供一个基础的 CollectionViewController 简单的页面不需要编写 ViewController----------
public struct R_CDCollectionViewController {
    public static func push(_ vm:CD_ViewModelCollectionViewProtocol) {
        let vc = CD_CollectionViewController()
        vc.vm = vm
        CD.push(vc)
    }
}

class CD_CollectionViewController: UIViewController {
    var vm:CD_ViewModelCollectionViewProtocol?
    var delegateData: CD_CollectionViewDelegateDataSource?
    lazy var collectionView: UICollectionView = {
        return UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init()).cd
            .register([.tCell(CD_CollectionViewCellNone.self, nil, nil),
                       .tView(CD_CollectionReusableViewNone.self, nil, .tHeader, nil),
                       .tView(CD_CollectionReusableViewNone.self, nil, .tFooter, nil)])
            .register(vm?._collectionRegisters ?? [])
            .background(UIColor.lightGray)
            .build
    }()
    lazy var topBar: CD_TopBar = {
        return CD_TopBar()
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        makeUI()
        makeLayout()
        makeReloadData()
        topBar.delegate = self
        vm?._collectionViewCustom?(collectionView)
    }
    
    func makeUI(){
        self.cd.navigationBar(hidden: true)
        self.view.cd
            .add(collectionView)
            .add(topBar)
        
        delegateData = CD_CollectionViewDelegateDataSource(vm)
        collectionView.cd.delegate(delegateData).dataSource(delegateData)
        
    }
    
    func makeLayout(){
        topBar.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(topBar.snp.bottom)
            guard let safeArea = vm?._safeAreaLayout, safeArea else {
                make.bottom.equalToSuperview()
                return
            }
            if #available(iOS 11.0, *) {
                make.bottom.equalToSuperview()
                //make.left.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
            } else {
                make.bottom.equalToSuperview()
                //make.left.bottom.equalTo(bottomLayoutGuide.snp.bottom)
            }
        }
    }
    
    func makeReloadData() {
        vm?._reloadData = {[weak self] in
            self?.collectionView.reloadData()
            self?.collectionView.cd.mjRefreshTypes(self!.vm?._mjRefreshType ?? [.tEnd])
        }
        
        vm?._reloadDataIndexPath = { [weak self] (indexPath, animation) in
            self?.collectionView.reloadItems(at: indexPath)
            self?.collectionView.cd.mjRefreshTypes(self!.vm?._mjRefreshType ?? [.tEnd])
        }
        
        guard let refresh = vm?._mjRefresh else {
            return
        }
        
        if refresh.header {
            if refresh.headerGif {
                self.collectionView.cd.headerMJGifWithModel({[weak self] in
                    self?.vm?.requestData(true)
                    }, model: vm!._mjRefreshModel)
            }else{
                self.collectionView.cd.headerMJWithModel({[weak self] in
                    self?.vm?.requestData(true)
                    }, model: vm!._mjRefreshModel)
            }
        }
        if refresh.footer {
            if refresh.footerGif {
                self.collectionView.cd.footerMJGifAutoWithModel({[weak self] in
                    self?.vm?.requestData(false)
                    }, model: vm!._mjRefreshModel)
            }else{
                self.collectionView.cd.footerMJAutoWithModel({[weak self] in
                    self?.vm?.requestData(false)
                    }, model: vm!._mjRefreshModel)
            }
        }
        
        self.collectionView.cd.mjRefreshTypes(vm!._mjRefreshType)
    }
    
}

extension CD_CollectionViewController: CD_TopBarProtocol {
    func topBarCustom() {
        vm?._topBarCustom?(self.topBar)
    }
    
    func didSelect(withTopBar item: CD_TopNavigationBar.Item) {
        //super_topBarClick(item)
        vm?._topBarDidSelect?(self.topBar, item)
    }
    
    func update(withTopBar item: CD_TopNavigationBar.Item) -> [CD_TopNavigationBarItem.Item.Style]? {
        return vm?._topBarUpdate?(self.topBar, item)
    }
}
