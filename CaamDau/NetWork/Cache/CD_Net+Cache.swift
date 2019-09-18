//Created  on 2019/6/15 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 *  扩展 Cache 功能 依赖 Cache 库: https://github.com/hyperoslo/Cache
 */




import Foundation
import Cache

public extension CD_Net {
    func makeStorage() -> Storage<Data>? {
        return try? Storage<Data>(diskConfig: DiskConfig(name: CD.appId), memoryConfig: MemoryConfig(expiry: .never, countLimit: 10, totalCostLimit: 10), transformer: TransformerFactory.forData())
    }
    
    /// 默认使用 url ,相同url 增加 key 标识
    @discardableResult
    func onCache(withData key:String = "", completion:((Data) ->Void)?) -> Self {
        let urlPath = (self.baseURL + self.path) + (key.isEmpty ? "" : ("."+key))
        let storage = self.makeStorage()
        if let data = try? storage?.object(forKey: urlPath) {
            completion?(data)
        }else{
            failure?(CD_Net.Error(code: -1100, massage: ""))
        }
        return self
    }
    
    @discardableResult
    func toCache(withData key:String = "", when:@escaping (Data)->Bool = {_ in true}, customCache:((Data)->Data)? = nil) -> Self {
        self.cache = { [weak self]res in
            guard when(res) else {return}
            guard let self = self else { return }
            let urlPath = (self.baseURL + self.path) + (key.isEmpty ? "" : ("."+key))
            let storage = self.makeStorage()
            if let custom = customCache?(res) {
                try? storage?.setObject(custom, forKey: urlPath)
            }else{
                try? storage?.setObject(res, forKey: urlPath)
            }
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
            let storage = try? Storage<Data>(diskConfig: DiskConfig(name: CD.appId), memoryConfig: MemoryConfig(expiry: .never, countLimit: 10, totalCostLimit: 10), transformer: TransformerFactory.forData())
            try? storage?.removeAll()
        }
    }
}



