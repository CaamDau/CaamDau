import UIKit
import Foundation
import CD


//MARK:--- 正则 ----------
public extension CD where Base: NSTextCheckingResult {
    /// 返回匹配字符串
    @discardableResult
    func string(in string:String) -> String {
        let start = base.range.location
        let end = base.range.location + base.range.length
        return string[start..<end]
    }
    /// 返回匹配 Range
    @discardableResult
    func range(in string:String) -> Range<String.Index>? {
        return Range(base.range, in: string)
    }
    /// 返回捕获的匹配组
    @discardableResult
    func captures(in string:String) -> Array<String>? {
        // stride(from:to:by:)返回从起始值到（但不包括）结束值的序列
        return stride(from: 0, to: base.numberOfRanges, by: 1)
            .compactMap(base.range)
            .dropFirst()
            .compactMap{Range($0, in: string)}
            .compactMap{String(describing:string[$0])}
    }
    /// 返回一个新字符串，根据“模板”替换匹配的字符串。
    @discardableResult
    func replace(in string:String, template: String) -> String {
        let replacement = base.regularExpression?.replacementString(for:base, in:string, offset: 0, template: template) ?? string
        
        return replacement
    }
}

public extension NSRegularExpression {
    static func cd_init(_ pattern: String, options: NSRegularExpression.Options = []) -> NSRegularExpression? {
        return CD.makeRegEx(pattern, options:options)
    }
}

public extension CD where Base: NSRegularExpression {
    /// 初始化 NSRegularExpression
    /// .caseInsensitive 忽略字母、不区分大小写的\n
    /// .allowCommentsAndWhitespace 忽略空格、# -
    /// .ignoreMetacharacters 整体化
    /// .dotMatchesLineSeparators 允许“.”匹配任何字符，包括换行符，(默认情况下,"."匹配除换行符(\n)之外的所有字符。使用这个配置，选项将允许“.”匹配换行符)
    /// .anchorsMatchLines 默认情况下,“^”匹配字符串的开始和结束的“$”匹配字符串,无视任何换行。使用这个配置，“^”将匹配的每一行的开始,和“$”将匹配的每一行的结束。
    /// .useUnixLineSeparators 仅\n作为行分隔符处理（否则，使用所有标准行分隔符）
    /// .useUnicodeWordBoundaries 使用Unicode TR#29指定字边界（否则，使用传统的正则表达式字边界）
    static func makeRegEx(_ pattern: String, options: NSRegularExpression.Options = []) -> NSRegularExpression? {
        guard let regular = try? NSRegularExpression(pattern: pattern, options: options) else {
            return nil
        }
        return regular
    }
    /// 正则匹配
    @discardableResult
    func match(_ string: String) -> Bool {
        return self.match(firstIn: string) != nil
    }
    /// 获取第一个匹配结果
    @discardableResult
    func match(firstIn string:String, options: NSRegularExpression.MatchingOptions = []) -> NSTextCheckingResult? {
        return base.firstMatch(in: string, options: options, range: NSRange(location: 0, length: string.utf16.count))
    }
    /// 获取所有匹配结果
    @discardableResult
    func match(allIn string:String, options: NSRegularExpression.MatchingOptions = []) -> [NSTextCheckingResult] {
        // 与 enumerateMatches(in:options:range:using:) 返回所有匹配 无差
        return base
            .matches(in: string, options: options, range: NSRange(location: 0, length: string.utf16.count))
            .compactMap{$0}
    }
    /// 正则替换
    @discardableResult
    func match(replaceIn string:String, with template:String, count: Int? = nil, options: NSRegularExpression.MatchingOptions = []) -> String {
        var output = string
        let matches = self.match(allIn: string, options:options)
        let ranged = Array(matches[0..<Swift.min(matches.count, count ?? .max)])
        
        ranged
            .reversed()
            .filter {$0.cd.range(in: string) != nil}
            .compactMap { output.replaceSubrange($0.cd.range(in: string)!, with: $0.cd.replace(in: string, template: template)) }
        //output[$0.cd.range(in: string)!.lowerBound.encodedOffset..<$0.cd.range(in: string)!.upperBound.encodedOffset] = $0.cd.replace(in: string, template: template)
        
        /*
        for item in ranged.reversed() {
            let replacement = item.cd.replace(in: string, template: template)
            if let range = item.cd.range(in: string) {
                output.replaceSubrange(range, with: replacement)
            }
        }*/
        return output
    }
    
    /// 获取匹配
    @discardableResult
    func match(numIn string:String, range:Range<Int>? = nil, options: NSRegularExpression.MatchingOptions = []) -> Int {
        return base.numberOfMatches(in: string, options: [], range: (range != nil) ? NSMakeRange(range!.lowerBound, range!.upperBound) : NSMakeRange(0,string.count))
    }
}

//----- 示例 ----------

