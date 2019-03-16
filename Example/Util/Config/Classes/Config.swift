//Created  on 2018/12/5  by LCD :https://github.com/liucaide .

import Foundation
import UIKit
import CD


public struct Config{
    private static let isPod:Bool = true
    private class Help {}
    private static var configPlist:[String : Any] =  {
        if isPod {
            let b = Bundle.cd_bundle(Config.Help.self, "Config")
            if let path = b?.path(forResource: "config", ofType: "plist") {
                let info:[String:Any] = NSDictionary(contentsOfFile: path) as? [String : Any] ?? [:]
                return info
            }
            return [:]
        }else{
            if let path = Bundle.main.path(forResource: "config", ofType: "plist"){
                let info:[String:Any] = NSDictionary(contentsOfFile: path) as? [String : Any] ?? [:]
                return info
            }
            return [:]
        }
        
    }()
}


public extension Config {
    /// 颜色
    struct color {
        private static var colors:[String : String] = {
            return configPlist["color"] as? [String : String] ?? [:]
        }()
        
        public static var main_1:UIColor {
            return UIColor.cd_hex(colors["main_1"] ?? "#f0")
        }
        public static var main_2:UIColor {
            return UIColor.cd_hex(colors["main_2"] ?? "#f0")
        }
        public static var main_3:UIColor {
            return UIColor.cd_hex(colors["main_3"] ?? "#f0")
        }
        public static var main_4:UIColor {
            return UIColor.cd_hex(colors["main_4"] ?? "#f0")
        }
        public static var main_5:UIColor {
            return UIColor.cd_hex(colors["main_5"] ?? "#f0")
        }
        public static var btnBgSelected:UIColor {
            return UIColor.cd_hex(colors["btnBgSelected"] ?? "#f0")
        }
        public static var btnBgNormal:UIColor {
            return UIColor.cd_hex(colors["btnBgNormal"] ?? "#f0")
        }
        public static var btnBgEnabledNo:UIColor {
            return UIColor.cd_hex(colors["btnBgEnabledNo"] ?? "#f0")
        }
        public static var btnBgEnabledYes:UIColor {
            return UIColor.cd_hex(colors["btnBgEnabledYes"] ?? "#f0")
        }
        public static var btnBgHighlighted:UIColor {
            return UIColor.cd_hex(colors["btnBgHighlighted"] ?? "#f0")
        }
        public static var txt_1:UIColor {
            return UIColor.cd_hex(colors["txt_1"] ?? "#f0")
        }
        public static var txt_2:UIColor {
            return UIColor.cd_hex(colors["txt_2"] ?? "#f0")
        }
        public static var txt_3:UIColor {
            return UIColor.cd_hex(colors["txt_3"] ?? "#f0")
        }
        public static var txt_4:UIColor {
            return UIColor.cd_hex(colors["txt_4"] ?? "#f0")
        }
        public static var txt_5:UIColor {
            return UIColor.cd_hex(colors["txt_5"] ?? "#f0")
        }
        public static var bg:UIColor {
            return UIColor.cd_hex(colors["bg"] ?? "#f0")
        }
        public static var line_1:UIColor {
            return UIColor.cd_hex(colors["line_1"] ?? "#f0")
        }
        public static var line_2:UIColor {
            return UIColor.cd_hex(colors["line_2"] ?? "#f0")
        }
        public static var warning:UIColor {
            return UIColor.cd_hex(colors["warning"] ?? "#f0")
        }
        public static var error:UIColor {
            return UIColor.cd_hex(colors["error"] ?? "#f0")
        }
        public static var shadow:UIColor {
            return UIColor.cd_hex(colors["shadow"] ?? "#f0")
        }
    }
}

public extension Config {
    /// 字体
    public struct font {
        private static var fonts:[String : Any] = {
            return configPlist["font"] as? [String : Any] ?? [:]
        }()
        
        public static var fitSizeiPad:CGFloat {
            return CGFloat(fonts["fitSizeiPad"] as? Float ?? 0)
        }
        public static var fitSizeiPhone320:CGFloat {
            return CGFloat(fonts["fitSizeiPhone320"] as? Float ?? 0)
        }
        public static var fitSizeiPhone375:CGFloat {
            return CGFloat(fonts["fitSizeiPhone375"] as? Float ?? 0)
        }
        public static var fitSizeiPhone414:CGFloat {
            return CGFloat(fonts["fitSizeiPhone414"] as? Float ?? 0)
        }
        
