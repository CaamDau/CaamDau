//Created  on 2019/7/12 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 *
 */




import Foundation
import UIKit
import SnapKit

//MARK:--- 针对新的表单协议 CD_CellProtocol ----------
open class CD_TableViewDelegateDataSource: CD_FormTableViewDelegateDataSource {
    public var vm:CD_ViewModelTableViewProtocol?
    public init(_ vm:CD_ViewModelTableViewProtocol?) {
        super.init(vm)
        self.vm = vm
    }
    
    open override func makeReloadData(_ tableView:UITableView) {
        vm?._reloadData = {[weak self, weak tableView] in
            tableView?.reloadData()
            tableView?.cd.mjRefreshTypes(self?.vm?._mjRefreshType ?? [.tEnd])
            tableView?.backgroundView = self?.vm?._emptyView?(tableView) ?? nil
        }
        
        vm?._reloadRows = { [weak self, weak tableView] (indexPath, animation) in
            tableView?.reloadRows(at: indexPath, with: animation)
            tableView?.cd.mjRefreshTypes(self?.vm?._mjRefreshType ?? [.tEnd])
            tableView?.backgroundView = self?.vm?._emptyView?(tableView) ?? nil
        }
        
        vm?._reloadSections = { [weak self, weak tableView] (sections, animation) in
            tableView?.reloadSections(sections, with: animation)
            tableView?.cd.mjRefreshTypes(self?.vm?._mjRefreshType ?? [.tEnd])
            tableView?.backgroundView = self?.vm?._emptyView?(tableView) ?? nil
        }
        tableView.backgroundView = self.vm?._emptyView?(tableView) ?? nil
        guard let refresh = vm?._mjRefresh else {
            return
        }
        
        if refresh.header {
            if refresh.headerGif {
                tableView.cd.headerMJGifWithModel({[weak self] in
                    self?.vm?.requestData(true)
                    }, model: vm!._mjRefreshModel)
            }else{
                tableView.cd.headerMJWithModel({[weak self] in
                    self?.vm?.requestData(true)
                    }, model: vm!._mjRefreshModel)
            }
        }
        if refresh.footer {
            if refresh.footerGif {
                tableView.cd.footerMJGifAutoWithModel({[weak self] in
                    self?.vm?.requestData(false)
                    }, model: vm!._mjRefreshModel)
            }else{
                tableView.cd.footerMJAutoWithModel({[weak self] in
                    self?.vm?.requestData(false)
                    }, model: vm!._mjRefreshModel)
            }
        }
        
        tableView.cd.mjRefreshTypes(vm!._mjRefreshType)
    }
}



//MARK:--- 提供一个基础的 TableViewController 简单的页面不需要编写 ViewController----------
public struct R_CDTableViewController {
    public static func push(_ vm:CD_ViewModelTableViewProtocol) {
        let vc = CD_TableViewController()
        vc.vm = vm
        //vc.safeAreaTop = false
        //vc.safeAreaBottom = true
        CD.push(vc)
    }
}

open class CD_TableViewController: CD_FormTableViewController {
    open var vm:CD_ViewModelTableViewProtocol?
    open var delegateData:CD_TableViewDelegateDataSource?
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
    
    open override var _delegateData: CD_FormTableViewDelegateDataSource? {
        set{}
        get{
            return delegateData
        }
    }
    override open func viewDidLoad() {
        super.viewDidLoad()
        makeLayout()
        topBar.delegate = self
        vm?._tableViewCustom?(tableView)
        vm?._bottomBarCustom?(bottomBar)
    }
    override open func makeTableView() {
        delegateData = CD_TableViewDelegateDataSource(vm)
        super.makeTableView()
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

extension CD_TableViewController: CD_TopBarProtocol {
    open func topBarCustom() {
        vm?._topBarCustom?(self.topBar)
    }
    
    open func didSelect(withTopBar item: CD_TopNavigationBar.Item) {
        vm?._topBarDidSelect?(self.topBar, item)
    }
    
    open func update(withTopBar item: CD_TopNavigationBar.Item) -> [CD_TopNavigationBarItem.Item.Style]? {
        return vm?._topBarUpdate?(self.topBar, item)
    }
}


