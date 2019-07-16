//Created  on 2019/7/12 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 *
 */




import UIKit


public class CD_UITableViewDelegateData: NSObject {
    public var vm:CD_ViewModelTableViewProtocol?
    private override init(){}
    public init(_ vm:CD_ViewModelTableViewProtocol?) {
        self.vm = vm
    }
}
extension CD_UITableViewDelegateData: UITableViewDelegate, UITableViewDataSource {
    public func numberOfSections(in tableView: UITableView) -> Int {
        return vm?._form.count ?? 0
    }
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm?._form[section].count ?? 0
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let row = vm?._form[indexPath.section][indexPath.row] else {
            return UITableViewCell()
        }
        let cell = tableView.cd.cell(row.viewClass, id:row.viewId, bundleFrom:row.bundleFrom) ?? UITableViewCell()
        row.bind(cell)
        return cell
    }
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let row = vm?._form[indexPath.section][indexPath.row] else {
            return
        }
        row.didSelect?()
    }
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let row = vm?._form[indexPath.section][indexPath.row] else {
            return 0
        }
        return row.h
    }
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section < (vm?._formHeader.count ?? 0) {
            return vm?._formHeader[section].h ?? CD.sectionMinH
        }else{
            guard let count = vm?._form[section].count, count > 0, let top = vm?._form[section].first?.insets.top, top > 0 else {
                return CD.sectionMinH
            }
            return top
        }
    }
    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section < (vm?._formFooter.count ?? 0) {
            return vm?._formFooter[section].h ?? CD.sectionMinH
        }else{
            guard let count = vm?._form[section].count, count > 0, let bottom = vm?._form[section].first?.insets.bottom, bottom > 0 else {
                return CD.sectionMinH
            }
            return bottom
        }
    }
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
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
    public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
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


