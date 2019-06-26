//Created  on 2019/2/17 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 * 正则表达式扩展
 */




import Foundation

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
        
        /*/ranged
            .reversed()
            .filter {$0.cd.range(in: string) != nil}
            .compactMap { output.replaceSubrange($0.cd.range(in: string)!, with: $0.cd.replace(in: string, template: template)) }*/
        //output[$0.cd.range(in: string)!.lowerBound.encodedOffset..<$0.cd.range(in: string)!.upperBound.encodedOffset] = $0.cd.replace(in: string, template: template)
        
        for item in ranged.reversed() {
            let replacement = item.cd.replace(in: string, template: template)
            if let range = item.cd.range(in: string) {
                output.replaceSubrange(range, with: replacement)
            }
        }
        return output
    }
    
    /// 获取匹配
    @discardableResult
    func match(numIn string:String, range:Range<Int>? = nil, options: NSRegularExpression.MatchingOptions = []) -> Int {
        return base.numberOfMatches(in: string, options: [], range: (range != nil) ? NSMakeRange(range!.lowerBound, range!.upperBound) : NSMakeRange(0,string.count))
    }
}


public extension String {
    func cd_regex(_ pattern:String) -> Bool {
        return CD.makeRegEx(pattern)?.cd.match(self) ?? false
    }
}
