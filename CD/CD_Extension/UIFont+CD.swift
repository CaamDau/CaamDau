//Created  on 2018/12/13  by LCD :https://github.com/liucaide .

import Foundation
import UIKit


public extension UIFont {
    public static var cd_fontFitSizeRatio:CGFloat = 0
    func fit() -> UIFont {
        return self.withSize(self.pointSize+UIFont.cd_fontFitSizeRatio)
    }
    
    //MARK:--- IconFont ----------
    /*
    ///IconFont 未使用pod 管理，需要在info.plist 中添加 Fonts provided by application
    static func iconFont(name:String, size:CGFloat) -> UIFont {
        guard let font = UIFont(name: name, size: size) else{
            assertionFailure("👉👉👉IconFont-请确认\(name).ttf 和 font-family是否配置正确  👻")
            return UIFont.systemFont(ofSize: size)
        }
        return font
    }*/
    
    ///IconFont name:font-family forClass:class  from: pod resource_bundles key
    static func iconFont(name:String, size:CGFloat, forClass:AnyClass? = nil, from:String = "") -> UIFont {
        if from.count > 0, let clas = forClass,  let bu = Bundle.cd_bundle(clas, from) {
            let path = String(format: "%@/%@.ttf", bu.bundlePath, name)
            return UIFont.iconFont(name: name, size: size, url:URL(fileURLWithPath: path))
        }
        else if let font = UIFont(name: name, size: size){
            return font
        }
        else{
            // 如果info.plist没有添加 Fonts provided by application 则可以直接检索 Bundle 读取
            guard let url = Bundle.main.url(forResource: name, withExtension: "ttf") else {
                assertionFailure("👉👉👉IconFont-请确认\(name).ttf 和 font-family是否配置正确  👻")
                return UIFont.systemFont(ofSize: size)
            }
            return UIFont.iconFont(name: name, size: size, url:url)
        }
    }
    
    ///IconFont name:font-family url: Bundle url
    static func iconFont(name:String, size:CGFloat, url:URL) -> UIFont {
        guard let data = try? Data(contentsOf: url) else {
            assertionFailure("👉👉👉IconFont- 失败  👻")
            return UIFont.systemFont(ofSize: size)
        }
        guard let provider = CGDataProvider.init(data: data as CFData) else {
            assertionFailure("👉👉👉IconFont- 失败  👻")
            return UIFont.systemFont(ofSize: size)
        }
        guard let fontCG = CGFont(provider) else{
            assertionFailure("👉👉👉IconFont- 失败  👻")
            return UIFont.systemFont(ofSize: size)
        }
        CTFontManagerRegisterGraphicsFont(fontCG, nil)
        guard let font = UIFont(name: name, size: size) else{
            assertionFailure("👉👉👉IconFont-请确认\(name).ttf 和 font-family是否配置正确  👻")
            return UIFont.systemFont(ofSize: size)
        }
        return font
    }
}
