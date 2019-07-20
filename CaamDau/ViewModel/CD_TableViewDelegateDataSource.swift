//Created  on 2019/7/12 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 *
 */




import Foundation
import UIKit
import SnapKit

//MARK:--- 针对新的表单协议 CD_CellProtocol ----------
public class CD_TableViewDelegateDataSource: NSObject {
    public var vm:CD_ViewModelTableViewProtocol?
    private override init(){}
    public init(_ vm:CD_ViewModelTableViewProtocol?) {
        self.vm = vm
    }
}
extension CD_TableViewDelegateDataSource: UITableViewDelegate, UITableViewDataSource {
    public func numberOfSections(in tableView: UITableView) -> Int {
        return vm?._forms.count ?? 0
    }
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm?._forms[section].count ?? 0
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let row = vm?._forms[indexPath.section][indexPath.row] else {
            return UITableViewCell()
        }
        let cell = tableView.cd.cell(row.cellClass, id:row.cellId, bundleFrom:row.bundleFrom ?? "") ?? UITableViewCell()
        row.bind(cell)
        return cell
    }
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let row = vm?._forms[indexPath.section][indexPath.row] else {
            return
        }
        row.tapBlock?()
    }
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let row = vm?._forms[indexPath.section][indexPath.row] else {
            return 0
        }
        return row.h
    }
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section < (vm?._formHeaders.count ?? 0) {
            return vm?._formHeaders[section].h ?? CD.sectionMinH
        }else{
            guard let count = vm?._forms[section].count, count > 0, let top = vm?._forms[section].first?.insets.top, top > 0 else {
                return CD.sectionMinH
            }
            return top
        }
    }
    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section < (vm?._formFooters.count ?? 0) {
            return vm?._formFooters[section].h ?? CD.sectionMinH
        }else{
            guard let count = vm?._forms[section].count, count > 0, let bottom = vm?._forms[section].first?.insets.bottom, bottom > 0 else {
                return CD.sectionMinH
            }
            return bottom
        }
    }
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard section < (vm?._formHeaders.count ?? 0) else {
            return nil
        }
        guard let row = vm?._formHeaders[section] else {
            return nil
        }
        guard let v = tableView.cd.view(row.cellClass, id:row.cellId, bundleFrom:row.bundleFrom ?? "") else {
            return nil
        }
        row.bind(v)
        return v
    }
    public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard section < (vm?._formFooters.count ?? 0) else {
            return nil
        }
        guard let row = vm?._formFooters[section] else {
            return nil
        }
        guard let v = tableView.cd.view(row.cellClass, id:row.cellId, bundleFrom:row.bundleFrom ?? "") else {
            return nil
        }
        row.bind(v)
        return v
    }
}


//MARK:--- 提供一个基础的 TableViewController 简单的页面不需要编写 ViewController----------
public struct R_CDTableViewController {
    public static func push(_ vm:CD_ViewModelTableViewProtocol) {
        let vc = CD_TableViewController()
        vc.vm = vm
        CD.push(vc)
    }
}


class CD_TableViewController: UIViewController {
    var vm:CD_ViewModelTableViewProtocol?
    var delegateData:CD_TableViewDelegateDataSource?
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
        
        delegateData = CD_TableViewDelegateDataSource(vm)
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

extension CD_TableViewController: CD_TopBarProtocol {
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
