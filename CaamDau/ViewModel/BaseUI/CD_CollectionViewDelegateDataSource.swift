//Created  on 2019/7/12 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 *
 */




import Foundation
import UIKit
import SnapKit

//MARK:--- 针对新的表单协议 CD_CellProtocol ----------
open class CD_CollectionViewDelegateDataSource: CD_FormCollectionViewDelegateDataSource {
    public var vm:CD_ViewModelCollectionViewProtocol?
    public init(_ vm:CD_ViewModelCollectionViewProtocol?) {
        super.init(vm)
        self.vm = vm
    }
    
    
    open override func makeReloadData(_ collectionView:UICollectionView) {
        vm?._reloadData = {[weak collectionView, weak self] in
            collectionView?.reloadData()
            collectionView?.cd.mjRefreshTypes(self?.vm?._mjRefreshType ?? [.tEnd])
            collectionView?.backgroundView = self?.vm?._emptyView?(collectionView) ?? nil
        }
        
        vm?._reloadRows = { [weak collectionView, weak self] (indexPath, animation) in
            collectionView?.reloadItems(at: indexPath)
            collectionView?.cd.mjRefreshTypes(self?.vm?._mjRefreshType ?? [.tEnd])
            collectionView?.backgroundView = self?.vm?._emptyView?(collectionView) ?? nil
        }
        
        vm?._reloadSections = { [weak collectionView, weak self] (sections, animation) in
            collectionView?.reloadSections(sections)
            collectionView?.cd.mjRefreshTypes(self?.vm?._mjRefreshType ?? [.tEnd])
            collectionView?.backgroundView = self?.vm?._emptyView?(collectionView) ?? nil
        }
        collectionView.backgroundView = self.vm?._emptyView?(collectionView) ?? nil
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



//MARK:--- 提供一个基础的 CollectionViewController 简单的页面不需要编写 ViewController----------
public struct R_CDCollectionViewController {
    public static func push(_ vm:CD_ViewModelCollectionViewProtocol) {
        let vc = CD_CollectionViewController()
        vc.vm = vm
        vc.safeAreaTop = false
        vc.safeAreaBottom = true
        CD.push(vc)
    }
}

open class CD_CollectionViewController: CD_FormCollectionViewController {
    open var vm:CD_ViewModelCollectionViewProtocol?
    open var delegateData: CD_CollectionViewDelegateDataSource?
    open lazy var topBar: CD_TopBar = {
        return CD_TopBar()
    }()
    open lazy var bottomBar: UIView = {
        let v = UIView()
        v.clipsToBounds = true
        return v
    }()
    
    
    open override var _form: CD_FormProtocol? {
        set{
            
        }
        get{
            return vm
        }
    }
    
    open override var _delegateData: CD_FormCollectionViewDelegateDataSource? {
        set{}
        get{
            return delegateData
        }
    }
    override open func viewDidLoad() {
        super.viewDidLoad()
        makeLayout()
        topBar.delegate = self
        vm?._collectionViewCustom?(collectionView)
        vm?._bottomBarCustom?(bottomBar)
    }
    override open func makeCollectionView() {
        delegateData = CD_CollectionViewDelegateDataSource(vm)
        collectionView.cd
            .register(
                [.tCell(CD_CollectionViewCellNone.self, nil, nil),
                .tView(CD_CollectionReusableViewNone.self, nil, .tHeader, nil),
                .tView(CD_CollectionReusableViewNone.self, nil, .tFooter, nil)
                ]
        )
            .register(vm?._collectionRegisters ?? [])
            .background(UIColor.cd_hex("f", dark: "0"))
        super.makeCollectionView()
        self.cd.navigationBar(hidden: true)
        self.stackView.insertArrangedSubview(topBar, at: 0)
        self.stackView.addArrangedSubview(bottomBar)
    }
    
    open func makeLayout(){
        bottomBar.snp.makeConstraints {
            $0.height.equalTo(vm?._bottomBarHeignt ?? 0)
        }
    }
}

extension CD_CollectionViewController: CD_TopBarProtocol {
    
    open func topBar(custom topBar: CD_TopBar) {
        vm?._topBarCustom?(topBar)
    }
    open func topBar(_ topBar: CD_TopBar, didSelectAt item: CD_TopNavigationBar.Item) {
        vm?._topBarDidSelect?(topBar, item)
    }
    open func topBar(_ topBar: CD_TopBar, updateItemStyleForItem item: CD_TopNavigationBar.Item) -> [CD_TopNavigationBarItem.Item.Style]? {
        return vm?._topBarUpdate?(topBar, item)
    }
}
