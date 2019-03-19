import UIKit
import Foundation
import Config
import Assets
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
    
    CD_RegEx.match("itms-apps://itunes.apple.com/cn/app/", type: CD_RegEx.tURL(nil))
}
