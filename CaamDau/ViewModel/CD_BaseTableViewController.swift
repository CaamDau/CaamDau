//Created  on 2019/5/5 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 *
 */



import Foundation
import UIKit
import SnapKit

public struct R_CDBaseTableViewController {
    public static func push(_ vm:CD_ViewModelTableViewProtocol) {
        let vc = CD_BaseTableViewController()
        vc.vm = vm
        CD.push(vc)
    }
}


class CD_BaseTableViewController: UIViewController {
    var vm:CD_ViewModelTableViewProtocol?
    var delegateData:CD_UITableViewDelegateData?
    lazy var tableView: UITableView = {
        return UITableView(frame: CGRect.zero, style: UITableView.Style.grouped).cd
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
        vm?._tableViewCustom?(tableView)
    }
    
    func makeUI(){
        self.cd.navigationBar(hidden: true)
        self.view.cd
            .add(tableView)
            .add(topBar)
        
        delegateData = CD_UITableViewDelegateData(vm)
        tableView.cd.delegate(delegateData).dataSource(delegateData)
        
    }
    
    func makeLayout(){
        topBar.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
        }
        
        tableView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(topBar.snp.bottom)
        }
    }
    
    func makeReloadData() {
        vm?._reloadData = {[weak self] in
            self?.tableView.reloadData()
            self?.tableView.cd.mjRefreshTypes(self!.vm?._mjRefreshType ?? [.tEnd])
        }
        
        vm?._reloadDataIndexPath = { [weak self] (indexPath, animation) in
            self?.tableView.reloadRows(at: indexPath, with: animation)
            self?.tableView.cd.mjRefreshTypes(self!.vm?._mjRefreshType ?? [.tEnd])
        }
        
        guard let refresh = vm?._mjRefresh else {
            return
        }
        
        if refresh.header {
            if refresh.headerGif {
                self.tableView.cd.headerMJGifWithModel({[weak self] in
                    self?.vm?.requestData(true)
                }, model: vm!._mjRefreshModel)
            }else{
                self.tableView.cd.headerMJWithModel({[weak self] in
                    self?.vm?.requestData(true)
                }, model: vm!._mjRefreshModel)
            }
        }
        if refresh.footer {
            if refresh.footerGif {
                self.tableView.cd.footerMJGifAutoWithModel({[weak self] in
                    self?.vm?.requestData(false)
                }, model: vm!._mjRefreshModel)
            }else{
                self.tableView.cd.footerMJAutoWithModel({[weak self] in
                    self?.vm?.requestData(false)
                }, model: vm!._mjRefreshModel)
            }
        }
        
        self.tableView.cd.mjRefreshTypes(vm!._mjRefreshType)
    }
    
}

extension CD_BaseTableViewController: CD_TopBarProtocol {
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
