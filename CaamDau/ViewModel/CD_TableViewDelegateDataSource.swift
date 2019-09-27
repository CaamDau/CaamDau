//Created  on 2019/7/12 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 *
 */




import Foundation
import UIKit
import SnapKit

//MARK:--- 针对新的表单协议 CD_CellProtocol ----------
open class CD_TableViewDelegateDataSource: NSObject {
    public var vm:CD_ViewModelTableViewProtocol?
    private override init(){}
    public init(_ vm:CD_ViewModelTableViewProtocol?) {
        self.vm = vm
    }
}
extension CD_TableViewDelegateDataSource {
    open func makeReloadData(_ tableView:UITableView) {
        vm?._reloadData = {[weak self] in
            tableView.reloadData()
            tableView.cd.mjRefreshTypes(self!.vm?._mjRefreshType ?? [.tEnd])
        }
        
        vm?._reloadDataIndexPath = { [weak self] (indexPath, animation) in
            tableView.reloadRows(at: indexPath, with: animation)
            tableView.cd.mjRefreshTypes(self!.vm?._mjRefreshType ?? [.tEnd])
        }
        
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

extension CD_TableViewDelegateDataSource: UITableViewDelegate, UITableViewDataSource {
    open func numberOfSections(in tableView: UITableView) -> Int {
        return vm?._forms.count ?? 0
    }
    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm?._forms[section].count ?? 0
    }
    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let row = vm?._forms[indexPath.section][indexPath.row] else {
            return UITableViewCell()
        }
        let cell = tableView.cd.cell(row.cellClass, id:row.cellId, bundleFrom:row.bundleFrom ?? "") ?? UITableViewCell()
        row.bind(cell)
        return cell
    }
    open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let row = vm?._forms[indexPath.section][indexPath.row] else {
            return
        }
        row.tapBlock?()
    }
    open func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let row = vm?._forms[indexPath.section][indexPath.row] else {
            return 0
        }
        return row.h
    }
    open func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section < (vm?._formHeaders.count ?? 0) {
            return vm?._formHeaders[section].h ?? CD.sectionMinH
        }else{
            guard let count = vm?._forms[section].count, count > 0, let top = vm?._forms[section].first?.insets.top, top > 0 else {
                return CD.sectionMinH
            }
            return top
        }
    }
    open func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section < (vm?._formFooters.count ?? 0) {
            return vm?._formFooters[section].h ?? CD.sectionMinH
        }else{
            guard let count = vm?._forms[section].count, count > 0, let bottom = vm?._forms[section].first?.insets.bottom, bottom > 0 else {
                return CD.sectionMinH
            }
            return bottom
        }
    }
    open func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
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
    open func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
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


open class CD_TableViewController: UIViewController {
    open var vm:CD_ViewModelTableViewProtocol?
    open var delegateData:CD_TableViewDelegateDataSource?
    open lazy var tableView: UITableView = {
        return UITableView(frame: CGRect.zero, style: UITableView.Style.grouped).cd
            .build
    }()
    open lazy var topBar: CD_TopBar = {
        return CD_TopBar()
    }()
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        makeUI()
        makeLayout()
        delegateData?.makeReloadData(tableView)
        topBar.delegate = self
        vm?._tableViewCustom?(tableView)
    }
    
    open func makeUI(){
        self.cd.navigationBar(hidden: true)
        self.view.cd
            .add(tableView)
            .add(topBar)
        
        delegateData = CD_TableViewDelegateDataSource(vm)
        tableView.cd.delegate(delegateData).dataSource(delegateData)
        
    }
    
    open func makeLayout(){
        topBar.snp.makeConstraints {
            $0.left.right.top.equalToSuperview()
        }
        
        tableView.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.top.equalTo(topBar.snp.bottom)
            guard let safeArea = vm?._safeAreaLayout, safeArea else {
                $0.bottom.equalToSuperview()
                return
            }
            if #available(iOS 11.0, *) {
                $0.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
            } else {
                $0.bottom.equalTo(bottomLayoutGuide.snp.bottom)
            }
        }
    }
    
}

extension CD_TableViewController: CD_TopBarProtocol {
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