        public static var name:String {
            return fonts["name"] as? String ?? ""
        }
        public static var nameMedium:String {
            return fonts["nameMedium"] as? String ?? ""
        }
        public static var nameBold:String {
            return fonts["nameBold"] as? String ?? ""
        }
        public static var nameThin:String {
            return fonts["nameThin"] as? String ?? ""
        }
        public static var nameRegular:String {
            return fonts["nameRegular"] as? String ?? ""
        }
        public static var nameSemibold:String {
            return fonts["nameSemibold"] as? String ?? ""
        }
        public static var nameUltralight:String {
            return fonts["nameUltralight"] as? String ?? ""
        }
        public static var nameLight:String {
            return fonts["nameLight"] as? String ?? ""
        }
        public static var nameHeavy:String {
            return fonts["nameHeavy"] as? String ?? ""
        }
        public static var nameBlack:String {
            return fonts["nameBlack"] as? String ?? ""
        }
        /// 此方法需要在App启动时 运行 设置，如果需要更高级的管理，可自行扩展
        public static func setFontFitSizeRatio(){
            switch CD_DeviceFit.mode {
            case .iPad:
                UIFont.cd_fontFitSizeRatio = fitSizeiPad
            case .iPhone320:
                UIFont.cd_fontFitSizeRatio = fitSizeiPhone320
            case .iPhone375:
                UIFont.cd_fontFitSizeRatio = fitSizeiPhone375
            case .iPhone414:
                UIFont.cd_fontFitSizeRatio = fitSizeiPhone414
            default:
                UIFont.cd_fontFitSizeRatio = fitSizeiPhone375
            }
        }
        
        public static let setFit:Void = {
            setFontFitSizeRatio()
            return ()
        }()
        
        public static func font(_ size:CGFloat, fit:Bool = false) -> UIFont {
            _ = setFit
            let font = UIFont(name: name, size: size) ?? UIFont.systemFont(ofSize: size)
            return fit ? font.fit() : font
        }
        public static func fontMedium(_ size:CGFloat, fit:Bool = false) -> UIFont {
            _ = setFit
            let font = UIFont(name: nameMedium, size: size) ?? UIFont.systemFont(ofSize: size, weight: UIFont.Weight.medium)
            return fit ? font.fit() : font
        }
        public static func fontBold(_ size:CGFloat, fit:Bool = false) -> UIFont {
            _ = setFit
            let font = UIFont(name: nameBold, size: size) ?? UIFont.systemFont(ofSize: size, weight: UIFont.Weight.bold)
            return fit ? font.fit() : font
        }
        public static func fontThin(_ size:CGFloat, fit:Bool = false) -> UIFont {
            _ = setFit
            let font = UIFont(name: nameThin, size: size) ?? UIFont.systemFont(ofSize: size, weight: UIFont.Weight.thin)
            return fit ? font.fit() : font
        }
        public static func fontRegular(_ size:CGFloat, fit:Bool = false) -> UIFont {
            _ = setFit
            let font = UIFont(name: nameRegular, size: size) ?? UIFont.systemFont(ofSize: size, weight: UIFont.Weight.regular)
            return fit ? font.fit() : font
        }
        public static func fontSemibold(_ size:CGFloat, fit:Bool = false) -> UIFont {
            _ = setFit
            let font = UIFont(name: nameSemibold, size: size) ?? UIFont.systemFont(ofSize: size, weight: UIFont.Weight.semibold)
            return fit ? font.fit() : font
        }
        public static func fontUltralight(_ size:CGFloat, fit:Bool = false) -> UIFont {
            _ = setFit
            let font = UIFont(name: nameUltralight, size: size) ?? UIFont.systemFont(ofSize: size, weight: UIFont.Weight.ultraLight)
            return fit ? font.fit() : font
        }
        public static func fontLight(_ size:CGFloat, fit:Bool = false) -> UIFont {
            _ = setFit
            let font = UIFont(name: nameLight, size: size) ?? UIFont.systemFont(ofSize: size, weight: UIFont.Weight.light)
            return fit ? font.fit() : font
        }
        public static func fontHeavy(_ size:CGFloat, fit:Bool = false) -> UIFont {
            _ = setFit
            let font = UIFont(name: nameHeavy, size: size) ?? UIFont.systemFont(ofSize: size, weight: UIFont.Weight.heavy)
            return fit ? font.fit() : font
        }
        public static func fontBlack(_ size:CGFloat, fit:Bool = false) -> UIFont {
            _ = setFit
            let font = UIFont(name: nameBlack, size: size) ?? UIFont.systemFont(ofSize: size, weight: UIFont.Weight.black)
            return fit ? font.fit() : font
        }
    }
}

public extension Config {
    /// 适配
    struct fit {
        private static var fits:[String : Any] = {
            return configPlist["fit"] as? [String : Any] ?? [:]
        }()
        
        public static var widthAxure:CGFloat {
            return CGFloat(fits["widthAxure"] as? Float ?? 375.0)
        }
        
        public static func fit(_ f:CGFloat) -> CGFloat {
            return (f/widthAxure)*cd_screenW()
        }
    }
}

public extension Config {
    /// 图片
    struct image {
        private static var images:[String : String] = {
            return configPlist["image"] as? [String : String] ?? [:]
        }()
        
        public static var placeholderUserIconBig:String {
            return images["placeholderUserIconBig"] ?? ""
        }
        public static var placeholderUserIconSmall:String {
            return images["placeholderUserIconSmall"] ?? ""
        }
        public static var placeholderBgBig:String {
            return images["placeholderBgBig"] ?? ""
        }
        public static var placeholderBgSmall:String {
            return images["placeholderBgSmall"] ?? ""
        }
        public static var placeholderBgBigRectangle:String {
            return images["placeholderBgBigRectangle"] ?? ""
        }
        public static var placeholderBgSmallRectangle:String {
            return images["placeholderBgSmallRectangle"] ?? ""
        }
    }
}

