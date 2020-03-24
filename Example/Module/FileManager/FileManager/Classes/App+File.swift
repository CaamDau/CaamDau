//Created  on 2019/8/23 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 *
 */




import Foundation
import CaamDau

public class App_File: CD_AppDelegate {
    
    
    public func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        return true
    }
    
    public func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        
        if url.scheme == "file" {
            R_FileFromShare.push(url)
        }
        return true
    }
}

/*
extension App_File {
    public static func color(_ suffix:String) -> UIColor {
        switch suffix {
        case "doc", "docx":
            return UIColor.cd_hex("224388")
        case "xls", "xlsx":
            return UIColor.cd_hex("1D6237")
        case "ppt", "pptx":
            return UIColor.cd_hex("A63420")
        case "pdf":
            return UIColor.cd_hex("E2393A")
        default:
            return UIColor.cd_hex("EA9F12")
        }
    }
}
*/
