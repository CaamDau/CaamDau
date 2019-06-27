//Created  on 2019/6/3 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 * CD_NotificationProtocol 通知管理协议 遵循此协议，更方便管理通知
 
 * 示例
enum NoticeUser:String {
    case login = "login"
}
extension NoticeUser:CD_NotificationProtocol {
    var name: Notification.Name {
        return Notification.Name("user."+self.rawValue)
    }
}

class Test {
    init() {
        //Selector
        NoticeUser.login.add(withSelector: #selector(notificationTo(_:)), observer: self, object: "123")
    }
    @objc func notificationTo(_ n:Notification) {
        debugPrint(n)
    }
    deinit {
        NoticeUser.login.remove(self)
    }
}
//Block
NoticeUser.login.add { (n) in
    debugPrint(n)
}
NoticeUser.login.post("123", userInfo: ["id":"456"])
*/


import Foundation

protocol CD_NotificationProtocol {
    var name: NSNotification.Name { get }
    func post(_ object:Any?, userInfo:[AnyHashable:Any]?)
    func add(withSelector selector: Selector, observer: Any, object: Any?)
    func add(withBlock object: Any?, queue: OperationQueue?, block:@escaping (Notification) -> Void) -> NSObjectProtocol
    func remove(_ observer: Any, object:Any?)
}
extension CD_NotificationProtocol {
    func post(_ object:Any? = nil, userInfo:[AnyHashable:Any]? = nil) {
        NotificationCenter.default.post(name: name, object: object, userInfo: userInfo)
    }
    func add(withBlock object: Any? = nil, queue: OperationQueue? = .main, block: @escaping (Notification) -> Void) -> NSObjectProtocol {
        return NotificationCenter.default.addObserver(forName: name, object: object, queue: queue, using: block)
    }
    func add(withSelector selector: Selector, observer: Any, object: Any? = nil) {
        NotificationCenter.default.addObserver(observer, selector: selector, name: name, object: object)
    }
    func remove(_ observer: Any, object:Any? = nil) {
        NotificationCenter.default.removeObserver(observer, name: name, object: object)
    }
}
//MARK:--- RxSwift 扩展 ----------
extension CD_NotificationProtocol {
}

public extension Notification {
    static func cd_post(name str:String, object:Any? = nil, userInfo:[AnyHashable : Any]? = nil) {
        Notification.cd_post(notificationName: .cd_name(str), object: object, userInfo: userInfo)
    }
    static func cd_post(notificationName name:Notification.Name, object:Any? = nil, userInfo:[AnyHashable : Any]? = nil) {
        CD.notice.post(name: name, object: object, userInfo: userInfo)
    }
}
public extension Notification.Name {
    static func cd_name(_ name:String) -> Notification.Name {
        return Notification.Name(CD.appId + "." + name)
    }
}
