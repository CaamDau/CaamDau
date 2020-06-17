//Created  on 2018/12/11  by LCD :https://github.com/liucaide .

import Foundation
import UIKit
import CaamDau

class Cell_BaseTabTitle:UITableViewCell {
    lazy var btn: UIButton = {
        return UIButton(frame: CGRect(x: 20, y: 10, w: 200, h: 30)).cd.isUser(false).text(UIColor.red).build
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(btn)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
extension Cell_BaseTabTitle:RowCellUpdateProtocol {
    typealias DataSource = (UIImage?,String)
    typealias ConfigModel = Any
    func row_update(dataSource data: DataSource) {
        btn.cd
            //.image(data.0)
            .text(data.1)
            .contentAlignment(horizontal:.left)
            .text(Config.color.txt_1)
        //self.textLabel?.text = data.1
    }
}


class VM_HUD {
    lazy var form: [[CellProtocol]] = {
        return (0..<Section.end.rawValue).map{_ in []}
    }()
    //var formHeader:[CellProtocol]
    //var formFooter:[CellProtocol]
    var mjRefreshType:[RefreshModel.RefreshType] = [.tBegin, .tHiddenFoot(true)]
    
    var reloadData:(()->Void)?
    var reloadDataIndexPath:(([IndexPath],UITableView.RowAnimation)->Void)?
    
    var topBarCustom:((TopBar)->Void)?
    var topBarDidSelect:((TopBar,TopNavigationBar.Item)->Void)?
    
    init() {
    }
    
    lazy var assets: Assets = {
        return Assets()
    }()
}

extension VM_HUD: ViewModelRefreshDelegater {
    var _mjRefreshType: [RefreshModel.RefreshType] {
        return mjRefreshType
    }
    
    
}

extension VM_HUD: ViewModelTableViewDelegater {
    var _tableViewCustom: ((UITableView) -> Void)? {
        return { tab in
            tab.cd.estimatedAll()
            //tab.cd.background(UIColor.lightGray)
        }
    }
}

extension VM_HUD: ViewModelTopBarDelegater {
    var _topBarCustom: ((TopBar) -> Void)? {
        return { bar in
            bar._style = "22"
            bar._title = "HUD"
        }
    }
    var _topBarUpdate: ((TopBar, TopNavigationBar.Item) -> [TopNavigationBarItem.Item.Style]?)? {
        return { (top,item) -> [TopNavigationBarItem.Item.Style]?  in
            switch item {
            case .leftItem1:
                return [.title([(IconFont.tclose(30).text,IconFont.tclose(30).font,.black,.normal), (IconFont.tclose(30).text,IconFont.tclose(30).font,.lightGray,.highlighted), (IconFont.tclose(30).text,IconFont.tclose(30).font,.lightGray,.selected)])]
            case .leftItem2:
                return [.title([(IconFont.temoji(30).text,IconFont.temoji(30).font,.black,.normal), (IconFont.temoji(30).text,IconFont.temoji(30).font,.lightGray,.highlighted), (IconFont.temoji(30).text,IconFont.temoji(30).font,.lightGray,.selected)])]
            case .rightItem1:
                return [.title([(IconFont.tadd(30).text,IconFont.tadd(30).font,.black,.normal), (IconFont.tadd(30).text,IconFont.tadd(30).font,.lightGray,.highlighted), (IconFont.tadd(30).text,IconFont.tadd(30).font,.lightGray,.selected)])]
            case .rightItem2:
                return [.title([(IconFont.tshare(30).text,IconFont.tshare(30).font,.black,.normal), (IconFont.tshare(30).text,IconFont.tshare(30).font,.lightGray,.highlighted), (IconFont.tshare(30).text,IconFont.tshare(30).font,.lightGray,.selected)])]
            default:
                return nil
            }
        }
    }
}

extension VM_HUD {
    enum Section:Int {
        case config = 0
        case hud
        case custom
        case progress
        case end
    }
    
    static var loadingStyle:HUD.Style.Loading? = nil
    static var infoStyle:HUD.Style = .info
    static var title:String = "HUD"
    static var detail:String = "Detail"
    
    func makeFrom(_ refresh: Bool) {
        if refresh {
            self.form = (0..<Section.end.rawValue).map{_ in []}
        }
        do{//MARK:--- Config ----------
            let row = RowCell<Cell_HUDConfig>(data: "", frame: CGRect( h: UITableView.automaticDimension), bundleFrom: "Mine")
            form[Section.config.rawValue].append(row)
        }
        do{//MARK:--- Proress ----------
            let row = RowCell<Cell_HUDProress>(data: "", frame: CGRect(h:140), bundleFrom: "Mine")
            form[Section.progress.rawValue].append(row)
        }
        
        
        do{//MARK:--- HUD ----------
            let row = RowCell<Cell_BaseTabTitle>(data: (assets.logo_20, "Title"), frame: CGRect( h: 50), insets:UIEdgeInsets(t:10)) {
                CD.window?.cd.hud(.text, title:VM_HUD.title)
            }
            form[Section.hud.rawValue].append(row)
        }
        do{
            let row = RowCell<Cell_BaseTabTitle>(data: (assets.logo_20, "Title-Detail"), frame: CGRect( h: 50)) {
                CD.window?.cd.hud(.text, title:VM_HUD.title, detail:"\((0..<500).map{_ in VM_HUD.detail}.joined())")
            }
            form[Section.hud.rawValue].append(row)
        }
        
        do{
            let row = RowCell<Cell_BaseTabTitle>(data: (assets.logo_20, "Loading"), frame: CGRect( h: 50)) {
                CD.window?.cd.hud(.loading(VM_HUD.loadingStyle), title: VM_HUD.title, detail: VM_HUD.detail).hud_remove(10)
            }
            form[Section.hud.rawValue].append(row)
        }
        do{
            let row = RowCell<Cell_BaseTabTitle>(data: (assets.logo_20, "Infos"), frame: CGRect( h: 50)) {
                CD.window?.cd.hud(VM_HUD.infoStyle, title: VM_HUD.title, detail: VM_HUD.detail).hud_remove(10)
            }
            form[Section.hud.rawValue].append(row)
        }
        
        do{
            let row = RowCell<Cell_BaseTabTitle>(data: (assets.logo_20, "Custom"), frame: CGRect( h: 50)) {
                let image = UIImageView(image: Assets().logo_0)
                /*/ 两种便捷方式 固定约束，不设置，将自适应
                 // 1
                 image.snp.makeConstraints({ (make) in
                 make.width.height.equalTo(30)
                 })
                 //2
                 image.heightAnchor.constraint(equalToConstant: 30).isActive = true
                 image.widthAnchor.constraint(equalTo: image.heightAnchor, multiplier: 1).isActive = true
                 */
                CD.window?.cd.hud(.custom(image), title: VM_HUD.title, detail: VM_HUD.detail).hud_remove(3)
            }
            
            form[Section.hud.rawValue].append(row)
        }
        
        do{
            let row = RowCell<Cell_BaseTabTitle>(data: (assets.logo_20, "Proress - default"), frame: CGRect( h: 50)) {[weak self] in
                self?.showProress(false)
            }
            form[Section.hud.rawValue].append(row)
        }
        do{
            let row = RowCell<Cell_BaseTabTitle>(data: (assets.logo_20, "Proress - custom"), frame: CGRect( h: 50)) {[weak self] in
                self?.showProress(true)
            }
            form[Section.hud.rawValue].append(row)
        }
        
        do{//MARK:--- HUD-自定义动画 ----------
            let row = RowCell<Cell_BaseTabTitle>(data: (assets.logo_20, "HUD-自定义动画"), frame: CGRect( h: 50), insets:UIEdgeInsets(t:20, b:10)) {[weak self]in
                self?.customAnimation()
            }
            form[Section.custom.rawValue].append(row)
        }
        Time.after(0.5) {[weak self] in
            self?.mjRefreshType = [.tEnd]
            self?.reloadData?()
        }
    }
    
    //MARK:--- Proress ----------
    
    func showProress(_ custom:Bool) {
        if !custom {
            var pro:HUDProgressView?
            func proressCycle() {
                guard let pp = pro else { return }
                guard pp.progress < 100 else {
                    CD.window?.cd.hud_remove(2)
                    return
                }
                Time.after(2) {[weak pro] in
                    pro?.progress += 10
                    proressCycle()
                }
            }
            CD.window?.cd.hud(.progress(.default(model: HUDProgressView.Model(), handler: { (vv) in
                pro = vv
                proressCycle()
            })), title: VM_HUD.title, detail: VM_HUD.detail)
            
        }else{
            var pro:HUDProgressView = HUDProgressView()
            pro.translatesAutoresizingMaskIntoConstraints = false
            pro.heightAnchor.constraint(equalToConstant: 60).isActive = true
            pro.widthAnchor.constraint(equalToConstant: 60).isActive = true
            var model = HUDProgressView.Model()
            pro.model = model
            func proressCycle() {
                guard pro.progress < 100 else {
                    CD.window?.cd.hud_remove(2)
                    return
                }
                Time.after(2) {[weak pro] in
                    pro?.progress += 10
                    proressCycle()
                }
            }
            CD.window?.cd.hud(.progress(.view(pro)), title: VM_HUD.title, detail: VM_HUD.detail)
            proressCycle()
        }
    }
    
    
    
    //MARK:--- 自定义显示动画 ----------
    func customAnimation() {
        var model = HUD.Model()
        model._position = .bottom
        model._showAnimation = .custom { (hud, contentView) in
            guard let v = hud else {return}
            func addAnimation(with view: UIView, value:(Any,Any)){
                let animote = CASpringAnimation(keyPath: "position.y")
                animote.duration = 1
                animote.damping = 10
                animote.stiffness = 500
                animote.mass = 0.5
                animote.initialVelocity = 0
                animote.fromValue = value.0
                animote.toValue = value.1
                view.layer.add(animote, forKey: animote.keyPath)
            }
            switch v.model._position {
            case .top:
                guard let view = v.model._isEnabledMask ? v : contentView else { return }
                view.superview?.layoutIfNeeded()
                let value0 = view.layer.position.y - view.layer.position.y - view.frame.size.height
                let value1 = view.layer.position.y
                addAnimation(with: view, value:(value0,value1))
                v.makeLayoutAnimationFade(false)
            case .bottom:
                guard let view = v.model._isEnabledMask ? v : contentView else { return }
                view.superview?.layoutIfNeeded()
                let value0 = view.layer.position.y + view.frame.size.height + v.model._offsetBottomY
                let value1 = view.layer.position.y
                addAnimation(with: view, value:(value0,value1))
                v.makeLayoutAnimationFade(false)
            case .center:
                v.makeLayoutAnimationFade(false)
            case .custom(_):
                break
            }
        }
        CD.window?.cd.hud(.text, title: "HUD", detail: "自定义动画", model: model).hud_remove(3)
    }
}

extension VM_HUD: ViewModelDataSource {
    
    func requestData(_ refresh: Bool) {
        makeFrom(refresh)
    }
    
    var _collectionRegisters: [CaamDau<UICollectionView>.View] {
        return []
    }
    
    var _forms: [[CellProtocol]] {
        return form
    }
    
    var _formHeaders: [CellProtocol] {
        return []
    }
    
    var _formFooters: [CellProtocol] {
        return []
    }
    
    var _reloadData: (() -> Void)? {
        get {
            return reloadData
        }
        set(newValue) {
            reloadData = newValue
        }
    }
    
    var _reloadDataIndexPath: (([IndexPath], UITableView.RowAnimation) -> Void)? {
        get {
            return reloadDataIndexPath
        }
        set(newValue) {
            reloadDataIndexPath = newValue
        }
    }
}



