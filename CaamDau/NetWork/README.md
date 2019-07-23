# CD_Net Alamofire 二次扩展封装

## Installation

CD is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'CD/Net/Core' #主要网络功能

pod 'CD/Net/All' #CD_Net 所有功能
pod 'CD/Net/SwiftyJSON' #获取 SwiftyJSON 功能
pod 'CD/Net/Cache'  #获取 Cache功能
pod 'CD/Net/Codable' #获取 Codable 功能
```
#### Alamofire 使用 更便捷

- 统一默认配置
```
        CD_Net.config.method = .post
        CD_Net.config.encoding = JSONEncoding(options: [])
        // responseStyle 默认为.data
        CD_Net.config.responseStyle = .json
        CD_Net.config.headers = [:]
        CD_Net.config.baseURL = "https://..."
        CD_Net.config.log = true // 开启控制台打印
        // 自定义控制台打印
        CD_Net.config.logHandler = { (res, h, p) in
            guard let res = res else { return }
            var url:URL?
            var value:Any?
            if let res = res as? DataResponse<Any> {
                url = res.request?.url
                value = res.result.value
            }
            else if let res = res as? DataResponse<Data> {
                url = res.request?.url
                value = res.result.value
            }
            else if let res = res as? DataResponse<String> {
                url = res.request?.url
                value = res.result.value
            }
            debugPrint("---👉👉👉", url ?? "")
            debugPrint("Parameters：", p ?? "")
            debugPrint(JSON( value ?? "未知数据"))  使用了这么多转模型库，还是更喜欢 SwiftyJSON
            debugPrint("----------  👻")
        }
        
        CD_Net.config.parametersHandler = { (p) -> [String:Any]? in
                /// 执行参数签名
                return p
        }
        // - 登录登出  接口增补参数配置
        if !User.shared.info.userid.isEmpty {
            CD_Net.config.parametersSubjoin = ["token":User.shared.token]
        }

```
- 一个请求
```ruby
        var page = 1
        CD_Net()
            .baseURL("https://httpbin.org/")
            .path("get")
            .method(.get)
            .parameters(["foo": "bar"])
            .onCache(completion: { (data) in
                //debugPrint("Cache JSON:", json)
            })
            .toCache(when: {page == 1})
            .mapModel(withCodable: M_Codable<M_CodableData>.self, succeed: { (m) in
                debugPrint(m.code)
                debugPrint(m.data.host)
            })
            /*
            .mapModel(withSwiftyJSON: M_Test<M_T>.self, tag: 1)
            { (m) in
                debugPrint(m.code)
                debugPrint(m.data.host)
            }*/
            .failure({ (error) in
                debugPrint(error.code)
                debugPrint(error.massage)
            })
            //.responseStyle(.data)
            .responseStyle(.json)
            .request()
            //.request(isSubjoin: false, handler:nil)
            // isSubjoin: 默认增补userid等通用参数, handler: 增补操作 如参数签名
            // 不需要增补的接口设为 false 即可
            
```
- 网络监控
```ruby

        var reachability:NetworkReachabilityManager?
        reachability = CD_Net.reachability(block: { (status) in
            debugPrint("Reachability Status:",status)
        })
```


## Author

liucaide, 565726319@qq.com

## License

CD is available under the MIT license. See the LICENSE file for more info.
