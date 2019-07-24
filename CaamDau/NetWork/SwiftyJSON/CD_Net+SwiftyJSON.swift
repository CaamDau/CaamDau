//Created  on 2019/6/15 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 * 扩展 SwiftyJSON 功能 依赖: https://github.com/SwiftyJSON/SwiftyJSON
 *
 */




import Foundation
import SwiftyJSON

/// 一般来说，在开发中 都是 model先行的，并不一定先有明确的 json
/// 同时，通用model需要达到 多模块的契合
public protocol CD_SwiftyJSONProtocol {
    /// model 遵循 此协议，使用SwiftyJSON 进行转模型
    /// 多模块通用可根据 tag，实现不同 json <key> 转同一模型
    init(_ json:JSON, tag:CD_SwiftyJSONTagProtocol?)
    
    func toData() -> Data
}
extension CD_SwiftyJSONProtocol {
    public func toData() -> Data {
        return Data()
    }
}

public protocol CD_SwiftyJSONTagProtocol {
    var tag:Int? { get }
    var key:String? {get}
}
extension CD_SwiftyJSONTagProtocol {
    public var tag:Int? { return nil }
    public var key:String? { return nil }
}

public extension CD_Net {
    @discardableResult
    func mapModels<J:CD_SwiftyJSONProtocol>(withSwiftyJSON t:J.Type, tag:CD_SwiftyJSONTagProtocol? = nil, succeed:(([J]) ->Void)?) -> Self {
        success = { res in
            let jsons = JSON(res).arrayValue
            let model = jsons.compactMap{J($0, tag: tag)}
            succeed?(model)
            /*
            DispatchQueue.global(qos: .default).async {
                DispatchQueue.main.async {
                    
                }
            }*/
        }
        return self
    }
    
    @discardableResult
    func mapModel<J:CD_SwiftyJSONProtocol>(withSwiftyJSON t:J.Type, tag:CD_SwiftyJSONTagProtocol? = nil, succeed:((J) ->Void)?) -> Self {
        success = { res in
            let json = JSON(res)
            let model = J(json, tag: tag)
            succeed?(model)
        }
        return self
    }
}


public extension Data {
    func mapSwiftJSONModel<J:CD_SwiftyJSONProtocol>(_ t:J.Type, tag:CD_SwiftyJSONTagProtocol? = nil) -> J {
        let json = JSON(self)
        return J(json, tag: tag)
    }
    func mapSwiftJSONModels<J:CD_SwiftyJSONProtocol>(_ t:J.Type, tag:CD_SwiftyJSONTagProtocol? = nil) -> [J] {
        let jsons = JSON(self).arrayValue
        return jsons.compactMap{J($0, tag: tag)}
    }
}
