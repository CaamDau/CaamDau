//Created  on 2018/12/16  by LCD :https://github.com/liucaide .

import UIKit
import CaamDau
import Util
import SnapKit

public extension VC_Mine{
    
    static func show() -> VC_Mine{
        return VC_Mine.cd_storyboard(withBundle:"Mine", name:"MineStoryboard") as! VC_Mine
    }
}

public class VC_Mine: UIViewController {
    @IBOutlet weak var topBar: CD_TopBar!
    @IBOutlet weak var tableView: UITableView!
    var vm:VM_Mine = VM_Mine()
    
    lazy var modelMj:CD_MJRefreshModel = {
        var m = CD_MJRefreshModel()
        let ass = Assets()
        let arr = [ass.refresh_0,
                   ass.refresh_1,
                   ass.refresh_2,
                   ass.refresh_3,
                   ass.refresh_4,
                   ass.refresh_5,
                   ass.refresh_6,
                   ass.refresh_7]
        m.down_imgIdle = arr
        m.down_imgPulling = arr
        m.down_imgWillRefresh = arr
        m.down_imgRefreshing = arr
        return m
    }()
    
    var tableViewHeaderHeight:CGFloat = 220
    lazy var tableViewHeader: UIView = {
        let vv = UIView(frame: CGRect(w: cd_screenW(), h: tableViewHeaderHeight))
        vv.addSubview(tableViewHeaderImgBg)
        tableViewHeaderImgBg.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        tableViewHeaderImgBg.contentMode = .scaleAspectFill
        tableViewHeaderImgBg.clipsToBounds = true
        tableViewHeaderImgBg.cd.blurEffect(block: { (v) in
            v.snp.makeConstraints { (make) in
                make.edges.equalToSuperview()
            }
        })
        vv.addSubview(tableViewHeaderImgLogo)
        tableViewHeaderImgLogo.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.height.equalTo(80)
        }
        tableViewHeaderImgLogo.cd.corner(40, clips: true)
        return vv
    }()
    
    lazy var tableViewHeaderImgBg: UIImageView = {
        return UIImageView(image: Assets().logo_0)
    }()
    lazy var tableViewHeaderImgLogo: UIImageView = {
        return UIImageView(image: Assets().logo_0)
    }()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.cd.navigationBar(hidden: true)
        self.tableView.delegate = self
        self.tableView.cd
            .estimatedAll()
            //.content(inset: UIEdgeInsets(top: topBar._heightStatusBar, left: 0, bottom: 0, right: 0))
            /*.headerMJGifWithModel({ [weak self] in
                CD_Timer.after(3, {[weak self] in
                    self?.tableView.cd.endRefreshing()
                    self?.tableView.reloadData()
                })
            }, model: modelMj)
            .beginRefreshing()*/
            .table(headerView: tableViewHeader)
        
        topBar.delegate = self
    }
}

extension VC_Mine:UITableViewDelegate,UITableViewDataSource {
    public func numberOfSections(in tableView: UITableView) -> Int {
        return vm.forms.count
    }
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.forms[section].count
    }
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let row = vm.forms[indexPath.section][indexPath.row]
        return row.h
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = vm.forms[indexPath.section][indexPath.row]
        let cell = tableView.cd.cell(row.viewClass)
        row.bind(cell!)
        return cell!
    }
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let row = vm.forms[indexPath.section][indexPath.row]
        row.didSelect?()
    }
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.001
    }
    public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        /*
        print("contentOffsetY-->", contentOffsetY)
        print("contentOffset.Y->", scrollView.contentOffset.y)
        
        guard scrollView.contentOffset.y > 0 else {
            return
        }
        guard contentOffsetY >= 0 else {
            return
        }
        if scrollView.contentOffset.y > contentOffsetY {
            //上
            velocityUp = true
            let offset = scrollView.contentOffset.y-contentOffsetY
            self.topBar.hidden(navigationBar: -offset)
        }else{
            //下
            velocityUp = false
            let offset = scrollView.contentOffset.y-contentOffsetY
            self.topBar.hidden(navigationBar: -(44-abs(offset)))
            
        }*/
        
        self.topBar.change(alpha: scrollView.contentOffset.y, maxOffset: tableViewHeaderHeight-topBar._heightTopBar) { [weak self](a) in
            let arr:[(UIColor,Float)] = [(Config.color.main_5.cd_alpha(a),0),(Config.color.main_4.cd_alpha(a),1)]
            self?.topBar.cd.gradient(layerAxial: arr,  updateIndex: 0)
        }
        
        do{ /// logo 缩小到标题栏
        
        }
        do{ /// 背景缩放
            guard scrollView.contentOffset.y <= tableViewHeaderHeight else {
                return
            }
            let offset = scrollView.contentOffset.y
            tableViewHeaderImgBg.snp.updateConstraints { (make) in
                make.top.equalToSuperview().offset(offset)
            }
            guard scrollView.contentOffset.y <= 0 else {
                return
            }
            tableViewHeaderImgBg.snp.updateConstraints { (make) in
                make.left.equalToSuperview().offset(offset)
                make.right.equalToSuperview().offset(-offset)
            }
        }
        
    }
    
    public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        //contentOffsetY = scrollView.contentOffset.y
    }
    
    public func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        /*
        if velocity.y > 1.0 {
            self.topBar.hidden(navigationBar: true)
        }else if velocity.y < -1.0 {
            self.topBar.hidden(navigationBar: false)
        }*/
    }
}


extension VC_Mine: CD_TopBarProtocol {
    public func topBarCustom() {
        topBar.cd.background(UIColor.clear)
        topBar.bar_navigation.line.isHidden = true
        topBar._colorTitle = UIColor.white
        topBar._colorSubTitle = UIColor.white
        topBar._colorNormal = UIColor.white
        topBar._colorSelected = UIColor.white
        topBar._colorHighlighted = UIColor.white
        let arr:[(UIColor,Float)] = [(Config.color.main_5.cd_alpha(0),0),(Config.color.main_4.cd_alpha(0),1)]
        //topBar.bar_status.cd.gradient(layer: arr)
        //topBar.bar_navigation.cd.gradient(layer: arr)
        topBar.cd.gradient(layerAxial: arr)
        
        //topBar._heightCustomBar = 40
        //topBar.bar_custom.cd.background(UIColor.orange)
    }
    
    public func update(withTopBar item: CD_TopNavigationBar.Item) -> [CD_TopNavigationBarItem.Item.Style]? {
        switch item {
        case .leftItem1:
            let icon = CD_IconFont.tsearch(22)
            return [.title([(txt: icon.text, font: icon.font, color: Config.color.hex("f"), state: .normal),
                            (txt: icon.text, font: icon.font, color: Config.color.hex("d"), state: .highlighted),
                            (txt: icon.text, font: icon.font, color: Config.color.hex("d"), state: .selected)])]
        case .rightItem1:
            let icon = CD_IconFont.tshare(22)
            return [.title([(txt: icon.text, font: icon.font, color: Config.color.hex("f"), state: .normal),
                            (txt: icon.text, font: icon.font, color: Config.color.hex("d"), state: .highlighted),
                            (txt: icon.text, font: icon.font, color: Config.color.hex("d"), state: .selected)])]
        default:
            return nil
        }
    }
}
