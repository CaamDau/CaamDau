# MJRefresh 扩展

## Installation

CaamDau is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'CaamDau/MJRefresh'
```
> MJRefresh 普通扩展，使用更方便
#### 设置全局统一样式
```ruby
CD_MJRefresh.shared.model.up_imgIdle = [...]
```

#### 单独页面设置样式
```ruby
    // 当然 mode 可以置于ViewModel中，或设置全局方法
    lazy var modelMj:CD_MJRefreshModel = {
        var m = CD_MJRefreshModel()
        let ass = Assets()
        let arr = [ass.refresh_0,
                   ass.refresh_1,
                   ass.refresh_2,
                   ass.refresh_3,
                   ass.refresh_4,
                   ass.refresh_5,
                   ass.refresh_6,
                   ass.refresh_7]
        m.down_imgIdle = arr
        m.down_imgPulling = arr
        m.down_imgWillRefresh = arr
        m.down_imgRefreshing = arr
        return m
    }()
```
```ruby
    self.tableView.cd
        .estimatedAll()
        .headerMJGifWithModel({ [weak self] in
            CD_CountDown.after(3, {[weak self] in
                self?.tableView.cd.endRefreshing()
                self?.tableView.reloadData()
            })
        }, model: modelMj) // model 不设置即为使用全局统一样式
        .beginRefreshing()
```
```ruby
    self.tableView.cd
        .estimatedAll()
        .headerMJGifWithModel({ [weak self] in
            self?.vm.requestData(true)
        }, model: self.vm.modelMj)
        .footerMJAutoWithModel({ [weak self] in
            self?.vm.requestData(false)
        })
        .mjRefreshTypes(self.vm.refreshTypes)
```

## Author

liucaide, 565726319@qq.com

## License

CaamDau is available under the MIT license. See the LICENSE file for more info.
