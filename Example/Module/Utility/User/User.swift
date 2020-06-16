//Created  on 2018/02/27  by LCD :https://github.com/liucaide .

/***** 模块文档 *****
 * 用户管理模块
 */


import Foundation
import UIKit
import CaamDau
import KeychainAccess
import CleanJSON

public class User {
    public struct Keys {
        fileprivate static let save:String = CD.appId + "_user"
        fileprivate static let saveStyle:String = "_saveStyle"
        fileprivate static let accountList:String = "_accountList"
        fileprivate static let accountIndex:String = "_accountIndex"
        fileprivate static let account:String = "_account"
        fileprivate static let password:String = "_password"
        fileprivate static let token:String = "_token"
        fileprivate static let flag:String = "_flag"
        fileprivate static let userInfo:String = "_userInfo"
        fileprivate static let userInfoData:String = "_userInfoData"
    }
    public enum SaveStyle:String {
        case keychain = "keychain"
        case userDefaults = "userDefaults"
    }
    
    private init(){}
    private lazy var keychain:Keychain = {
        return Keychain(service: User.Keys.save)
    }()
    private var userDefaults:[String:Any] {
        set{}
        get{
            let value = UserDefaults.standard.value(forKey: User.Keys.save) as? [String:Any] ?? [:]
            return value
        }
    }
    
    private func setUserDefaults(_ key:String, _ value:Any) {
        var uu = userDefaults
        uu[key] = value
        UserDefaults.standard.set(uu, forKey: User.Keys.save)
        UserDefaults.standard.synchronize()
    }
    
    public static let shared = User()
    /// 存储类型 keychain 存储 读取相对更慢
    public var saveStyle:SaveStyle = .userDefaults
    /// 用户状态 通知 默认 false
    public var statusNotification:Bool = false
    /// 用户状态 - 0 已注销 1 已登录 2 已被踢
    public var signStatus:Int = 0 {
        didSet{
            guard statusNotification else {
                return
            }
            switch signStatus {
            case 0:
                User.notice.signOut.post()
            case 1:
                User.notice.signIn.post()
            case 2:
                User.notice.signForced.post()
            case 3:
                User.notice.signUp.post()
            default:
                User.notice.other.post()
            }
        }
    }
    
    /// 用户信息模型
    public lazy var _infoDataModel:User.InfoModel = {
        let decoder = CleanJSONDecoder()
        if let data = infoData,
            let model = try? decoder.decode(User.InfoModel.self, from: data),
            model.status == "2" {
            return model
        }
        return User.InfoModel()
    }()
    
    /// 用户个人中心详细信息
    public var detail:User.Detail = User.Detail()
    
}

public extension User {
    /// 账号列表
    func updateAccountList(_ s:String) {
        if !accountList.contains(s) {
            accountList.append(s)
        }
        accountIndex = accountList.firstIndex(of: s) ?? 0
    }
    var accountList:[String] {
        set{
            switch saveStyle {
            case .keychain:
                guard newValue.count > 0 else{
                    do { try keychain.removeAll() }catch {}
                    return
                }
                keychain[User.Keys.accountList] = newValue.joined(separator: "+|+")
            case .userDefaults:
                guard newValue.count > 0 else{
                    userDefaults.removeAll()
                    return
                }
                setUserDefaults(User.Keys.accountList, newValue)
            }
        }
        get{
            switch saveStyle {
            case .keychain:
                guard let list = keychain[User.Keys.accountList], !list.isEmpty else{
                    return []
                }
                let arr = list.components(separatedBy: "+|+")
                return arr
            case .userDefaults:
                let arr = userDefaults[User.Keys.accountList]
                return arr as? [String] ?? []
            }
        }
    }
    /// 当前账户
    var accountIndex:Int {
        set{
            switch saveStyle {
            case .keychain:
                keychain[User.Keys.accountIndex] = String(describing: newValue)
            case .userDefaults:
                setUserDefaults(User.Keys.accountIndex, newValue as Any)
            }
        }
        get{
            switch saveStyle {
            case .keychain:
                let idx = (keychain[User.Keys.accountIndex] ?? "").intValue
                return idx
            case .userDefaults:
                let idx = userDefaults.intValue(User.Keys.accountIndex)
                return idx
            }
        }
    }
    /// 当前账号
    var account:String {
        set{
            updateAccountList(newValue)
        }
        get{
            guard accountIndex < accountList.count else {
                return ""
            }
            let str = accountList[accountIndex]
            return str
        }
    }
    /// 密码
    var password:String {
        set{
            guard !account.isEmpty else { return }
            let pwd = password(newValue, isEncryption:true)
            switch saveStyle {
            case .keychain:
                keychain[account+User.Keys.password] = pwd
            case .userDefaults:
                setUserDefaults(account+User.Keys.password, pwd)
            }
        }
        get{
            guard !account.isEmpty else { return "" }
            switch saveStyle {
            case .keychain:
                let pwd = keychain[account+User.Keys.password] ?? ""
                return password(pwd, isEncryption:false)
            case .userDefaults:
                let pwd = userDefaults[account+User.Keys.password] as? String ?? ""
                return password(pwd, isEncryption:false)
            }
        }
    }
    /// 密码加密/解密
    private func password(_ pwd:String, isEncryption:Bool) -> String {
        guard !pwd.isEmpty else {
            return ""
        }
        func random() -> String {
            let str = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
            return (0..<6).map({ (i) -> String in
                let idx:Int = Int(arc4random()) % str.count
                let idx1:Int = idx+1
                return str[idx..<idx1]
            }).joined()
        }
        func encryption() -> String {
            var pwd = pwd
            /// 中间插入
            pwd[2..<2] = random()
            /// 头部插入
            pwd[0..<0] = random()
            /// 尾部插入
            pwd.append(random())
            return pwd.cd_base64Encoding
        }
        func decryption() -> String {
            var pwd = pwd.cd_base64Decoding
            /// 头部删除
            pwd[0..<6] = ""
            /// 中间插入
            pwd[2..<8] = ""
            /// 尾部插入
            pwd[pwd.count-6..<pwd.count] = ""
            return pwd
        }
        return isEncryption ? encryption() : decryption()
    }
    
