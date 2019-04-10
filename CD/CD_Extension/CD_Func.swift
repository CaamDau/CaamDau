//Created  on 2018/12/11  by LCD :https://github.com/liucaide .

import Foundation
import UIKit
import AdSupport

//MARK:--- 打印 ----------
#if DEBUG
public func print_cd(_ items: Any...){
    print("---👉👉👉")
    print(items)
    print("----------  👻")
}
#else
public func print_cd(_ items: Any...){}
#endif

#if DEBUG
public func print_address(_ value:AnyObject){
    print("---👉👉👉 内存地址-->", value)
    print(Unmanaged.passUnretained(value).toOpaque())
    print("---------- 👻")
}
#else
public func print_address(_ value:AnyObject){}
#endif


//MARK:--- 重载运算符 两个字典合并为一个字典 ----------
public func += <key, value> ( cd_one: inout Dictionary<key, value>, cd_two: Dictionary<key, value>) {
    for (k, v) in cd_two {
        cd_one.updateValue(v, forKey: k)
    }
}

//MARK:--- 耗时 ----------
/// 耗时
public func cd_timeConsuming(_ name:String = " 👻👉👉耗时：", call:(()->Void)? = nil) {
    //let startTime = CFAbsoluteTimeGetCurrent()
    //let endTime = CACurrentMediaTime()
    let start = CACurrentMediaTime()
    call?()
    let end = CACurrentMediaTime()
    print_cd(name, String(format: "%.7f", (end - start)*1000))
}

//MARK:--- UIWindow ----------
/// delegate UIWindow
public func cd_window() -> UIWindow? {
    return UIApplication.shared.delegate?.window ?? UIApplication.shared.keyWindow ?? nil
}

/// --- 屏宽
public func cd_screenW() -> CGFloat {
    return UIScreen.main.bounds.size.width
}
/// --- 屏高
public func cd_screenH() -> CGFloat {
    return UIScreen.main.bounds.size.height
}

/// --- 系统版本
public func cd_systemV() -> String {
    return UIDevice.current.systemVersion
}


/// --- tableView 等 组首尾 - 无
public func cd_sectionMinH() -> CGFloat {
    return 0.001
}

/// --- 是否模拟器
public func cd_isSimulator() -> Bool {
    #if targetEnvironment(simulator)
    return true
    #else
    return false
    #endif
}

/// ---
public func cd_notify() -> NotificationCenter {
    return NotificationCenter.default
}
/// ---
public func cd_userde() -> UserDefaults {
    return UserDefaults.standard
}
/// ---
public func cd_IDFA() -> String {
    return ASIdentifierManager.shared().advertisingIdentifier.uuidString
}

/// ---
public func cd_timestampNow() -> TimeInterval {
    return Date().timeIntervalSince1970
}

/// ---
public func cd_appVersion() -> String {
    return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0"
}
public func cd_appId() -> String {
    return Bundle.main.bundleIdentifier ?? ""
}

/// 屏幕适配宽度类型  目前 320 375 414 Pad 类
public enum CD_DeviceFit {
    case iPhone320
    case iPhone375
    case iPhone414
    case iPad
    case iTV
    case iCarPlay
    case iUnspecified
    
    public static var mode:CD_DeviceFit {
        func iPhoneToWidth() -> CD_DeviceFit {
            if cd_screenW()<=320.0{return iPhone320}
            if cd_screenW()>320.0 && cd_screenW()<=375.0
            {return iPhone375}
            return iPhone414
        }
        switch UIDevice.current.userInterfaceIdiom {
        case .pad:
            return .iPad
        case .phone:
            return iPhoneToWidth()
        case .tv:
            return .iTV
        case .carPlay:
            return .iCarPlay
        default:
            return iPhoneToWidth()
        }
    }
}

/// 设备类型
public enum CD_Device {
    /// 4及4一下系列
    case iPhone4
    /// 5及se pod 系列
    case iPhoneSE
    /// 6.7.8...及系列
    case iPhoneA
    /// plus...及系列
    case iPhoneP
    /// X...及系列
    case iPhoneX
    case iPad
    case iTV
    case iCarPlay
    case iUnspecified
    
