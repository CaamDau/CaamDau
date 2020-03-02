//Created  on 2019/7/2 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 *
 */




import Foundation
import TabBarNavigation
import Mine
import Home

class App_VC: CD_AppDelegate {
    var window: UIWindow?
    var tabbar: UITabBarController?
    init(_ win: UIWindow?) {
        window = win
    }
    var observer:[NSObjectProtocol] = []
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        window?.makeKeyAndVisible()
        
        User.shared.statusNotification = true
        observer.append(User.notice.signIn.add(block: { [weak self](n) in
            self?.makeTabBar()
        }))
        observer.append(User.notice.signOut.add(block: { [weak self](n) in
            self?.makeSign()
        }))
        observer.append(User.notice.signForced.add(block: { [weak self](n) in
            self?.makeSign()
        }))
        let token = User.shared.token
        if token.isEmpty {
            //makeSign()
            makeTabBar()
        }else{
            //makeSign()
            makeTabBar()
        }
        return true
    }
    func makeSign() {
        
    }
    
    func makeTabBar() {
        let vc1 = UINavigationController(rootViewController: R_Home().vc)
        let vc2 = UINavigationController(rootViewController: R_Mine().vc)
        let vc3 = UINavigationController(rootViewController: R_Mine().vc)
        let vc4 = UINavigationController(rootViewController: R_Mine().vc)
        
        tabbar = UITabBarController()
        tabbar?.cd
            .viewControllers([vc1,
                              vc2,
                              vc3,
                              vc4
            ])
            //.makeTabBar()
        tabbar?.selectedIndex = 3
        vc1.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor:UIColor.red], for:.disabled)
        
        
        window?.rootViewController = tabbar
    }
}

extension CaamDau where Base: UITabBarController { 
    @discardableResult
    func makeTabBar() -> CaamDau {
        let assets = AssetsTabBar()
        base.tabBar.cd
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
            //.colorNormals([.red, .yellow, .blue, .orange])
            //.colorSelecteds((0..<5).map{_ in Config.color.tabbar1})
//            .fontNormals([.systemFont(ofSize: 10),
//                          .systemFont(ofSize: 10),
//                          .systemFont(ofSize: 10)])
//            .fontSelecteds([.systemFont(ofSize: 14),
//                            .systemFont(ofSize: 14),
//                            .systemFont(ofSize: 14)])
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
        return self
    }
}
