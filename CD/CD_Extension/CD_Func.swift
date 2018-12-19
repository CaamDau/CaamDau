//Created  on 2018/12/11  by LCD :https://github.com/liucaide .

import Foundation
import UIKit

//MARK:-----------重载运算符 两个字典合并为一个字典
public func += <key, value> ( one: inout Dictionary<key, value>, two: Dictionary<key, value>) {
    for (k, v) in two {
        one.updateValue(v, forKey: k)
    }
}

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
