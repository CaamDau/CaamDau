import UIKit
import Foundation
import Util
import CD

//MARK:--- String ----------
do{
    var str = "jflka8234832jsdsdsd案件是飞洒的九分裤lkfj"
    str.cd_size(100.0, UIFont.systemFont(ofSize: 12))
    str.cd_size(100.0, Config.font.fontBold(16))
    str[5..<100]
    str[5..<100] = "99"
    str
    
}
//MARK:--- Date ----------
do{
    "2019.10.10".cd_date("yyyy.MM.dd")?.cd_timestamp()
}

//MARK:--- IconFont ----------
do{
    CD_IconFont.temoji(20).font
    CD_IconFont.temoji(20).text
    CD_IconFont.temoji(20).attributedString
}

//MARK:--- RegEx ----------
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

do{
    CD_RegEx.match("123", type: CD_RegEx.tPassword(CD_RegEx.Password.value0))
    CD_RegEx.match("123456", type: CD_RegEx.tPassword(CD_RegEx.Password.value0))
    CD_RegEx.match("a123", type: CD_RegEx.tPassword(CD_RegEx.Password.value1))
    CD_RegEx.match("a123456", type: CD_RegEx.tPassword(CD_RegEx.Password.value1))
    CD_RegEx.match("123", type: CD_RegEx.tPassword(CD_RegEx.Password.value2))
    CD_RegEx.match("123_456", type: CD_RegEx.tPassword(CD_RegEx.Password.value2))
    CD_RegEx.match("123_a456", type: CD_RegEx.tPassword(CD_RegEx.Password.value2))
    CD_RegEx.match("123_a@456", type: CD_RegEx.tPassword(CD_RegEx.Password.value2))
    
    CD_RegEx.match("1382828", type: CD_RegEx.tMobile(nil))
    CD_RegEx.match("13828282626", type: CD_RegEx.tMobile(nil))
    
    CD_RegEx.match("https://itunes.apple.com/cn/app/", type: CD_RegEx.tURL(nil))
    CD_RegEx.match("htt://itunes.apple.com/cn/app/", type: CD_RegEx.tURL(nil))
}
