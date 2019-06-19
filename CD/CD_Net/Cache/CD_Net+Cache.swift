//Created  on 2019/6/15 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 *  扩展 Cache 功能 依赖 Cache 库: https://github.com/hyperoslo/Cache
 */




import Foundation
import Alamofire
import Cache
import CD

public extension CD_Net {
    func makeStorage() -> Storage<Data>? {
        return try? Storage<Data>(diskConfig: DiskConfig(name: cd_appId()), memoryConfig: MemoryConfig(expiry: .never, countLimit: 10, totalCostLimit: 10), transformer: TransformerFactory.forData())
    }
    
    /// 默认使用 url ,相同url 增加 key 标识
    @discardableResult
    func onCache(withData key:String = "", completion:((Data) ->Void)?) -> Self {
        let urlPath = (self.baseURL + self.path) + (key.isEmpty ? "" : ("."+key))
        let storage = self.makeStorage()
        if let data = try? storage?.object(forKey: urlPath), let res = data {
            completion?(res)
        }
        return self
    }
    
    @discardableResult
    func toCache(withData key:String = "", when:()->Bool = {true}) -> Self {
        guard when() else { return self}
        self.cache = { [weak self]res in
            guard let self = self else { return }
            let urlPath = (self.baseURL + self.path) + (key.isEmpty ? "" : ("."+key))
            let storage = self.makeStorage()
            try? storage?.setObject(res, forKey: urlPath)
        }
        return self
    }
    
    @discardableResult
    func removeCache(withData key:String) -> Self {
        let urlPath = (self.baseURL + self.path) + (key.isEmpty ? "" : ("."+key))
        let storage = self.makeStorage()
        try? storage?.removeObject(forKey: urlPath)
        return self
    }
    
    static func removeAllCacheData() {
        DispatchQueue.global(qos: .default).async {
            let storage = try? Storage<Data>(diskConfig: DiskConfig(name: cd_appId()), memoryConfig: MemoryConfig(expiry: .never, countLimit: 10, totalCostLimit: 10), transformer: TransformerFactory.forData())
            try? storage?.removeAll()
        }
    }
}



