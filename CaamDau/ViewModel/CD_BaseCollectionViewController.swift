//Created  on 2019/5/5 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 *
 */




import UIKit

public struct R_CDBaseCollectionViewController {
    public static func push(_ vm:CD_ViewModelCollectionViewProtocol) {
        let vc = CD_BaseCollectionViewController()
        vc.vm = vm
        CD.push(vc)
    }
}

class CD_BaseCollectionViewController: UIViewController {
    var vm:CD_ViewModelCollectionViewProtocol?
    var delegateData: CD_UICollectionViewDelegateData?
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
        
        delegateData = CD_UICollectionViewDelegateData(vm)
        collectionView.cd.delegate(delegateData).dataSource(delegateData)
        
    }
    
    func makeLayout(){
        topBar.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(topBar.snp.bottom)
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

extension CD_BaseCollectionViewController: CD_TopBarProtocol {
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
