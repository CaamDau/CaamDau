//Created  on 2019/7/1 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 *
 */




import UIKit
import CaamDau

class CD_TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        self.tabBar.cd
            .hideLine()
            .isTranslucent(false)
            .imageNormals([UIImage(named: "com_返回首页_黑"),
                           UIImage(named: "com_分享_黑"),
                           UIImage(named: "com_收藏_未点")])
            .imageSelects([UIImage(named: "com_点赞_已点"),
                           UIImage(named: "com_点赞_已点"),
                           UIImage(named: "com_收藏_已点")])
            .titles(["首页","分享","收藏"])
            .fontNormals([.systemFont(ofSize: 10),
                          .systemFont(ofSize: 10),
                          .systemFont(ofSize: 10)])
            .fontSelecteds([.systemFont(ofSize: 14),
                            .systemFont(ofSize: 14),
                            .systemFont(ofSize: 14)])
            .colorNormals([.gray,nil])
            .colorSelecteds([.red,nil,.yellow])
            .badges([nil,"123","666"])
            
        if #available(iOS 10.0, *) {
            self.tabBar.cd
                .badgeColors([nil,.black,.yellow])
                .badgeColorSelecteds([.black,.black,.red])
        } else {
            
        }
        
        //添加简单的阴影
        self.tabBar.cd.addShadowLine(backgroundColor: UIColor.white) { (v) in
            v.snp.makeConstraints { (make) in
                make.left.right.top.equalToSuperview()
                make.height.equalTo(0.5)
            }
        }
        
        
    }
    
    
}
