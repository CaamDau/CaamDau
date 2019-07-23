import UIKit
import Foundation

//let arr = [1,2,3,4,5,6,7]
//arr.forEach { (i) in
//    guard i != 3 else { return }
//    print(i)
//}

public func += <key, value> ( cd_one: inout Dictionary<key, value>, cd_two: Dictionary<key, value>) {
    for (k, v) in cd_two {
        cd_one.updateValue(v, forKey: k)
    }
}

var callback:(([String:Any]?) -> [String:Any]?)? = { p -> [String:Any]? in
    var ppp = p ?? [:]
    let pt:[String:Any] = ["1":"3", "2":4]
    ppp += pt
    return ppp
}

var pp:[String:Any]?
pp?.isEmpty
pp = callback?(pp) ?? pp
pp
pp?.isEmpty
pp = [:]
pp?.isEmpty
