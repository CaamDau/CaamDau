import UIKit
import Foundation




/*
extension Array {
    /// 数组去重
    func cd_filter<E: Equatable>(_ repeated: (Element) -> E) -> [Element] {
        var result = [Element]()
        self.forEach { (e) in
            let key = repeated(e)
            let keys = result.map{repeated($0)}
            guard !keys.contains(key) else {return}
            result.append(e)
        }
        return result
    }
}
do{
    let arr = (65...90).compactMap{String(UnicodeScalar($0))}
    print(arr)
}
do{
    var arr = (97...122).compactMap{String(UnicodeScalar($0))}
    print(arr)
    let arr2 = arr.compactMap{$0.capitalized}
    print(arr)
    print(arr2)
    
    arr.append("a")
    print(arr)
    let arr3 = arr.cd_filter{$0}
    print(arr3)
}
struct Model {
    let name:String
}
do{
    let arr = [Model(name: "1"), Model(name: "2"), Model(name: "3"), Model(name: "1")]
    print(arr)
    let arr2 = arr.cd_filter({$0.name})
    print(arr2)
}
do{
    let arr = [["1":1], ["1":2], ["1":3], ["1":1], ["1":2], ["1":3], ["1":4]]
    print(arr)
    let arr2 = arr.cd_filter({$0["1"]})
    print(arr2)
}
*/

//let arr = [1,2,3,4,5,6,7]
//for item in arr {
//    guard item == 3 else { continue }
//    print(item)
//}


//public func += <key, value> ( cd_one: inout Dictionary<key, value>, cd_two: Dictionary<key, value>) {
//    for (k, v) in cd_two {
//        cd_one.updateValue(v, forKey: k)
//    }
//}
//
//var callback:(([String:Any]?) -> [String:Any]?)? = { p -> [String:Any]? in
//    var ppp = p ?? [:]
//    let pt:[String:Any] = ["1":"3", "2":4]
//    ppp += pt
//    return ppp
//}
//
//var pp:[String:Any]?
//pp?.isEmpty
//pp = callback?(pp) ?? pp
//pp
//pp?.isEmpty
//pp = [:]
//pp?.isEmpty
/*
extension String {
    //MARK:---------- 汉字转拼音
    func cd_pinyin(remove diacritics:Bool = true)->String{
        let mutableString = NSMutableString(string: self)
        CFStringTransform(mutableString  as CFMutableString, nil, kCFStringTransformToLatin, false)
        if diacritics {
            CFStringTransform(mutableString, nil, kCFStringTransformStripDiacritics, false)
        }
        return String(mutableString)
        //mutableString.folding(options: .diacriticInsensitive, locale: .current)
        //CFStringTransform(mutableString, nil, kCFStringTransformStripCombiningMarks, false)
        //string = string.capitalized
        // 首字母大写
        //var str1 = string.replacingOccurrences(of: " ", with: "")
        //str1 = str1.capitalized
        //return str1
    }
    
    func cd_pinyinFirst(_ clear:Bool = true, capitalized:Bool = true, placeholder:String = "#")->String{
        guard !self.isEmpty else { return placeholder }
        var f = self
        if clear {
            f = f.replacingOccurrences(of: " ", with: "")
        }
        f = String(f.first!)
        f = f.cd_pinyin()
        if capitalized {
            f = f.capitalized
        }
        return String(f.first!)
    }
    
    
    //MARK:--- 按拼音排序 -----------------------------
    static func sp_SortPinYin(_ arr:[String])->[String]{
        return arr.sorted(by: { (one, two) -> Bool in
            one < two
        })
    }
}


"重地".cd_pinyin()
"_".cd_pinyinFirst()
*/



