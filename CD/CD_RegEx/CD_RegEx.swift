//Created  on 2019/2/17 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 * 基本正则表达式
 * 更多正则表达式以及练习 可供参考 https://c.runoob.com/front-end/854
 */




import Foundation


public extension CD_RegEx {
    enum Password {
        /// 弱密码 任意字母、数字、下划线 (不允许有除此之外的字符)
        /// ^\w{6,20}$
        case value0
        /// 中强密码 数字、字母、下划线必须包含两个组成 (不允许有除此之外的字符)
        /// ^(?=.*\d)(?=.*[a-zA-Z_])\w{6,20}$
        case value1
        /// 强密码 必须包含数字、字母/下划线、特殊字符 三种组合，长度在6-20之间
        /// 默认 ^(?=.*\d)(?=.*[a-zA-Z_])(?=.*\W).{6,20}$
        /// 密码键盘一般不会有中文
        /// ^(?=.*\d)(?=.*[a-zA-Z_])(?=.*\W)[^\u4e00-\u9fa5]{6,20}$
        case value2
        /// 匹配自定义
        case value3(_ pattern:String)
        
        var patternValue:String {
            switch self {
            case .value0:
                return "^\\w{6,20}$"
            case .value1:
                return "^(?=.*\\d)(?=.*[a-zA-Z_])\\w{6,20}$"
            case .value2:
                return "^(?=.*\\d)(?=.*[a-zA-Z_])(?=.*\\W).{6,20}$"
            case .value3(let p):
                return p
            }
        }
    }
    
    enum Name {
        /// 中英混用任意字符 ^.{2，12}$
        case value0
        ///中文名 ^[\u4e00-\u9fa5]{2,8}$
        case value1
        /// 小写字母、数字、下滑线、横杠，一共2~16个字符 ^[\w-]{2,12}$
        case value2
        /// 自定义匹配
        case value3(_ pattern:String)
        
        var patternValue:String {
            switch self {
            case .value0:
                return "^.{2，12}$"
            case .value1:
                return "^[\\u4e00-\\u9fa5]{2,8}$"
            case .value2:
                return "^[\\w-]{2,12}$"
            case .value3(let p):
                return p
            }
        }
    }
    
    enum IDCards {
        /// 🇨🇳大陆 6为地区码 8位生日(至2999年) 3位顺序吗 1位校验码
        /// ^[1-9]{2}[0-9]{4}[1-2]{1}[0-9]{3}[0-1]{1}[0-9]{1}[0-3]{1}[0-9]{1}[0-9]{3}([0-9]|X|x)$
        case zh_cn
        case zh_hk
        case zh_tw
        
        var patternValue:String {
            switch self {
            case .zh_cn:
                return "^[1-9]{2}[0-9]{4}[1-3]{1}[0-9]{3}[0-1]{1}[0-9]{1}[0-3]{1}[0-9]{1}[0-9]{3}([0-9]|X|x)$"
            default:
                return "^.$"
            }
        }
    }
}

public enum CD_RegEx {
    /// 纯小写
    case tLower
    
    /// 纯大写
    case tUpper
    
    /// 纯字母
    case tLetter
    
    /// 纯数字
    case tInt
    
    /// 银行卡 ^([1-9]{1})(\d{12}|\d{18})$
    case tBankCard
    
    /// URL验证 默认 "[a-zA-Z_-]+://[^\s]*"
    /// 使用了 canOpenURL 无法验证 app schemes
    case tURL(_ pattern:String?)
    
    /// 手机号码验证 默认包含国外号码 8-11位 ^1[0-9]{7,10}$
    case tMobile(_ pattern:String?)
    
    /// 密码
    case tPassword(_ pattern:CD_RegEx.Password?)
    
    ///Email 默认 ^\w+([-+.]\w+)*@\w+([-.]\w+)*\.([a-z\.]{2,6})$
    /// ^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$
    case tEmail(_ pattern:String?)
    
    /// 验证码 默认 ^[0-9]{4,6}
    case tCode(_ pattern:String?)
    
    ///用户名验证
    case tUserName(_ pattern:CD_RegEx.Name?)
    