    public static var mode:CD_Device {
        func iPhoneToSize() -> CD_Device {
            if cd_screenH()<=480.0 {return .iPhone4}
            if (cd_screenW()==320.0 && cd_screenH()==568.0)
            || (cd_screenH()==320.0 && cd_screenW()==568.0)
            {return .iPhoneSE}
            if (cd_screenW()==375.0 && cd_screenH()==667.0)
            || (cd_screenH()==375.0 && cd_screenW()==667.0)
            {return .iPhoneA}
            if (cd_screenW()==414.0 && cd_screenH()==736.0)
            || (cd_screenH()==414.0 && cd_screenW()==736.0)
            {return .iPhoneP}
            return .iPhoneX
        }
        func iphone() -> CD_Device {
            if #available(iOS 11.0, *) {
                if let b = cd_window()?.safeAreaInsets.bottom, b > 0 {
                    return .iPhoneX
                }else{
                    return iPhoneToSize()
                }
            } else {
                return iPhoneToSize()
            }
        }
        
        switch UIDevice.current.userInterfaceIdiom {
        case .pad:
            return .iPad
        case .phone:
            return iphone()
        case .tv:
            return .iTV
        case .carPlay:
            return .iCarPlay
        default:
            return iphone()
        }
    }
    
    
    static var modeSys:CD_Device {
        return CD_Device.mode
        /*
         /// Gets the Device identifier String.
         var modelName: String {
         var systemInfo = utsname()
         uname(&systemInfo)
         let machineMirror = Mirror(reflecting: systemInfo.machine)
         let identifier = machineMirror.children.reduce("") { identifier, element in
         guard let value = element.value as? Int8, value != 0 else { return identifier }
         return identifier + String(UnicodeScalar(UInt8(value)))
         }
         
         switch identifier {
         case "iPod1,1":  return "iPod Touch 1"
         case "iPod2,1":  return "iPod Touch 2"
         case "iPod3,1":  return "iPod Touch 3"
         case "iPod4,1":  return "iPod Touch 4"
         case "iPod5,1":  return "iPod Touch (5 Gen)"
         case "iPod7,1":   return "iPod Touch 6"
         
         case "iPhone3,1", "iPhone3,2", "iPhone3,3":  return "iPhone 4"
         case "iPhone4,1":  return "iPhone 4s"
         case "iPhone5,1":   return "iPhone 5"
         case  "iPhone5,2":  return "iPhone 5 (GSM+CDMA)"
         case "iPhone5,3":  return "iPhone 5c (GSM)"
         case "iPhone5,4":  return "iPhone 5c (GSM+CDMA)"
         case "iPhone6,1":  return "iPhone 5s (GSM)"
         case "iPhone6,2":  return "iPhone 5s (GSM+CDMA)"
         case "iPhone7,2":  return "iPhone 6"
         case "iPhone7,1":  return "iPhone 6 Plus"
         case "iPhone8,1":  return "iPhone 6s"
         case "iPhone8,2":  return "iPhone 6s Plus"
         case "iPhone8,4":  return "iPhone SE"
         
         case "iPhone9,1":  return "国行、日版、港行iPhone 7"
         case "iPhone9,2":  return "港行、国行iPhone 7 Plus"
         case "iPhone9,3":  return "美版、台版iPhone 7"
         case "iPhone9,4":  return "美版、台版iPhone 7 Plus"
         case "iPhone10,1","iPhone10,4":   return "iPhone 8"
         case "iPhone10,2","iPhone10,5":   return "iPhone 8 Plus"
         case "iPhone10,3","iPhone10,6":   return "iPhone X"
         case "iPhone11,2":  return "iPhone XS"
         case "iPhone11,4","iPhone11,6":  return "iPhone XS Max"
         case "iPhone11,8":  return "iPhone XR"
         
         case "iPad1,1":   return "iPad"
         case "iPad1,2":   return "iPad 3G"
         case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":   return "iPad 2"
         case "iPad2,5", "iPad2,6", "iPad2,7":  return "iPad Mini"
         case "iPad3,1", "iPad3,2", "iPad3,3":  return "iPad 3"
         case "iPad3,4", "iPad3,5", "iPad3,6":   return "iPad 4"
         case "iPad4,1", "iPad4,2", "iPad4,3":   return "iPad Air"
         case "iPad4,4", "iPad4,5", "iPad4,6":  return "iPad Mini 2"
         case "iPad4,7", "iPad4,8", "iPad4,9":  return "iPad Mini 3"
         case "iPad5,1", "iPad5,2":  return "iPad Mini 4"
         case "iPad5,3", "iPad5,4":   return "iPad Air 2"
         case "iPad6,3", "iPad6,4":  return "iPad Pro 9.7"
         case "iPad6,7", "iPad6,8":  return "iPad Pro 12.9"
         
         case "iPad6,11", "iPad6,12":  return "iPad 5"
         case "iPad7,1", "iPad7,2":   return "iPad Pro 12.9"
         case "iPad7,3", "iPad7,4":  return "iPad Pro 10.5"
         
         case "AppleTV2,1":  return "Apple TV 2"
         case "AppleTV3,1","AppleTV3,2":  return "Apple TV 3"
         case "AppleTV5,3":   return "Apple TV 4"
         case "i386", "x86_64":   return "Simulator"
         default:  return identifier
         }
         }
         */
    }
}








