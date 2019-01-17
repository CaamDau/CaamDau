//Created  on 2018/12/11  by LCD :https://github.com/liucaide .

import Foundation
import UIKit
//MARK:--- 打印 ----------
#if DEBUG
public func print_cd(_ items: Any...){
    print("---👉👉👉")
    print(items)
    print("----------💀")
}
#else
public func print_cd(_ items: Any...){}
#endif

//MARK:--- 重载运算符 两个字典合并为一个字典 ----------
public func += <key, value> ( cd_one: inout Dictionary<key, value>, cd_two: Dictionary<key, value>) {
    for (k, v) in cd_two {
        cd_one.updateValue(v, forKey: k)
    }
}

//MARK:--- 耗时测试 ----------
/// 耗时测试
public func cd_timeConsuming(_ name:String? = "💀👉👉耗时：", call:(()->Void)? = nil) {
    //let startTime = CFAbsoluteTimeGetCurrent()
    //let endTime = CACurrentMediaTime()
    let start = CACurrentMediaTime()
    call?()
    let end = CACurrentMediaTime()
    print_cd(name, String(format: "%.7f", (end - start)*1000))
}

//MARK:--- UIWindow ----------
/// delegate UIWindow
public let cd_window:UIWindow? = UIApplication.shared.delegate?.window ?? UIApplication.shared.keyWindow ?? nil
//MARK:--- 顶层 VC ----------
/// 当前显示的 VC
public func cd_visibleVC(_ vc: UIViewController? = nil) -> UIViewController?{
    let vc = vc ?? cd_window?.rootViewController
    func visibleVC(_ vc: UIViewController? = nil) -> UIViewController? {
        if let nv = vc as? UINavigationController
        {
            return visibleVC(nv.visibleViewController)
        } else if let tb = vc as? UITabBarController,
            let select = tb.selectedViewController
        {
            return visibleVC(select)
        } else if let presented = vc?.presentedViewController {
            return visibleVC(presented)
        }
        return vc
    }
    return visibleVC(vc)
}
/// 导航栈的栈顶 VC
public func cd_topVC(_ vc: UIViewController? = nil) -> UIViewController? {
    let vc = vc ?? cd_window?.rootViewController
    func topVC(_ vc: UIViewController? = nil) -> UIViewController? {
        let vc = vc ?? cd_window?.rootViewController
        if let nv = vc as? UINavigationController,
            !nv.viewControllers.isEmpty
        {
            // topViewController == viewControllers.last
            return topVC(nv.topViewController)
        } else if let tb = vc as? UITabBarController,
            let select = tb.selectedViewController
        {
            return topVC(select)
        } else if let presented = vc?.presentedViewController {
            return topVC(presented)
        }
        return vc
    }
    return topVC(vc)
}

/*
public func cd_string(from className: String) -> AnyClass? {
    guard let appName:String = Bundle.main.infoDictionary!["CFBundleExecutable"] as? String else {
        print("命名空间不存在")
        return nil
    }
    let classStringName = "_TtC\(appName.count)\(appName)\(className.count)\(className)"
    let  cls: AnyClass? = NSClassFromString(classStringName)
    return cls
}

public func cd_cell(from string : String) -> UITableViewCell.Type? {
    guard let appName:String = Bundle.main.infoDictionary!["CFBundleExecutable"] as? String else {
        print("命名空间不存在")
        return nil
    }
    let classStringName = "_TtC\(appName.count)\(appName)\(string.count)\(string)"
    let  cls: AnyClass? = NSClassFromString(classStringName)
    guard let clsType = cls as? UITableViewCell.Type else {
        return nil
    }
    return clsType
}
*/
