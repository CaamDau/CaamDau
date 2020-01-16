//Created  on 2019/12/25 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 *
 */




import Foundation
import UIKit
struct R_FormsTableViewA {
    static func push() {
        let vc = CD_TableViewController()
        vc.vm = VM_FormsTableViewA()
        CD.push(vc)
    }
}



class VM_FormsTableViewA {
    var forms: [[CD_CellProtocol]] = []
    var reloadData: (() -> Void)?
    var mjRefreshType: [CD_MJRefreshModel.RefreshType] = [.tBegin]
    lazy var itemsLoad: [CD_EmptyView.Item] = {
        return [
            .activity(nil),
            .image({
                let ass = Assets()
                let list:[UIImage] = [
                    ass.refresh_0, ass.refresh_1, ass.refresh_2,
                    ass.refresh_3, ass.refresh_4, ass.refresh_5,
                    ass.refresh_6, ass.refresh_7
                ]
                $0.animationImages = list
                $0.animationDuration = 1
                $0.animationRepeatCount = 0
                $0.startAnimating()
            }, {
                print("点击了")
            }),
            .lable({
                $0.cd.text("正在拼命加载中")
            }, {
                print("点击了")
            })
        ]
    }()
    
    lazy var itemsNotData: [CD_EmptyView.Item] = {
        return [
            .lable({
                let icon = CD_IconFont.twarn(40)
                $0.cd.text(icon.text).text(icon.font)
            }, {
                print("点击了")
            }),
            .lable({
                $0.cd.text("没有数据")
            }, {
                print("点击了")
            })
        ]
    }()
    
    
    lazy var emptyView: CD_EmptyView = {
        let v = CD_EmptyView()
        v.items = itemsLoad
        return v
    }()
}
extension VM_FormsTableViewA {
    func makeForm() {
        mjRefreshType = [.tEnd]
        reloadData?()
    }
}
extension VM_FormsTableViewA: CD_ViewModelTableViewProtocol {
    var _forms: [[CD_CellProtocol]] {
        return forms
    }
    
    var _reloadData: (() -> Void)? {
        set{
            reloadData = newValue
        }
        get{
            return reloadData
        }
    }
    var _mjRefreshType: [CD_MJRefreshModel.RefreshType] {
        return mjRefreshType
    }
    
    var _emptyView: ((Any?) -> UIView?)? {
        return { [weak self](a) -> UIView? in
            guard let self = self else { return nil }
            if self._forms.isEmpty {
                self.emptyView.items = self.itemsNotData
                return self.emptyView
            }
            return nil
        }
    }
    
    func requestData(_ refresh: Bool) {
        CD_Timer.after(3) {[weak self] in
            self?.makeForm()
        }
    }
}
