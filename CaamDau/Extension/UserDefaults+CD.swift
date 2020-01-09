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
    var object:Any? {get}
    var string:String? {get}
    var bool:Bool {get}
    var dictionary:[String:Any]? {get}
    var array:[Any]? {get}
    func save(_ value:Any?)
    func remove()
}

extension CaamDauUserDefaultsProtocol {
    public var value:Any? {
        UserDefaults.standard.object(forKey: name)
        return UserDefaults.standard.object(forKey: name)
    }
    public var object:Any? {
        return UserDefaults.standard.object(forKey: name)
    }
    public var string:String? {
        return UserDefaults.standard.string(forKey: name)
    }
    public var bool:Bool {
        return UserDefaults.standard.bool(forKey: name)
    }
    public var dictionary:[String:Any]? {
        return UserDefaults.standard.dictionary(forKey: name)
    }
    public var array:[Any]? {
        return UserDefaults.standard.array(forKey: name)
    }
    
    
    public func save(_ value:Any?) {
        UserDefaults.standard.set(value, forKey: name)
        UserDefaults.standard.synchronize()
    }
    public func remove() {
        UserDefaults.standard.removeObject(forKey: name)
    }
}
