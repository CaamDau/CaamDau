//Created  on 2019/2/17 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 *
 */




import Foundation

//MARK:--- 重载运算符 两个字典合并为一个字典 ----------
public func += <key, value> ( cd_one: inout Dictionary<key, value>, cd_two: Dictionary<key, value>) {
    for (k, v) in cd_two {
        cd_one.updateValue(v, forKey: k)
    }
}

public extension Dictionary {
    
}
