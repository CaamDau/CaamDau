//Created  on 2018/12/5  by LCD :https://github.com/liucaide .

import Foundation
import UIKit
import CaamDau


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
        private static var colorDarks:[String : String] = {
            return configPlist["colorDark"] as? [String : String] ?? [:]
        }()
        
        private static func colorFit(_ name:String, _ place:String = "f0") -> UIColor {
            if #available(iOS 13.0, *) {
                return UIColor.init { (tr) -> UIColor in
                    switch tr.userInterfaceStyle {
                    case .light:
                        return UIColor.cd_hex(colors[name] ?? place)
                    case .dark:
                        return UIColor.cd_hex(colorDarks[name] ?? place)
                    default:
                        return UIColor.cd_hex(colors[name] ?? place)
                    }
                }
            } else {
                return UIColor.cd_hex(colors[name] ?? place)
            }
        }
        
        
        public static var navigation0:UIColor {
            return colorFit("navigation0")
        }
        
        public static var navigation1:UIColor {
            return colorFit("navigation1")
        }
        
        public static var tabbar0:UIColor {
            return colorFit("tabbar0")
        }
        
        public static var tabbar1:UIColor {
            return colorFit("tabbar1")
        }
        
        public static var main_1:UIColor {
            return colorFit("main_1")
        }
        
        public static var main_2:UIColor {
            return colorFit("main_2")
        }
        
        public static var main_3:UIColor {
            return colorFit("main_3")
        }
        
        public static var main_4:UIColor {
            return colorFit("main_4")
        }
        
        public static var main_5:UIColor {
            return colorFit("main_5")
        }
        
        public static var normal:UIColor {
            return colorFit("normal")
        }
        
        public static var selected:UIColor {
            return colorFit("selected")
        }
        
        public static var highlighted:UIColor {
            return colorFit("highlighted")
        }
        
        public static var enabledTrue:UIColor {
            return colorFit("enabledTrue")
        }
        
        public static var enabledFalse:UIColor {
            return colorFit("enabledFalse")
        }
        
        public static var txt_1:UIColor {
            return colorFit("txt_1")
        }
        
        public static var txt_2:UIColor {
            return colorFit("txt_2")
        }
        
        public static var txt_3:UIColor {
            return colorFit("txt_3")
        }
        
        public static var txt_4:UIColor {
            return colorFit("txt_4")
        }
        
        public static var txt_5:UIColor {
            return colorFit("txt_5")
        }
        
        public static var price:UIColor {
            return colorFit("price", "#ff00")
        }
        
        public static var bg:UIColor {
            return colorFit("bg")
        }
        
        public static var line_1:UIColor {
            return colorFit("line_1")
        }
        
        public static var line_2:UIColor {
            return colorFit("line_2")
        }
        
        public static var warning:UIColor {
            return colorFit("warning")
        }
        
        public static var error:UIColor {
            return colorFit("error")
        }
        
        public static var shadow:UIColor {
            return colorFit("shadow")
        }
        
        public static func hex(_ str:String, dark:String? = nil) ->UIColor {
            if #available(iOS 13.0, *) {
                return UIColor.init { (tr) -> UIColor in
                    switch tr.userInterfaceStyle {
                    case .light:
                        return UIColor.cd_hex(str)
                    case .dark:
                        return UIColor.cd_hex(dark ?? str)
                    default:
                        return UIColor.cd_hex(str)
                    }
                }
            } else {
                return UIColor.cd_hex(str)
            }
        }
    }
}

public extension Config {
    /// 字体
    struct font {
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
        
