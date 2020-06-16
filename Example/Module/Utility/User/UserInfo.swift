//Created  on 2018/02/27  by LCD :https://github.com/liucaide .

/***** 模块文档 *****
 * 用户管理模块
 */


import Foundation
import UIKit
import CaamDau
import SwiftyJSON

public extension User {
    public struct InfoModel: Codable {
        public var status:String = ""
        public var error:String = ""
        public var userid:String = ""
        public var username:String = ""
        public var token:String = ""
        
        public init() {}
    }
}

extension User.InfoModel:CD_SwiftyJSONProtocol {
    public init(_ json: JSON, tag: CD_SwiftyJSONTagProtocol?) {
        status = json["status"].stringValue
        userid = json["userid"].stringValue
        username = json["username"].stringValue
        token = json["token"].stringValue
        User.shared.token = token
    }
}





//MARK:--- 用户详细信息 ----------
public extension User {
    public struct Detail: Codable {
        public var status:String = ""
        
        public init(){}
    }
}
extension User.Detail:CD_SwiftyJSONProtocol {
    public init(_ json: JSON, tag: CD_SwiftyJSONTagProtocol?) {
        status = json["status"].stringValue
    }
}
