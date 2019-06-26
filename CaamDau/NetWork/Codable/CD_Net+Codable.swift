//Created  on 2019/6/15 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 * 扩展 Codable 功能 依赖: CleanJSON https://github.com/Pircate/CleanJSON
 */




import Foundation
import CleanJSON

public extension CD_Net {
    /// 使用 Codable 的话 应使用 .request(.data)
    @discardableResult
    func mapModels<T:Codable>(withCodable t:T.Type, succeed:(([T]) ->Void)?) -> Self {
        success = { res in
            if let data = res as? Data {
                let decoder = CleanJSONDecoder()
                if let model = try? decoder.decode([T].self, from: data) {
                    succeed?(model)
                }
            }
        }
        return self
    }
    /// 使用 Codable 的话 应使用 .request(.data)
    @discardableResult
    func mapModel<T:Codable>(withCodable t:T.Type, succeed:((T) ->Void)?) -> Self {
        success = { res in
            if let data = res as? Data {
                let decoder = CleanJSONDecoder()
                if let model = try? decoder.decode(T.self, from: data) {
                    succeed?(model)
                }
            }
        }
        return self
    }
}

public extension Data {
    func mapCodableModel<T:Codable>(_ t:T.Type) -> T? {
        let decoder = CleanJSONDecoder()
        return try? decoder.decode(T.self, from: self)
    }
    func mapCodableModels<T:Codable>(_ t:T.Type) -> [T]? {
        let decoder = CleanJSONDecoder()
        return try? decoder.decode([T].self, from: self)
    }
}
