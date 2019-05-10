//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport
import CD


/*
extension UIView {
    /// 设置背景渐变 默认横向渐变 point -> 0 - 1
    func gradientLayer(_ gradient:[(color:UIColor,location:Float)], point:(start:CGPoint, end:CGPoint) = (CGPoint(x: 0, y: 0),CGPoint(x: 1, y: 0))) {
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = gradient.map{$0.color.cgColor}
        gradientLayer.locations = gradient.map{NSNumber(value:$0.location)}
        
        gradientLayer.startPoint = point.start
        gradientLayer.endPoint = point.end
        
        gradientLayer.frame = self.frame
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
}

class MyViewController : UIViewController {
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white

        let label = UILabel()
        label.frame = CGRect(x: 0, y: 0, width: 200, height: 40)
        label.text = "Hello World!"
        label.textColor = .black
        view.addSubview(label)
        
        let gradientView = UIView(frame: CGRect(x: 0, y: 40, width: 200, height: 60))
        view.addSubview(gradientView)
        
        gradientView.gradientLayer([(UIColor.red, 0.0),
                                    (UIColor.yellow, 0.5),
                                    (UIColor.blue, 1.0)])
        
        self.view = view
    }
}
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
*/

public protocol CD_ViewModelDelegater {
    var _form:[[CD_RowProtocol]] { get }
    var _formHeader:[CD_RowProtocol] { get }
    var _formFooter:[CD_RowProtocol] { get }
    var _reloadData:((IndexPath)->Void)? { get }
}

class ViewModel {
    
}


class MyViewController : UIViewController {
    var vm:CD_ViewModelDelegater?
    
    lazy var tableView: UITableView = {
        return UITableView(frame: CGRect(x: 0, y: 0, w: 320, h: 568), style: UITableView.Style.grouped).cd
            .delegate(self)
            .dataSource(self)
            .build
    }()
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white
        
        view.addSubview(tableView)
        
        self.view = view
    }
}
extension MyViewController: UITableViewDelegate,UITableViewDataSource {
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
        return vm?._formHeader[section].h ?? cd_sectionMinH()
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return vm?._formFooter[section].h ?? cd_sectionMinH()
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
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

// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
