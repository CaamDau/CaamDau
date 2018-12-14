//Created  on 2018/12/5  by LCD :https://github.com/liucaide .

import Foundation

func cd_readPlist(_ name:String = "CD_Config") -> [String:Any] {
    if let path = Bundle.main.path(forResource: name, ofType: "plist"){
        let info:[String:Any] = NSDictionary(contentsOfFile: path) as? [String : Any] ?? [:]
        return info
    }
    return [:]
}
