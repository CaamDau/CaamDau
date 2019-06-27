//Created  on 2018/12/16  by LCD :https://github.com/liucaide .

import Foundation
import UIKit
import CaamDau
import Home
import Demo
import Rx
import Publish
import Mine
import Sign

public extension VC_Tab{
    public static func show() -> VC_Tab{
        return VC_Tab()//.cd_storyboardWithBundle(from:"CD", name:"TabbarNavigationStoryboard") as! VC_Tab
    }
}

public class VC_Tab:UITabBarController{
    public override func viewDidLoad() {
        super.viewDidLoad()
        let n1 = UINavigationController(rootViewController: VC_Home.show())
        let n2 = UINavigationController(rootViewController: VC_Demo.show())
        //self.viewControllers = [n1]
        let n3 = UINavigationController(rootViewController: VC_Publish.show())
        let n4 = UINavigationController(rootViewController: VC_Rx.show())
        let n5 = UINavigationController(rootViewController: VC_Mine.show())
        self.viewControllers = [n1,n2,n3,n4,n5]
        
        self.selectedIndex = 4
        //self.setViewControllers([n1,n2,n3,n4,n5,], animated: true)
    }
}
