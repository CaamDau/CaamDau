//Created  on 2018/12/13  by LCD :https://github.com/liucaide .


import Foundation
import UIKit

//MARK:--- 脚本 ----------
public extension String {
    /// 下标脚本
    /// 插入 var str = "1234", str[1..<1] = "345", print(str) //1345234
    /// 替换 str[1...4] = "000", print(str) //100034
    /// 删除 str[1...3] = "" print(str) //134
    /// 取子串 let subStr = str[0...1], print(subStr) //13
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


public extension String{
    /// base64编码
    public var cd_base64Encoding:String {
        let data = self.data(using:.utf8)
        let base64 = data?.base64EncodedString()
        return base64 ?? self
    }
    /// base64解码
    public var cd_base64Decoding:String {
        guard let data = Data(base64Encoded: self) else {
            return self
        }
        let str = String(data: data , encoding: .utf8)
        return str ?? self
    }
}

//MARK:---------- 汉字转拼音
public extension String {
    /// 只转拼音
    func cd_pinyin(remove diacritics:Bool = true)->String{
        let mutableString = NSMutableString(string: self)
        CFStringTransform(mutableString  as CFMutableString, nil, kCFStringTransformToLatin, false)
        if diacritics {
            CFStringTransform(mutableString, nil, kCFStringTransformStripDiacritics, false)
        }
        return String(mutableString)
        //mutableString.folding(options: .diacriticInsensitive, locale: .current)
        //CFStringTransform(mutableString, nil, kCFStringTransformStripCombiningMarks, false)
        //string = string.capitalized
        // 首字母大写
        //var str1 = string.replacingOccurrences(of: " ", with: "")
        //str1 = str1.capitalized
        //return str1
    }
    /// 转拼音 取首字母
    func cd_pinyinFirst(_ clear:Bool = true, capitalized:Bool = true, placeholder:String = "#")->String{
        guard !self.isEmpty else { return placeholder }
        var f = self
        if clear {
            f = f.replacingOccurrences(of: " ", with: "")
        }
        guard !f.isEmpty else { return placeholder }
        f = String(f.first!)
        f = f.cd_pinyin()
        if capitalized {
            f = f.capitalized
        }
        return String(f.first!)
    }
}


//MARK:--- 字符串宽高计算 ----------
public extension String {
    ///限制最大行数的场景下，计算Label的bounds
    func cd_size( maxWidth: CGFloat, _ font: UIFont, _ maxLine: Int) -> CGSize {
        return CD_StringSize.shared.calculateSize(withString: self, maxWidth: maxWidth, font: font, maxLine: maxLine)
    }
    ///行数不限的场景下，计算Label的bounds
    func cd_size(_ maxWidth: CGFloat, _ font: UIFont) -> CGSize {
        return CD_StringSize.shared.calculateSize(withString: self, maxWidth: maxWidth, font: font)
    }
    
    ///限定最大高度的场景下，计算Label的bounds
    func cd_size(_ maxSize: CGSize, _ font: UIFont) -> CGSize {
        return CD_StringSize.shared.calculateSize(withString: self, maxSize: maxSize, font: font)
    }
}



















//MARK:--- 这是私有的 ----------
// 代码借鉴来源：https://github.com/577528249/StringCalculate
private class CD_StringSize {
    static let shared = CD_StringSize()
    //fontDictionary是一个Dictionary，例如{".SFUIText-Semibold-16.0": {"0":10.3203125, "Z":10.4140625, "国":16.32, "singleLineHeight":19.09375}}，
    //fontDictionary的key是以字体的名字和大小拼接的String，例如".SFUIText-Semibold-16.0"
    //fontDictionary的value是一个Dictionary，存储对应字体的各种字符对应的宽度及字体的单行高度，例如{"0":10.3203125, "Z":10.4140625, "国":16.32, "singleLineHeight":19.09375}
    var fontDictionary = [String: [String: CGFloat]]()
    var numsNeedToSave = 0//更新的数据的条数
    var fileUrl: URL = {//fontDictionary在磁盘中的存储路径
        let manager = FileManager.default
        var filePath = manager.urls(for: .documentDirectory, in: .userDomainMask).first
        filePath!.appendPathComponent("cd_stringSize_font_dictionary.json")
        print_cd("cd_stringSize_font_dictionary.json的路径是===\(filePath!)")
        return filePath!
    }()
    
