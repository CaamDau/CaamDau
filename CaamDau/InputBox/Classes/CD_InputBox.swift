//Created  on 2019/8/22 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 *
 */




import UIKit

public class CD_InputBox {
    public class Cache {
        private init(){}
        static let shared = Cache()
        var cache:[String:String] = [:]
    }
}
extension CD_InputBox.Cache {
    public class func save(_ key:String, value:String) {
        guard !key.isEmpty else { return }
        CD_InputBox.Cache.shared.cache[key] = value
    }
    public class func read(_ key:String) -> String {
        guard !key.isEmpty else { return "" }
        return CD_InputBox.Cache.shared.cache.stringValue(key)
    }
    public class func remove(_ key:String) {
        guard !key.isEmpty else { return }
        CD_InputBox.Cache.shared.cache.removeValue(forKey: key)
    }
}
