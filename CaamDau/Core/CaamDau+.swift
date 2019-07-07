//Created  on 2019/6/26 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 *
 */




import Foundation

//MARK:--- 打印 ----------
var cd_printOpen:Bool = true
#if DEBUG
public func print_cd(_ items: Any...){
    guard cd_printOpen else { return }
    debugPrint("---👉👉👉")
    debugPrint(items)
    debugPrint("----------  👻")
}
#else
public func print_cd(_ items: Any...){}
#endif

#if DEBUG
public func print_address(_ value:AnyObject){
    guard cd_printOpen else { return }
    debugPrint("---👉👉👉 内存地址-->", value)
    debugPrint(Unmanaged.passUnretained(value).toOpaque())
    debugPrint("---------- 👻")
}
#else
public func print_address(_ value:AnyObject){}
#endif

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


extension CD {
    public enum DeviceFit {
        case iPhone320
        case iPhone375
        case iPhone414
        case iPad
        case iTV
        case iCarPlay
        case iUnspecified
        
        public static var mode:CD.DeviceFit {
            func iPhoneToWidth() -> CD.DeviceFit {
                if CD.screenW<=320.0{return iPhone320}
                if CD.screenW>320.0 && CD.screenW<=375.0
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
    public enum Device {
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
        
        public static var mode:CD.Device {
            func iPhoneToSize() -> CD.Device {
                if CD.screenH<=480.0 {return .iPhone4}
                if (CD.screenW==320.0 && CD.screenH==568.0)
                    || (CD.screenH==320.0 && CD.screenW==568.0)
                {return .iPhoneSE}
                if (CD.screenW==375.0 && CD.screenH==667.0)
                    || (CD.screenH==375.0 && CD.screenW==667.0)
                {return .iPhoneA}
                if (CD.screenW==414.0 && CD.screenH==736.0)
                    || (CD.screenH==414.0 && CD.screenW==736.0)
                {return .iPhoneP}
                return .iPhoneX
            }
            func iphone() -> CD.Device {
                if #available(iOS 11.0, *) {
                    if let b = CD.window?.safeAreaInsets.bottom, b > 0 {
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
        
        
        static var modeSys:CD.Device {
            return CD.Device.mode
        }
    }
}

public struct CD {
    public static var window:UIWindow? {
        return UIApplication.shared.delegate?.window ?? UIApplication.shared.keyWindow ?? nil
    }
    
    public static var screenSize:CGSize {
        return UIScreen.main.bounds.size
    }
    
    public static var screenW:CGFloat {
        return UIScreen.main.bounds.size.width
    }
    
    public static var screenH:CGFloat {
        return UIScreen.main.bounds.size.height
    }
    
    public static var sysNavigationH:CGFloat {
        if #available(iOS 11.0, *) {
            return UIApplication.shared.statusBarFrame.size.height + (CD.visibleVC?.navigationController?.navigationBar.frame.size.height ?? 44)
        } else {
            return 20.0 + (CD.visibleVC?.navigationController?.navigationBar.frame.size.height ?? 44)
        }
    }
    
    public static var sysTabBarH:CGFloat {
        return CD.visibleVC?.tabBarController?.tabBar.frame.size.height ?? 59
    }
    
    public static var sectionMinH:CGFloat {
        return 0.001
    }
    
    public static var sysVersion:String {
        return UIDevice.current.systemVersion
    }
    
    public static var isSimulator:Bool {
        #if targetEnvironment(simulator)
        return true
        #else
        return false
        #endif
    }
    
    public static var notice:NotificationCenter {
        return NotificationCenter.default
    }
    
    public static var userde:UserDefaults {
        return UserDefaults.standard
    }
    
    public static var timestampNow:TimeInterval {
        return Date().timeIntervalSince1970
    }
    
    public static var appVersion:String {
        return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0"
    }
    public static var appId:String {
        return Bundle.main.bundleIdentifier ?? ""
    }
    
    public static func appUrlScheme(_ match:String) -> String {
        guard let info = Bundle.main.infoDictionary else { return match }
        let urlTypes = info.arrayValue("CFBundleURLTypes")
        for item in urlTypes {
            guard let j = item as? [String:Any] else { break }
            guard let s = j.arrayValue("CFBundleURLSchemes").first as? String else { break }
            guard s.hasPrefix(match) else { break }
            return s
        }
        return match
    }
    
    /// app 安装日期
    public static var appCreatDate:Date? {
        guard let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last else {
            return nil
        }
        guard let dates = try? FileManager.default.attributesOfItem(atPath: url.path) else {
            return nil
        }
        return dates[FileAttributeKey.creationDate] as? Date ?? nil
    }
    /// app 更新日期
    public static var appUpdateDate:Date? {
        guard let info = Bundle.main.path(forResource: "Info", ofType: "plist") else {
            return nil
        }
        let url = URL(fileURLWithPath: info, isDirectory: true)
        let path = url.deletingLastPathComponent().relativePath
        guard let dates = try? FileManager.default.attributesOfItem(atPath: path) else {
            return nil
        }
        return dates[FileAttributeKey.modificationDate] as? Date ?? nil
    }
    
    
    public static var visibleVC:UIViewController? {
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
        let vc = CD.window?.rootViewController
        return visibleVC(vc)
    }
    
    public static var topVC:UIViewController? {
        func topVC(_ vc: UIViewController? = nil) -> UIViewController? {
            let vc = vc ?? CD.window?.rootViewController
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
            if let _ = vc?.presentedViewController, let nvc = CD.visibleVC?.navigationController {
                
                return topVC(nvc)
            }
            return vc
        }
        let vc = CD.window?.rootViewController
        return topVC(vc)
    }
    
    
    public static func iOSAdjustmentBehavior() {
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
    
    public static func present(_ vc:UIViewController, animated: Bool = true, completion: (() -> Void)? = nil) {
        CD.visibleVC?.present(vc, animated: animated, completion: completion)
    }
    
    public static func dismiss(_ animated: Bool = true, completion: (() -> Void)? = nil) {
        CD.visibleVC?.dismiss(animated: animated, completion: nil)
    }
    
    public static func push(_ vc:UIViewController, animated: Bool = true) {
        if let nvc = CD.visibleVC?.navigationController {
            vc.hidesBottomBarWhenPushed = true
            nvc.pushViewController(vc, animated: animated)
        }else{
            CD.visibleVC?.present(vc, animated: animated, completion: nil)
        }
    }
    
    public static func pop(_ animated: Bool = true) {
        if let nvc = CD.visibleVC?.navigationController, let _ = nvc.popViewController(animated: animated) {
        }else{
            CD.visibleVC?.dismiss(animated: animated, completion: nil)
        }
    }
}
