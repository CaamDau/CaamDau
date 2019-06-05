//: [Previous](@previous)

import Foundation
import UIKit


//MARK:--- 脚本 ----------
public extension String {
    /// 下标脚本
    subscript (cd_rang: Range<Int>) -> String {
        get {
            var r = cd_rang
            guard r.lowerBound < self.count else{
                return ""
            }
            if r.upperBound > self.count {
                r = r.lowerBound..<self.count
            }
            let startIndex = self.index(self.startIndex, offsetBy: r.lowerBound)
            let endIndex = self.index(self.startIndex, offsetBy: r.upperBound)
            return String(self[startIndex..<endIndex])
        }
        set{
            var r = cd_rang
            guard r.lowerBound < self.count else{
                return
            }
            if r.upperBound > self.count {
                r = r.lowerBound..<self.count
            }
            let startIndex = self.index(self.startIndex, offsetBy: r.lowerBound)
            let endIndex = self.index(self.startIndex, offsetBy: r.upperBound)
            self.replaceSubrange(Range(uncheckedBounds: (startIndex, endIndex)), with: newValue)
        }
    }
}


do{
    // 示例
    var strsss = "01234567"
    
    let c = strsss.count
    if c >= 8 {
        strsss[(c-8)/2 ..< (c-8)/2+8] = "********"
    }
    strsss
    /*
     var rang = Range(0..<3)
     var s = rang.lowerBound
     var e = rang.upperBound
     if s >= str.count {
     print("-->")
     }
     if e > str.count {
     e = str.count
     }
     let startIndex = str.index(str.startIndex, offsetBy: s)
     let endIndex = str.index(str.startIndex, offsetBy: e)
     print(startIndex)
     print(endIndex)
     var rangs = Range(uncheckedBounds: (lower: startIndex, upper: endIndex))
     print(rangs)
     str.replaceSubrange(rangs, with: "000")
     str
     */
    /*
     let range = Range(1 ..< 5)
     
     let startIndex = str.index(str.startIndex, offsetBy: range.lowerBound)
     let endIndex = str.index(str.startIndex, offsetBy: range.upperBound)
     
     let r = Range(startIndex..<endIndex)
     */
}

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

enum NoticeUser:String {
    case login = "login"
}
extension NoticeUser:CD_NotificationProtocol {
    var name: Notification.Name {
        return Notification.Name("user."+self.rawValue)
    }
}



(0.0...5.1).contains(1.1123)


