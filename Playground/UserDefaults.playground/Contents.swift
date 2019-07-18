import UIKit
import Foundation



public protocol CaamDauUserDefaultsProtocol {
    var name: String { get }
    var value:Any? {get}
    func save(_ object:Any?)
    func remove()
    
}

extension CaamDauUserDefaultsProtocol {
    var value:Any? {
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


enum User:String {
    case name = "name"
}

extension User:CaamDauUserDefaultsProtocol {
    var name: String {
        return "id" + self.rawValue
    }
}
