//Created  on 2019/7/12 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 * 针对旧的表单协议 CD_RowProtocol, 建议使用新的，但旧的依然可用，但计划在正式版本1.0中删除
 */




import Foundation
import UIKit
import SnapKit

//MARK:--- 针对旧的表单协议 CD_RowProtocol 计划在正式版本1.0中删除  ----------
/// 使用旧的 协议，弃用
@available(*, deprecated, message: "旧的，弃用")
open class CD_UITableViewDelegateData: NSObject {
    public var vm:CD_ViewModelTableViewProtocol?
    private override init(){}
    public init(_ vm:CD_ViewModelTableViewProtocol?) {
        self.vm = vm
    }
}
extension CD_UITableViewDelegateData {
    /// 使用旧的 协议，弃用
    @available(*, deprecated, message: "旧的，弃用")
    open func makeReloadData(_ tableView:UITableView) {
        vm?._reloadData = {[weak self, weak tableView] in
            tableView?.reloadData()
            tableView?.cd.mjRefreshTypes(self?.vm?._mjRefreshType ?? [.tEnd])
        }
        
        vm?._reloadRows = { [weak self, weak tableView] (indexPath, animation) in
            tableView?.reloadRows(at: indexPath, with: animation)
            tableView?.cd.mjRefreshTypes(self?.vm?._mjRefreshType ?? [.tEnd])
        }
        
        vm?._reloadSections = { [weak self, weak tableView] (sections, animation) in
            tableView?.reloadSections(sections, with: animation)
            tableView?.cd.mjRefreshTypes(self?.vm?._mjRefreshType ?? [.tEnd])
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
extension CD_UITableViewDelegateData: UITableViewDelegate, UITableViewDataSource {
    open func numberOfSections(in tableView: UITableView) -> Int {
        return vm?._form.count ?? 0
    }
    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm?._form[section].count ?? 0
    }
    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let row = vm?._form[indexPath.section][indexPath.row] else {
            return UITableViewCell()
        }
        let cell = tableView.cd.cell(row.viewClass, id:row.viewId, bundleFrom:row.bundleFrom) ?? UITableViewCell()
        row.bind(cell)
        return cell
    }
    open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let row = vm?._form[indexPath.section][indexPath.row] else {
            return
        }
        row.didSelect?()
    }
    open func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let row = vm?._form[indexPath.section][indexPath.row] else {
            return 0
        }
        return row.h
    }
    open func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section < (vm?._formHeader.count ?? 0) {
            return vm?._formHeader[section].h ?? CD.sectionMinH
        }else{
            guard let count = vm?._form[section].count, count > 0, let top = vm?._form[section].first?.insets.top, top > 0 else {
                return CD.sectionMinH
            }
            return top
        }
    }
    open func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section < (vm?._formFooter.count ?? 0) {
            return vm?._formFooter[section].h ?? CD.sectionMinH
        }else{
            guard let count = vm?._form[section].count, count > 0, let bottom = vm?._form[section].first?.insets.bottom, bottom > 0 else {
                return CD.sectionMinH
            }
            return bottom
        }
    }
    open func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard section < (vm?._formHeader.count ?? 0) else {
            return nil
        }
        guard let row = vm?._formHeader[section] else {
            return nil
        }
        guard let v = tableView.cd.view(row.viewClass, id:row.viewId, bundleFrom:row.bundleFrom) else {
            return nil
        }
        row.bind(v)
        return v
    }
    open func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard section < (vm?._formFooter.count ?? 0) else {
            return nil
        }
        guard let row = vm?._formFooter[section] else {
            return nil
        }
        guard let v = tableView.cd.view(row.viewClass, id:row.viewId, bundleFrom:row.bundleFrom) else {
            return nil
        }
        row.bind(v)
        return v
    }
}



//MARK:--- 提供一个基础的 TableViewController 简单的页面不需要编写 ViewController----------
/// 使用旧的 协议，弃用
@available(*, deprecated, message: "旧的，弃用")
public struct R_CDBaseTableViewController {
    public static func push(_ vm:CD_ViewModelTableViewProtocol) {
        let vc = CD_BaseTableViewController()
        vc.vm = vm
        CD.push(vc)
    }
}

/// 使用旧的 协议，弃用
@available(*, deprecated, message: "旧的，弃用")
open class CD_BaseTableViewController: CD_FormTableViewController {
    open var vm:CD_ViewModelTableViewProtocol?
    open var delegateData:CD_UITableViewDelegateData?
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
        
        delegateData = CD_UITableViewDelegateData(vm)
        delegateData?.makeReloadData(tableView)
        tableView.cd
            .delegate(delegateData)
            .dataSource(delegateData)
        topBar.delegate = self
        vm?._tableViewCustom?(tableView)
        vm?._bottomBarCustom?(bottomBar)
    }
    override open func makeTableView() {
        self.cd.navigationBar(hidden: true)
        stackView.cd
            .addArranged(subview: topBar)
            .addArranged(subview: tableView)
            .addArranged(subview: bottomBar)
    }
    open func makeLayout(){
        bottomBar.snp.makeConstraints {
            $0.height.equalTo(vm?._bottomBarHeignt ?? 0)
        }
    }
}

extension CD_BaseTableViewController: CD_TopBarProtocol {
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
