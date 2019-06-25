//Created  on 2019/6/20 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 *
 */




import Foundation
import CD

public class App_Ali: CD_AppDelegate {
    public func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        return true
    }
    public func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        guard url.host == "safepay" else { return true }
//        AlipaySDK.defaultService()?.processOrder(withPaymentResult: url, standbyCallback: { (res) in
//            print_cd("Alipay Callback:", res)
//        })
        return true
    }
}
