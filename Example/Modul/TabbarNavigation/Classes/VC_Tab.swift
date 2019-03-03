//Created  on 2018/12/16  by LCD :https://github.com/liucaide .

import Foundation
import UIKit
import CD
import Home
import Find
import Publish
import Car
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
        //self.viewControllers = [n1]
        let n2 = UINavigationController(rootViewController: VC_Find.show())
        let n3 = UINavigationController(rootViewController: VC_Publish.show())
        let n4 = UINavigationController(rootViewController: VC_Car.show())
        let n5 = UINavigationController(rootViewController: VC_Mine.show())
        self.viewControllers = [n1,n2,n3,n4,n5]
        //self.setViewControllers([n1,n2,n3,n4,n5,], animated: true)
    }
}
