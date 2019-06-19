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
> Alamofire 使用 更便捷

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
//            .mapModel(withSwiftyJSON: M_Test<M_T>.self, tag: 1)
//            { (m) in
//                debugPrint(m.code)
//                debugPrint(m.data.host)
//            }
            .failure({ (error) in
                debugPrint(error.code)
                debugPrint(error.massage)
            })
            .request()
            .request(.json)
            .request(.data)
```
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
