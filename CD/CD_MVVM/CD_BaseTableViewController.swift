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
        cd_push(vc)
    }
}


class CD_BaseTableViewController: UIViewController {
    var vm:CD_ViewModelTableViewProtocol?
    lazy var tableView: UITableView = {
        return UITableView(frame: CGRect.zero, style: UITableView.Style.grouped).cd
            .delegate(self)
            .dataSource(self)
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

extension CD_BaseTableViewController: UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return vm?._form.count ?? 0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm?._form[section].count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let row = vm?._form[indexPath.section][indexPath.row] else {
            return UITableViewCell()
        }
        let cell = tableView.cd.cell(row.viewClass) ?? UITableViewCell()
        row.bind(cell)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let row = vm?._form[indexPath.section][indexPath.row] else {
            return
        }
        row.didSelect?()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let row = vm?._form[indexPath.section][indexPath.row] else {
            return 0
        }
        return row.h
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section < (vm?._formHeader.count ?? 0) {
            return vm?._formHeader[section].h ?? cd_sectionMinH()
        }else{
            guard let count = vm?._form[section].count, count > 0, let top = vm?._form[section].first?.insets.top, top > 0 else {
                return cd_sectionMinH()
            }
            return top
        }
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section < (vm?._formFooter.count ?? 0) {
            return vm?._formFooter[section].h ?? cd_sectionMinH()
        }else{
            guard let count = vm?._form[section].count, count > 0, let bottom = vm?._form[section].first?.insets.bottom, bottom > 0 else {
                return cd_sectionMinH()
            }
            return bottom
        }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard section < (vm?._formHeader.count ?? 0) else {
            return nil
        }
        guard let row = vm?._formHeader[section] else {
            return nil
        }
        guard let v = tableView.cd.view(row.viewClass) else {
            return nil
        }
        row.bind(v)
        return v
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard section < (vm?._formFooter.count ?? 0) else {
            return nil
        }
        guard let row = vm?._formFooter[section] else {
            return nil
        }
        guard let v = tableView.cd.view(row.viewClass) else {
            return nil
        }
        row.bind(v)
        return v
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