do{//验证一个邮箱地址的格式是否正确。
    let pattern = "^([a-z0-9_\\.-]+)@([\\da-z\\.-]+)\\.([a-z\\.]{2,6})$"
    let email = "liu_cai_de@qq.163.com"
    if (CD.makeRegEx(pattern)?.cd.match(allIn: email)) != nil {
        _ = true
    }else{
        _ = false
    }
    if CD.makeRegEx(pattern)!.cd.match(email) {
        _ = true
    }else{
        _ = false
    }
}


do{// 获取第一个匹配结果
    let pattern = "([\\u4e00-\\u9fa5]+):([\\d]+)"
    let str = "张三:123456 66,99 ,我的， 李四:23457,王麻子:110987 9"
    if let text = CD.makeRegEx(pattern)?.cd.match(firstIn: str) {
        //print(text.cd.range(in: str))
        text.cd.string(in: str)
        text.cd.captures(in: str)
        text.cd.captures(in: str)![0]
        text.cd.captures(in: str)![1]
    }else{
        _ = false
    }
}


do{// 获取所有匹配结果
    let pattern = "([\\u4e00-\\u9fa5]+):([\\d]+)"
    let str = "张三:123456 66,99 ,我的， 李四:23457,王麻子:110987 9"
    if let text = CD.makeRegEx(pattern)?.cd.match(allIn: str) {
        text.map{$0.cd.string(in: str)}
        text.map{$0.cd.captures(in: str)![0]}
        text.map{$0.cd.captures(in: str)![1]}
    }else{
        _ = false
    }
}


do{// ----- 字符串替换
    let pattern = "([\\u4e00-\\u9fa5]+):([\\d]+)"
    let str = "张三:123456 66,99 ,我的， 李四:23457,王麻子:110987 9"
    CD.makeRegEx(pattern)!.cd.match(replaceIn: str, with: "***", count: 1)
    CD.makeRegEx(pattern)!.cd.match(replaceIn: str, with: "***")
    CD.makeRegEx(pattern)!.cd.match(replaceIn: str, with: "***", count: 9)
}
do{//捕获组替换
    let pattern = "([\\u4e00-\\u9fa5]+):([\\d]+)"
    let str = "张三:123456 66,99 ,我的， 李四:23457,王麻子:110987 9"
    CD.makeRegEx(pattern)!.cd.match(replaceIn: str, with: "$1的编号是$2", count: 1)
    CD.makeRegEx(pattern)!.cd.match(replaceIn: str, with: "$1的编号是$2")
    CD.makeRegEx(pattern)!.cd.match(replaceIn: str, with: "$1的编号是$2", count: 9)
}

/// 更多正则表达式 可供参考 https://c.runoob.com/front-end/854
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
                return ""
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
    
    /// URL验证 默认 "[a-zA-z]+://[^\s]*"
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
            print("let url = string.url")
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
                print("tURL.match.false")
                return false
            }
            guard CD_RegEx.matchURL(string) else {
                print("matchURL.false")
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

extension String {
    func cd_regex(_ pattern:String) -> Bool {
        return CD.makeRegEx(pattern)?.cd.match(pattern) ?? false
    }
}

/*
do{
    let str = "62220"
    let arr = str.reversed().compactMap{Int(String($0))}
    print(arr)
    let result = arr.enumerated().reduce(into: (0, 0)) { (res, item) in
        var item = item
        print("offset->",item.offset+1)
        print("element->",item.element)
        print("res-1->",res)
        if (item.offset+1) % 2 == 0 {
            item.element *= 2
            res.1 += (item.element >= 10 ? (item.element - 9) : item.element)
        }else{
            res.0 += item.element
        }
        print("res-2->",res)
    }
    let bool = (result.0 + result.1) % 10 == 0
    bool
}
*/
do{
    CD_RegEx.match("123", type: CD_RegEx.tPassword(CD_RegEx.Password.value0))
    CD_RegEx.match("123456", type: CD_RegEx.tPassword(CD_RegEx.Password.value0))
    CD_RegEx.match("a123", type: CD_RegEx.tPassword(CD_RegEx.Password.value1))
    CD_RegEx.match("a123456", type: CD_RegEx.tPassword(CD_RegEx.Password.value1))
    CD_RegEx.match("123", type: CD_RegEx.tPassword(CD_RegEx.Password.value2))
    CD_RegEx.match("123_456", type: CD_RegEx.tPassword(CD_RegEx.Password.value2))
    CD_RegEx.match("123_a456", type: CD_RegEx.tPassword(CD_RegEx.Password.value2))
    CD_RegEx.match("123a@456", type: CD_RegEx.tPassword(CD_RegEx.Password.value2))
    
    UIApplication.shared.open(URL(string: "wechat://")!, options: [:]) { (bool) in
        bool
    }
    
    CD_RegEx.match("wechat://itunes.apple.com/cn/app/", type: CD_RegEx.tURL(nil))
}
