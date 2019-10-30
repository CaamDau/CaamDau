# CD_AppDelegate

> AppDelegate 解耦

## Installation

CaamDau is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'CD/AppDelegate'
```

### AppDelegate
```
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    lazy var composite: CD_AppDelegateComposite = {
        return CD_AppDelegateComposite([AppDelegate_VC(window),AppDelegate_UM()])
    }()
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        return composite.application(application, didFinishLaunchingWithOptions:launchOptions)
    }
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return composite.application(app, open: url, options: options)
    }
}

```
### AppDelegate Modul
```
class AppDelegate_VC: CD_AppDelegate {
    var window: UIWindow?
    init(_ win: UIWindow?) {
        window = win
    }
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        let vc = VC_Tab.show()
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
        return true
    }
}
```
```
class AppDelegate_UM: CD_AppDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        return true
    }
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return true
    }
}
```
```
class AppDelegate_Notifications: CD_AppDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        return true
    }
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
    }
}
```

- [参考](https://juejin.im/post/5bd0259d5188251a29719086#comment)

## Author

liucaide, 565726319@qq.com

## License

CaamDau is available under the MIT license. See the LICENSE file for more info.
