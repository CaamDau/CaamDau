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
    static func push() {
        let vc = VC_Page.show()
        vc.hidesBottomBarWhenPushed = true
        cd_visibleVC()?.navigationController?.pushViewController(vc, animated: true)
    }
}

class VC_Page: UIViewController {
    
    lazy var topBar: CD_TopBar = {
        let bar = CD_TopBar()
        return bar
    }()
    
    lazy var pageVC: CD_PageViewController = {
        return CD_PageViewController()
    }()
    
    lazy var pageControl: CD_PageControl = {
        return CD_PageControl()
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
        pageControl.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(topBar.snp.bottom)
            make.height.equalTo(40)
        }
        pageControl.layoutIfNeeded()
        
        self.addChild(pageVC)
        self.view.addSubview(pageVC.view)
        pageVC.view.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(pageControl.snp.bottom)
        }
        
        print_cd(pageControl.frame)
        pageControl._itemSize = CGSize(w: 60, h: 40)
        
        
        pageControl.register([.tCell(CD_PageControlTitle.self, nil, nil)])
        var form:[CD_RowProtocol] = []
        for item in 0..<20 {
            var model = CD_PageControlTitle.Model()
            model.titleNormal = "\(item)"
            let row = CD_Row<CD_PageControlTitle>.init(data: model) {[weak self] in
                self?.pageVC.didSelect(item)
            }
            form.append(row)
        }
        pageControl._items = form
    
        pageVC._itemSize = CGSize(w: cd_screenW(), h: cd_screenH()-64-40)
        
        pageVC._viewControllers = [VC_PageA.show(),
                                   VC_PageB.show(),
                                   VC_PageC.show(),
                                   VC_PageD.show(),
                                   VC_PageA.show(),
                                   VC_PageB.show(),
                                   VC_PageC.show(),
                                   VC_PageD.show(),
                                   VC_PageA.show(),
                                   VC_PageB.show(),
                                   VC_PageC.show(),
                                   VC_PageD.show(),
                                   VC_PageA.show(),
                                   VC_PageB.show(),
                                   VC_PageC.show(),
                                   VC_PageD.show(),
                                   VC_PageA.show(),
                                   VC_PageB.show(),
                                   VC_PageC.show(),
                                   VC_PageD.show()]
    }
}

extension VC_Page {
    func hidden(navigationBar hidden: Bool) {
        self.pageVC._itemSize = CGSize(w: cd_screenW(), h: cd_screenH()-(hidden ? 20 : 64)-40)
        self.topBar.hidden(navigationBar: hidden)
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
        topBar.bar_status.cd.gradient(layer: arr)
        topBar.bar_navigation.cd
            .gradient(layer: arr)
        
        //tapBar._heightCustomBar = 40
        //tapBar.bar_custom.cd.background(UIColor.orange)
    }
}
