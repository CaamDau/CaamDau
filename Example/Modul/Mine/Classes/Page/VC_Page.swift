//Created  on 2019/4/13 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 *
 */




import UIKit
import CD
import Config

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
        
        pageControl.dataSource = (0..<20).map({ (i) -> CD_PageControlItemDataSource in
            var d = CD_PageControlItemDataSource()
            d.id = i.stringValue
            
            d.title = "Title-\(i)"
            return d
        })
        
        pageVC.dataSource = [CD_RowVC<VC_PageA>(dataSource: "id", config: "config"),
                              CD_RowVC<VC_PageB>(),
                              CD_RowVC<VC_PageC>(),
                              CD_RowVC<VC_PageD>(),
                              CD_RowVC<VC_PageA>(),
                              CD_RowVC<VC_PageB>(),
                              CD_RowVC<VC_PageC>(),
                              CD_RowVC<VC_PageD>()]
        pageVC.dataSource.append(CD_RowVC<VC_PageA>())
        pageVC.dataSource.append(CD_RowVC<VC_PageB>())
        pageVC.dataSource.append(CD_RowVC<VC_PageC>())
        pageVC.dataSource.append(CD_RowVC<VC_PageD>())
        (0..<7).forEach { (_) in
            pageVC.dataSource.append(CD_RowVC<VC_PageD>())
        }
        
        self.pageVC.selectIndex = 2
        
        
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
        topBar.cd.background(UIColor.clear)
        topBar.bar_navigation.line.isHidden = true
        topBar._colorTitle = UIColor.white
        topBar._colorSubTitle = UIColor.white
        topBar._colorNormal = UIColor.white
        topBar._colorSelected = UIColor.white
        topBar._colorHighlighted = UIColor.white
        let arr:[(UIColor,Float)] = [(Config.color.main_2.cd_alpha(1),0),(Config.color.main_1.cd_alpha(1),1)]
        topBar.bar_status.cd.gradient(layerAxial: arr)
        topBar.bar_navigation.cd
            .gradient(layerAxial: arr)
        
        //tapBar._heightCustomBar = 40
        //tapBar.bar_custom.cd.background(UIColor.orange)
    }
}


