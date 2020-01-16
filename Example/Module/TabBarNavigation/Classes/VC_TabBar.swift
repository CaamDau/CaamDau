//Created  on 2018/12/16  by LCD :https://github.com/liucaide .

import Foundation
import UIKit
import CaamDau
import Utility

public class VC_TabBar:UITabBarController{
    
    lazy var assets: AssetsTabBar = {
        return AssetsTabBar()
    }()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
}

public extension VC_TabBar {
    func makeTabBar() {
        self.tabBar.cd
            .hideLine()
            .isTranslucent(false)
            .imageNormals([assets.home_normal,
                           assets.me_normal,
                           assets.me_normal,
                           assets.me_normal])
            .imageSelects([assets.home_selected,
                           assets.me_selected,
                           assets.me_selected,
                           assets.me_selected])
            .titles(["首页", "我的", "我的", "我的"])
            .colorNormals((0..<5).map{_ in Config.color.txt_1})
            .colorSelecteds((0..<5).map{_ in Config.color.tabbar0})
            .fontNormals([.systemFont(ofSize: 10),
                          .systemFont(ofSize: 10),
                          .systemFont(ofSize: 10)])
            .fontSelecteds([.systemFont(ofSize: 14),
                            .systemFont(ofSize: 14),
                            .systemFont(ofSize: 14)])
            .badges([nil,"123","666","999"])
            //.badgeColors([nil,.black,.yellow])
            //.badgeColorSelecteds([.black,.black,.red])
            .addShadowLine(backgroundColor: UIColor.white) { (v) in
                v.snp.makeConstraints { (make) in
                    make.left.right.top.equalToSuperview()
                    make.height.equalTo(0.5)
                }
        }
        .addShadowLine(backgroundColor: UIColor.white) { (v) in
            v.snp.makeConstraints { (make) in
                make.left.right.top.equalToSuperview()
                make.height.equalTo(0.5)
            }
        }
    }
    
    public override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