//MARK:--- 顶层 VC ----------
/// 当前显示的 VC
public func cd_visibleVC(_ vc: UIViewController? = nil) -> UIViewController?{
    let vc = vc ?? cd_window()?.rootViewController
    func visibleVC(_ vc: UIViewController? = nil) -> UIViewController? {
        if let nv = vc as? UINavigationController
        {
            return visibleVC(nv.visibleViewController)
        } else if let tb = vc as? UITabBarController,
            let select = tb.selectedViewController
        {
            return visibleVC(select)
        } else if let presented = vc?.presentedViewController {
            return visibleVC(presented)
        }
        return vc
    }
    return visibleVC(vc)
}

/// 导航栈的栈顶 VC
public func cd_topVC(_ vc: UIViewController? = nil) -> UIViewController? {
    /*
    func presented(_ vc: UIViewController?) -> UIViewController? {
        if let nvc = vc?.navigationController  {
            return nvc.topViewController
        }
        if let vc = vc?.presentedViewController {
            return presented(vc)
        }
        return nil
        
    }*/
    func topVC(_ vc: UIViewController? = nil) -> UIViewController? {
        let vc = vc ?? cd_window()?.rootViewController
        if let nv = vc as? UINavigationController,
            !nv.viewControllers.isEmpty
        {
            return topVC(nv.topViewController)
        }
        if let tb = vc as? UITabBarController,
            let select = tb.selectedViewController
        {
            return topVC(select)
        }
        if let _ = vc?.presentedViewController, let nvc = cd_visibleVC()?.navigationController {
         
            return topVC(nvc)
        }
        /*
        if let vc = presented(cd_visibleVC()) {
            return vc
        }*/
        return vc
    }
    
    let vc = vc ?? cd_window()?.rootViewController
    return topVC(vc)
}

/// App 安装日期
public func cd_appCreatDate() -> Date? {
    guard let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last else {
        return nil
    }
    guard let dates = try? FileManager.default.attributesOfItem(atPath: url.path) else {
        return nil
    }
    return dates[FileAttributeKey.creationDate] as? Date ?? nil
}
/// App 更新日期
public func cd_appUpdateDate() -> Date? {
    guard let info = Bundle.main.path(forResource: "Info", ofType: "plist") else {
        return nil
    }
    let url = URL(fileURLWithPath: info, isDirectory: true)
    let path = url.deletingLastPathComponent().relativePath
    //let file = url.lastPathComponent
    guard let dates = try? FileManager.default.attributesOfItem(atPath: path) else {
        return nil
    }
    return dates[FileAttributeKey.modificationDate] as? Date ?? nil
}


public func cd_iOS11ScrollViewAdjustmentBehavior() {
    if #available(iOS 11.0, *) {
        UIScrollView.appearance().contentInsetAdjustmentBehavior = .never
        UICollectionView.appearance().contentInsetAdjustmentBehavior = .never
        
        UITableView.appearance().contentInsetAdjustmentBehavior = .never
        UITableView.appearance().estimatedRowHeight = 0
        UITableView.appearance().estimatedSectionHeaderHeight = 0
        UITableView.appearance().estimatedSectionFooterHeight = 0
    } else {
        
    }
}







/*
public func cd_string(from className: String) -> AnyClass? {
    guard let appName:String = Bundle.main.infoDictionary!["CFBundleExecutable"] as? String else {
        print("命名空间不存在")
        return nil
    }
    let classStringName = "_TtC\(appName.count)\(appName)\(className.count)\(className)"
    let  cls: AnyClass? = NSClassFromString(classStringName)
    return cls
}

public func cd_cell(from string : String) -> UITableViewCell.Type? {
    guard let appName:String = Bundle.main.infoDictionary!["CFBundleExecutable"] as? String else {
        print("命名空间不存在")
        return nil
    }
    let classStringName = "_TtC\(appName.count)\(appName)\(string.count)\(string)"
    let  cls: AnyClass? = NSClassFromString(classStringName)
    guard let clsType = cls as? UITableViewCell.Type else {
        return nil
    }
    return clsType
}
*/
