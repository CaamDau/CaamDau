//Created  on 2019/6/3 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 * UserDefaults 管理协议 遵循此协议，更方便管理
 
 * 示例
enum UserDefaulsUser:String {
    case token = "token"
}
extension UserDefaulsUser:CD_NotificationProtocol {
    var name: String {
        return "user."+self.rawValue
    }
}
UserDefaulsUser.token.save("123")
*/

import Foundation

public protocol CaamDauUserDefaultsProtocol {
    var name: String { get }
    var value:Any? {get}
    func save(_ value:Any?)
    func remove()
}

extension CaamDauUserDefaultsProtocol {
    public var value:Any? {
        return UserDefaults.standard.value(forKey: name)
    }
    public func save(_ value:Any?) {
        UserDefaults.standard.set(value, forKey: name)
        UserDefaults.standard.synchronize()
    }
    public func remove() {
        UserDefaults.standard.removeObject(forKey: name)
    }
}