    init() {
        readFontDictionaryFromDisk()
        NotificationCenter.default.addObserver(self, selector: #selector(saveFontDictionaryToDisk), name: UIApplication.didEnterBackgroundNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(saveFontDictionaryToDisk), name: UIApplication.willTerminateNotification, object: nil)
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    //第一次使用字体时预先计算该字体中各种字符的宽度
    func createNewFont(font: UIFont) -> [String: CGFloat] {
        let array: [String] = ["国", "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P",  "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "a", "b", "c", "d", "e",  "f",  "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "“", ";", "?", ",", "［", "]", "？", "、", "【", "】", "!", ":", "|"]
        var widthDictionary = [String: CGFloat]()
        var singleWordRect = CGRect.zero
        for string in array {
            singleWordRect = string.boundingRect(with: CGSize(width: 100, height: 100),
                                                 options: .usesLineFragmentOrigin,
                                                 attributes: [NSAttributedString.Key.font: font],
                                                 context: nil)
            widthDictionary[string] = singleWordRect.size.width
        }
        widthDictionary["singleLineHeight"] = singleWordRect.size.height
        let fontKey = "\(font.fontName)-\(font.pointSize)"
        fontDictionary[fontKey] = widthDictionary
        numsNeedToSave = array.count//代表有更新，需要存入到磁盘
        saveFontDictionaryToDisk()//存入本地json
        return widthDictionary
    }
    //限定最大行数的场景下计算Label的bounds
    func calculateSize(withString string: String, maxWidth: CGFloat, font: UIFont, maxLine: Int) -> CGSize {
        let totalWidth: CGFloat = calculateTotalWidth(string: string, font: font)
        var widthDictionary = fetchWidthDictionaryWith(font)
        let singleLineHeight = widthDictionary["singleLineHeight"]!
        let numsOfLine = ceil(totalWidth/maxWidth)//行数
        let maxLineCGFloat = CGFloat(maxLine)//最大
        let resultwidth = numsOfLine <= 1 ? totalWidth : maxWidth//小于最大宽度时，取实际宽度的值
        let resultLine = numsOfLine < maxLineCGFloat ? numsOfLine : maxLineCGFloat
        return CGSize(width: resultwidth, height: resultLine * singleLineHeight)
    }
    
    //行数不限的场景下计算Label的bounds
    func calculateSize(withString string: String, maxWidth: CGFloat, font: UIFont) -> CGSize {
        let totalWidth: CGFloat = calculateTotalWidth(string: string, font: font)
        var widthDictionary = fetchWidthDictionaryWith(font)
        let singleLineHeight = widthDictionary["singleLineHeight"]!
        let numsOfLine = ceil(totalWidth/maxWidth)//行数
        let resultwidth = numsOfLine <= 1 ? totalWidth : maxWidth//小于最大宽度时，取实际宽度的值
        return CGSize(width: resultwidth, height: numsOfLine * singleLineHeight)
    }
    
    //限定最大高度的场景下计算Label的bounds
    func calculateSize(withString string: String, maxSize: CGSize, font: UIFont) -> CGSize {
        let totalWidth: CGFloat = calculateTotalWidth(string: string, font: font)
        var widthDictionary = fetchWidthDictionaryWith(font)
        let singleLineHeight = widthDictionary["singleLineHeight"]!
        let numsOfLine = ceil(totalWidth/maxSize.width)//行数
        let maxLineCGFloat = floor(maxSize.height/singleLineHeight)
        let resultwidth = numsOfLine <= 1 ? totalWidth : maxSize.width//小于最大宽度时，取实际宽度的值
        let resultLine = numsOfLine < maxLineCGFloat ? numsOfLine : maxLineCGFloat
        return CGSize(width: resultwidth, height: resultLine * singleLineHeight)
    }
    
    //计算排版在一行的总宽度
    func calculateTotalWidth(string: String, font: UIFont) -> CGFloat {
        var totalWidth: CGFloat = 0
        let fontKey = "\(font.fontName)-\(font.pointSize)"
        var widthDictionary = fetchWidthDictionaryWith(font)
        let chineseWidth = widthDictionary["国"]!
        for character in string {
            if "\u{4E00}" <= character  && character <= "\u{9FA5}" {//中文
                totalWidth += chineseWidth
            } else if let width = widthDictionary[String(character)]  {//数字，小写字母，大写字母，及常见符号
                totalWidth += width
            } else {//符号及其他没有预先计算好的字符，对它们进行计算并且缓存到宽度字典中去
                let tempString = String(character)
                let width = tempString.boundingRect(with: CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude),
                                                    options: .usesLineFragmentOrigin,
                                                    attributes: [NSAttributedString.Key.font: font],
                                                    context: nil).size.width
                totalWidth += width
                widthDictionary[tempString] = width
                numsNeedToSave += 1
            }
        }
        fontDictionary[fontKey] = widthDictionary
        if numsNeedToSave > 10 {
            saveFontDictionaryToDisk()
        }
        return totalWidth
    }
    
    //获取字体对应的宽度字典
    func fetchWidthDictionaryWith(_ font: UIFont) -> [String: CGFloat] {
        var widthDictionary = [String: CGFloat]()
        let fontKey = "\(font.fontName)-\(font.pointSize)"
        if let dictionary =  CD_StringSize.shared.fontDictionary[fontKey] {
            widthDictionary = dictionary
        } else {
            widthDictionary = CD_StringSize.shared.createNewFont(font: font)
        }
        return widthDictionary
    }
    
    let queue = DispatchQueue(label: "com.CD_StringSize.queue")
    //存储fontDictionary到磁盘
    @objc func saveFontDictionaryToDisk() {
        guard numsNeedToSave > 0 else {
            return
        }
        numsNeedToSave = 0
        queue.async {//防止多线程同时写入造成冲突
            do {
                var data: Data?
                if #available(iOS 11.0, *) {
                    data = try? JSONSerialization.data(withJSONObject: self.fontDictionary, options: .sortedKeys)
                } else {
                    data = try? JSONSerialization.data(withJSONObject: self.fontDictionary, options: .prettyPrinted)
                }
                try data?.write(to: self.fileUrl)
                print_cd("font_dictionary存入磁盘,font_dictionary=\("self.fontDictionary")")
            }  catch {
                print_cd("font_dictionary存储失败error=\(error)")
            }
        }
    }
    //从磁盘中读取缓存
    func readFontDictionaryFromDisk() {
        do {
            guard let data = try? Data.init(contentsOf: fileUrl),
                let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments),
                let dict = json as? [String: [String: CGFloat]] else {
                return
            }
            fontDictionary = dict
            //print_cd(fontDictionary)
            print_cd("font_dictionarys读取成功,font_dictionarys=\("fontDictionary")")
        } catch {
            print_cd("第一次运行时font_dictionary不存在或者读取失败")
        }
    }
}
