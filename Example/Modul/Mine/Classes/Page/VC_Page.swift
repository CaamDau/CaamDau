//Created  on 2019/4/13 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 *
 */




import UIKit
import CaamDau
import Util

extension VC_Page {
    static func show() -> VC_Page {
        return VC_Page.cd_storyboard(withBundle: "Mine", name: "MineStoryboard") as! VC_Page
    }
    static func push(_ style:Style) {
        let vc = VC_Page.show()
        vc.style = style
        vc.hidesBottomBarWhenPushed = true
        cd_visibleVC()?.navigationController?.pushViewController(vc, animated: true)
    }
    enum Style:Int {
        case hh = 0
        case hv
        case vv
        case vh
    }
}

class VC_Page: UIViewController {
    var style:Style = .hh
    lazy var topBar: CD_TopBar = {
        let bar = CD_TopBar()
        return bar
    }()
    
    lazy var pageVC: CD_PageViewController = {
        return CD_PageViewController()
    }()
    
    lazy var pageControl: CD_PageControl = {
        return CD_PageControl<CD_PageControlItem,CD_PageControlBuoy>(itemConfig:CD_PageControlItem.Model(), buoyConfig: CD_PageControlBuoy.Model())
    }()
    
//    lazy var configView: View_PageConfig = {
//        return View_PageConfig.show()
//    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.cd.navigationBar(hidden: true)
        self.view.cd
            .add(topBar)
            .add(pageControl)
        
        
        topBar.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
        }
        topBar.delegate = self
        
        self.addChild(pageVC)
        self.view.addSubview(pageVC.view)
        pageControl.delegate = self.pageVC
        pageVC.delegate = self.pageControl
        switch style {
        case .hh:
            pageControl.snp.makeConstraints { (make) in
                make.left.right.equalToSuperview()
                make.top.equalTo(topBar.snp.bottom)
                make.height.equalTo(40)
            }
            pageVC.view.snp.makeConstraints { (make) in
                make.left.right.bottom.equalToSuperview()
                make.top.equalTo(pageControl.snp.bottom)
            }
        case .hv:
            pageControl.snp.makeConstraints { (make) in
                make.left.right.equalToSuperview()
                make.top.equalTo(topBar.snp.bottom)
                make.height.equalTo(40)
            }
            pageVC.view.snp.makeConstraints { (make) in
                make.left.right.bottom.equalToSuperview()
                make.top.equalTo(pageControl.snp.bottom)
            }
            var m = CD_Page.Model()
            m.scrollDirection = .vertical
            m.marge = 0
            m.space = 0
            m.isScrollPaging = true
            pageVC.model = m
        case .vv:
            do{
                var m = CD_PageControlBuoy.Model()
                m.frame = CGRect(x: 0, y: 0, w: 3, h: CD_Page.Size.auto.rawValue)
                m.style = .line(.right(0))
                pageControl.buoyConfig = m
            }
            do{
                var m = CD_Page.Model()
                m.scrollDirection = .vertical
                pageControl.model = m
            }
            do{
                var m = CD_Page.Model()
                m.marge = 0
                m.space = 0
                m.scrollDirection = .vertical
                pageVC.model = m
            }
            pageControl.snp.makeConstraints { (make) in
                make.left.bottom.equalToSuperview()
                make.top.equalTo(topBar.snp.bottom)
                make.width.equalTo(80)
            }
            pageVC.view.snp.makeConstraints { (make) in
                make.right.bottom.equalToSuperview()
                make.top.equalTo(topBar.snp.bottom)
                make.left.equalTo(pageControl.snp.right)
            }
            
        case .vh:
            do{
                var m = CD_PageControlBuoy.Model()
                m.frame = CGRect(x: 0, y: 0, w: 3, h: CD_Page.Size.auto.rawValue)
                m.style = .line(.right(0))
                pageControl.buoyConfig = m
            }
            do{
                var m = CD_Page.Model()
                m.scrollDirection = .vertical
                pageControl.model = m
            }
            pageControl.snp.makeConstraints { (make) in
                make.left.bottom.equalToSuperview()
                make.top.equalTo(topBar.snp.bottom)
                make.width.equalTo(80)
            }
            pageVC.view.snp.makeConstraints { (make) in
                make.right.bottom.equalToSuperview()
                make.top.equalTo(topBar.snp.bottom)
                make.left.equalTo(pageControl.snp.right)
            }
        }
        pageControl.layoutIfNeeded()
        
        pageControl.dataSource = (0..<3).map({ (i) -> CD_PageControlItemDataSource in
            var d = CD_PageControlItemDataSource()
            d.id = i.stringValue
            d.title = "Title-\(i)"
            return d
        })
        
        pageVC.dataSource = [CD_RowVC<VC_PageA>(dataSource: "id", config: "config"),
                              CD_RowVC<VC_PageB>(),
                              CD_RowVC<VC_PageC>()]
        if style != .hh {
            pageControl.dataSource += (3..<20).map({ (i) -> CD_PageControlItemDataSource in
                var d = CD_PageControlItemDataSource()
                d.id = i.stringValue
                
                d.title = "Title-\(i)"
                return d
            })
            
            pageVC.dataSource.append(CD_RowVC<VC_PageA>())
            pageVC.dataSource.append(CD_RowVC<VC_PageB>())
            pageVC.dataSource.append(CD_RowVC<VC_PageC>())
            pageVC.dataSource.append(CD_RowVC<VC_PageD>())
            (0..<13).forEach { (_) in
                pageVC.dataSource.append(CD_RowVC<VC_PageD>())
            }
        }
        
        
        CD_Timer.after(0.01) {
            self.pageVC.selectIndex = 2
        }
        
        
        guard style == .hh else { return }
        
        CD_RowView<View_PageConfig>(dataSource: View_PageConfig.Model(), callBack: { [unowned self](obj) in
            if let tag = obj as? Int {
                switch tag {
                case 1 :
                    var d = CD_PageControlItemDataSource()
                    d.id = "\(self.pageControl.dataSource.count)"
                    d.title = "增加-"+d.id
                    self.pageControl.dataSource.append(d)
                    self.pageVC.dataSource.append(CD_RowVC<VC_PageD>())
                case 2 :
                    guard self.pageControl.dataSource.count > 3 else {return}
                    self.pageControl.dataSource.removeLast()
                    self.pageVC.dataSource.removeLast()
                case 3 :
                    var d = CD_PageControlItemDataSource()
                    d.id = "\(self.pageControl.dataSource.count)"
                    d.title = "插入-"+d.id
                    self.pageControl.dataSource.insert(d, at: self.pageVC.selectIndex)
                    self.pageVC.dataSource.insert(CD_RowVC<VC_PageD>(), at: self.pageVC.selectIndex)
                default:
                    return
                }
            }
            
            
            guard let model = obj as? View_PageConfig.Model else{ return }
            do{
                var m = self.pageControl.model
                m.alignment = model.bar_alig
                m.marge = model.bar_marge
                m.space = model.bar_space
                self.pageControl.model = m
            }
            do{
                var m = self.pageControl.itemConfig
                m?.animotion = model.bar_itemAni
                m?.scaleTransform = model.bar_itemAni == .lineZoom ? 0 : 0.8
                self.pageControl.itemConfig = m
            }
            do{
                var m = self.pageControl.buoyConfig
                m?.animotion = model.bar_buoyAni
                self.pageControl.buoyConfig = m
            }
            
        }).row_show(withSuperView: self.view, callBack: { vv in
            vv.snp.makeConstraints { (make) in
                make.left.bottom.right.equalToSuperview()
                make.height.equalTo(220)
            }
        })
        
    }
}