    /// Token
    var token:String {
        set{
            guard !account.isEmpty else {
                return
            }
            switch saveStyle {
            case .keychain:
                keychain[account+User.Keys.token] = newValue
            case .userDefaults:
                setUserDefaults(account+User.Keys.token, newValue)
            }
        }
        get{
            guard !account.isEmpty else {
                return ""
            }
            switch saveStyle {
            case .keychain:
                return keychain[account+User.Keys.token] ?? ""
            case .userDefaults:
                return userDefaults[account+User.Keys.token] as? String ?? ""
            }
        }
    }
    
    /// 上一次的登录标识
    var flag:Int {
        set{
            setUserDefaults(User.Keys.flag, newValue)
            /*
            switch saveStyle {
            case .keychain:
                keychain[User.Keys.flag] = newValue.stringValue
            case .userDefaults:
                setUserDefaults(User.Keys.flag, newValue)
            }*/
        }
        get{
            return userDefaults[User.Keys.flag] as? Int ?? 1
            /*
            switch saveStyle {
            case .keychain:
                return keychain[User.Keys.flag]?.intValue ?? 0
            case .userDefaults:
                return userDefaults[User.Keys.flag] as? Int ?? 0
            }*/
        }
    }
}

public extension User {
    /// 弃用：用户信息 - User.Info 枚举 key
    var infoJSON:[String:Any] {
        set{
            guard !account.isEmpty else {
                return
            }
            setUserDefaults(account+User.Keys.userInfo, newValue)
        }
        get{
            guard !account.isEmpty else {
                return [:]
            }
            return userDefaults[account+User.Keys.userInfo] as? [String:Any] ?? [:]
        }
    }
    
    /// 用户信息对应 - infoModel
    var infoData:Data? {
        set{
            guard !account.isEmpty else {
                return
            }
            guard newValue != nil else {
                setUserDefaults(account+User.Keys.userInfoData, Data())
                _infoDataModel = User.InfoModel()
                return
            }
            let decoder = CleanJSONDecoder()
            if let model = try? decoder.decode(User.InfoModel.self, from: newValue!),
                model.status == "2" {
                _infoDataModel = model
            }
            setUserDefaults(account+User.Keys.userInfoData, newValue)
        }
        get{
            guard !account.isEmpty else {
                return nil
            }
            return userDefaults[account+User.Keys.userInfoData] as? Data
        }
    }
    
    var info:User.InfoModel {
        set{
            _infoDataModel = newValue
            if let data = try? newValue.toJSON() {
                infoData = data
            }
        }
        get{
            return _infoDataModel
        }
    }
}

public extension User {
    enum notice:String , CaamDauNotificationProtocol{
        public var name: Notification.Name {
            return Notification.Name("User.sign." + self.rawValue)
        }
        /// 登录
        case signIn = "in"
        /// 注销
        case signOut = "out"
        /// 被踢下线
        case signForced = "forced"
        /// 注册
        case signUp = "up"
        /// 用户信息更新
        case infoUpdate = "infoupdate"
        case other = "other"
    }
    /// 登录
    func signIn(_ account:String, _ password:String, _ token:String, block:(()->Void)? = nil) {
        self.account = account
        self.password = password
        self.token = token
        block?()
        self.signStatus = 1
    }
    /// 注销登录
    func signOut(_ account:String, block:(()->Void)? = nil) {
        self.token = ""
        self.infoData = nil
        block?()
        self.signStatus = 0
    }
    /// 被踢下线
    func signForced(_ account:String, block:(()->Void)? = nil) {
        self.token = ""
        self.infoData = nil
        block?()
        self.signStatus = 2
    }
    /// 注册
    func signUp(_ account:String, _ password:String, block:(()->Void)? = nil) {
        self.account = account
        self.password = password
        block?()
        self.signStatus = 3
    }
    /// 用户信息更新
    func infoUpdate() {
        User.notice.infoUpdate.post()
    }
}
