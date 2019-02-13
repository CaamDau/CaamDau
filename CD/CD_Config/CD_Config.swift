//Created  on 2018/12/5  by LCD :https://github.com/liucaide .

import Foundation
import UIKit
/*
func cd_readPlist(_ name:String = "CD_Config") -> [String:Any] {
    if let path = Bundle.main.path(forResource: name, ofType: "plist"){
        let info:[String:Any] = NSDictionary(contentsOfFile: path) as? [String : Any] ?? [:]
        return info
    }
    return [:]
}
*/

public struct CD_Config{
    class Help {}
    static var configPlist:[String : Any] =  {
        let b = Bundle.cd_bundle(CD_Config.Help.self, "CD_Config")
        if let path = b?.path(forResource: "CD_Config", ofType: "plist") {
            let info:[String:Any] = NSDictionary(contentsOfFile: path) as? [String : Any] ?? [:]
            return info
        }
        return [:]
    }()
    
    
    static var color_main_1:UIColor = {
        return UIColor.red
    }()
}

