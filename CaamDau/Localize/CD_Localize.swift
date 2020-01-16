//Created  on 2019/7/1 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 * 国际化方式：本地文件 + 网络文件
 * 维护方式：字符串扩展、Hook
 *
 *
 * 1、选择语言包模式（本地、网络）
 * 2、将语言包本地数据持久化
 *
 */




import UIKit

public struct CD_Localize{
    private class Help {}
    fileprivate static var localJSON:[String : Any]? =  {
        let b = Bundle.cd_bundle(CD_Localize.Help.self, "Localize") ?? Bundle.main
        guard let path = b.path(forResource: "localize", ofType: "json") else { return nil }
        let info:[String:Any]? = NSDictionary(contentsOfFile: path) as? [String : Any]
        return info
    }()
    
    public static var lintJSON:[String : Any]?
    
    fileprivate static var config:[String : Any]? =  {
        return lintJSON ?? localJSON
    }()
}


extension String {
    var cd_localize:String {
        return CD_Localize.config?.string(self) ?? self
    }
}