        public static var defaultt:String {
            return fonts["default"] as? String ?? ""
        }
        public static var medium:String {
            return fonts["medium"] as? String ?? ""
        }
        public static var bold:String {
            return fonts["bold"] as? String ?? ""
        }
        public static var thin:String {
            return fonts["thin"] as? String ?? ""
        }
        public static var regular:String {
            return fonts["regular"] as? String ?? ""
        }
        public static var semibold:String {
            return fonts["semibold"] as? String ?? ""
        }
        public static var ultralight:String {
            return fonts["ultralight"] as? String ?? ""
        }
        public static var light:String {
            return fonts["light"] as? String ?? ""
        }
        public static var heavy:String {
            return fonts["heavy"] as? String ?? ""
        }
        public static var black:String {
            return fonts["black"] as? String ?? ""
        }
        /// 此方法需要在App启动时 运行 设置，如果需要更高级的管理，可自行扩展
        public static func setFontFitSizeRatio(){
            switch CD.DeviceFit.mode {
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
            let font = UIFont(name: defaultt, size: size) ?? UIFont.systemFont(ofSize: size)
            return fit ? font.cd_fit() : font
        }
        public static func fontMedium(_ size:CGFloat, fit:Bool = false) -> UIFont {
            _ = setFit
            let font = UIFont(name: medium, size: size) ?? UIFont.systemFont(ofSize: size, weight: .medium)
            return fit ? font.cd_fit() : font
        }
        public static func fontBold(_ size:CGFloat, fit:Bool = false) -> UIFont {
            _ = setFit
            let font = UIFont(name: bold, size: size) ?? UIFont.systemFont(ofSize: size, weight: .bold)
            return fit ? font.cd_fit() : font
        }
        public static func fontThin(_ size:CGFloat, fit:Bool = false) -> UIFont {
            _ = setFit
            let font = UIFont(name: thin, size: size) ?? UIFont.systemFont(ofSize: size, weight: .thin)
            return fit ? font.cd_fit() : font
        }
        public static func fontRegular(_ size:CGFloat, fit:Bool = false) -> UIFont {
            _ = setFit
            let font = UIFont(name: regular, size: size) ?? UIFont.systemFont(ofSize: size, weight: .regular)
            return fit ? font.cd_fit() : font
        }
        public static func fontSemibold(_ size:CGFloat, fit:Bool = false) -> UIFont {
            _ = setFit
            let font = UIFont(name: semibold, size: size) ?? UIFont.systemFont(ofSize: size, weight: .semibold)
            return fit ? font.cd_fit() : font
        }
        public static func fontUltralight(_ size:CGFloat, fit:Bool = false) -> UIFont {
            _ = setFit
            let font = UIFont(name: ultralight, size: size) ?? UIFont.systemFont(ofSize: size, weight: .ultraLight)
            return fit ? font.cd_fit() : font
        }
        public static func fontLight(_ size:CGFloat, fit:Bool = false) -> UIFont {
            _ = setFit
            let font = UIFont(name: light, size: size) ?? UIFont.systemFont(ofSize: size, weight: .light)
            return fit ? font.cd_fit() : font
        }
        public static func fontHeavy(_ size:CGFloat, fit:Bool = false) -> UIFont {
            _ = setFit
            let font = UIFont(name: heavy, size: size) ?? UIFont.systemFont(ofSize: size, weight: .heavy)
            return fit ? font.cd_fit() : font
        }
        public static func fontBlack(_ size:CGFloat, fit:Bool = false) -> UIFont {
            _ = setFit
            let font = UIFont(name: black, size: size) ?? UIFont.systemFont(ofSize: size, weight: .black)
            return fit ? font.cd_fit() : font
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
            return (f/widthAxure)*CD.screenW
        }
    }
}

public extension Config {
    
    /// 图片
    struct placeholder {
        private static var placeholders:[String : String] = {
            return configPlist["placeholder"] as? [String : String] ?? [:]
        }()
        
        private static var placeholderUserIconBig:String {
            return placeholders["userIconBig"] ?? ""
        }
        private static var placeholderUserIconSmall:String {
            return placeholders["userIconSmall"] ?? ""
        }
        private static var placeholderBgBig:String {
            return placeholders["imgBig"] ?? ""
        }
        private static var placeholderBgSmall:String {
            return placeholders["imgSmall"] ?? ""
        }
        
        public static var iconBig:UIImage = {
            return UIImage.cd_bundle(placeholderUserIconBig, forClass:Config.Help.self, from:"Config")
        }()
        public static var iconSmall:UIImage = {
            return UIImage.cd_bundle(placeholderUserIconSmall, forClass:Config.Help.self, from:"Config")
        }()
        public static var imgBig:UIImage = {
            return UIImage.cd_bundle(placeholderBgBig, forClass:Config.Help.self, from:"Config")
        }()
        
        public static var imgSmall:UIImage = {
            return UIImage.cd_bundle(placeholderBgSmall, forClass:Config.Help.self, from:"Config")
        }()
    }
}