extension VC_Page {
    func hidden(navigationBar hidden: Bool) {
//        self.topBar.hidden(navigationBar: hidden) { (bool) in
//            
//        }
        //self.pageVC._itemSize = CGSize(w: cd_screenW(), h: cd_screenH()-(hidden ? 20 : 64)-40)
    }
}


extension VC_Page: CD_PageScrollProtocol {
    func scroll(didScroll view: UIScrollView, contentOffset:CGFloat, offsetRatio:CGFloat, size:CGFloat, index:Int) {
        
    }
    
    func scroll(didEndScrollingAnimation view: UIScrollView, index: Int, animotion:Bool) {
        
    }
    
    func scroll(didEndDecelerating view: UIScrollView, index: Int) {
        
    }
    
    func scroll(didEndDragging view: UIScrollView, index: Int) {
        
    }
    
    func scroll(willBeginDragging view: UIScrollView, offset:CGFloat) {
        
    }
    
    
}


extension VC_Page: CD_TopBarProtocol {
    public func topBarCustom() {
        topBar._title = "CD_Page"
        topBar.cd.background(UIColor.clear)
        topBar.bar_navigation.line.isHidden = true
//        topBar._colorTitle = UIColor.white
//        topBar._colorSubTitle = UIColor.white
//        topBar._colorNormal = UIColor.white
//        topBar._colorSelected = UIColor.white
//        topBar._colorHighlighted = UIColor.white
//        let arr:[(UIColor,Float)] = [(Config.color.main_2.cd_alpha(1),0),(Config.color.main_1.cd_alpha(1),1)]
//        topBar.bar_status.cd.gradient(layerAxial: arr)
//        topBar.bar_navigation.cd.gradient(layerAxial: arr)
//        
//        tapBar._heightCustomBar = 40
//        tapBar.bar_custom.cd.background(UIColor.orange)
    }
}