    /// IP地址验证 默认 ^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$
    case tIP(_ pattern:String?)
    
    /// html标签验证 默认 <(\S*?)[^>]*>.*?|<.*? />
    case tHTML(_ pattern:String?)
    
    /// 身份证号码 默认 中国
    case tIDCard(_ pattern:CD_RegEx.IDCards?)
    
    /// 价格 默认 "^\d*\.?\d{0,2}$"
    case tPrice(_ pattern:String?)
    
    /// emoji 默认 \uD83C[\uDF00-\uDFFF]|\uD83D[\uDC00-\uDE4F]
    case tEmoji(_ pattern:String?)
    
    var patternValue:String {
        switch self {
        case .tLower:
            return "^[a-z]+$"
        case .tUpper:
            return "^[A-Z]+$"
        case .tLetter:
            return "^[a-zA-Z]+$"
        case .tInt:
            return "^[0-9]+$"
        case .tBankCard:
            return "^([1-9]{1})(\\d{14}|\\d{18})$"
        case .tURL(let p):
            return p ?? "[a-zA-Z_-]+://[^\\s]*"
        case .tMobile(let p):
            return p ?? "^1[0-9]{7,10}$"
        case .tPassword(let p):
            return p?.patternValue ?? CD_RegEx.Password.value0.patternValue
        case .tEmail(let p):
            return p ?? "^\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.([a-z\\.]{2,6})$"
        case .tCode(let p):
            return p ?? "^[0-9]{4,6}$"
        case .tUserName(let p):
            return p?.patternValue ?? Name.value0.patternValue
        case .tIP(let p):
            return p ?? "^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$"
        case .tHTML(let p):
            return p ?? "<(\\S*?)[^>]*>.*?|<.*? />"
        case .tIDCard(let e):
            return e?.patternValue ?? IDCards.zh_cn.patternValue
        case .tPrice(let p):
            return p ?? "^\\d*\\.?\\d{0,2}$"
        case .tEmoji(let p):
            return p ?? "\\uD83C[\\uDF00-\\uDFFF]|\\uD83D[\\uDC00-\\uDE4F]"
        }
    }
}

public extension CD_RegEx {
    private static func matchIDCards(_ string:String) -> Bool {
        // 0-5 地区码 440223
        // 6-13 日期 20190000
        guard string[6..<14].cd_date("yyyyMMdd") != nil else { return false }
        //guard date < Date() else {return false}
        // 14-18 日期 111X
        return true
    }
    private static func matchURL(_ string:String) -> Bool {
        guard let url = string.url else {
            return false
        }
        return UIApplication.shared.canOpenURL(url)
    }
    private static func matchBankCard(_ string:String) -> Bool {
        // Luhn 算法
        let arr = string.reversed().compactMap{String($0).int}
        guard arr.count >= 13, arr.count <= 19 else {
            return false
        }
        let result = arr.enumerated().reduce(into: (0, 0)) { (res, item) in
            var item = item
            if (item.offset+1) % 2 == 0 {
                item.element *= 2
                res.1 += (item.element >= 10 ? (item.element - 9) : item.element)
            }else{
                res.0 += item.element
            }
            
        }
        return (result.0 + result.1) % 10 == 0
    }
    
    static func match(_ string:String, type:CD_RegEx) -> Bool {
        switch type {
        case .tIDCard:
            guard CD_RegEx.match(string, pattern: type.patternValue) else {
                return false
            }
            guard CD_RegEx.matchIDCards(string) else {
                return false
            }
            return true
        case .tURL:
            guard CD_RegEx.match(string, pattern: type.patternValue) else {
                return false
            }
            guard CD_RegEx.matchURL(string) else {
                return false
            }
            return true
        case .tBankCard:
            guard CD_RegEx.match(string, pattern: type.patternValue) else {
                return false
            }
            guard CD_RegEx.matchBankCard(string) else {
                return false
            }
            return true
        default:
            return CD_RegEx.match(string, pattern: type.patternValue)
        }
    }
    
    static func match(_ string:String, pattern:String) -> Bool {
        return CD.makeRegEx(pattern)?.cd.match(string) ?? false
    }
}
