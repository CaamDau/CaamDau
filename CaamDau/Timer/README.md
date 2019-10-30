# CD_Timer 计时管理

## Installation

CaamDau is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'CaamDau/Timer'
```
> CD_Timer 使用系统时间对比进行计时，较为有效保持界面退出/App进入后台后重新进入的时效性；防止重复创建同一计时器
#### 创建倒计时
```ruby
func countDown(_ tag:Int){
        switch tag {
        case 0:// 代理接收
            CD_Timer.make(.delegate(self, "123", 120, 0.1))
        case 1://广播
            CD_Timer.make(.notification("456", 120, 0.1))
        case 2://闭包回调接收
            CD_Timer.make(.callBack("789", 60, 0.1, { [weak self](model) in
                self?.lab_3.cd.text("\(model.day)天\(model.hour):\(model.minute):\(model.second):\(model.millisecond/100)")
            }))
        default:
            break
        }
    }
```

#### 接收
```ruby

extension ViewController:CD_TimerProtocol {
    func cd_timer(withModel model: CD_Timer.Model, id: String) {
        self.lab_1.cd.text("\(model.day)天\(model.hour):\(model.minute):\(model.second):\(model.millisecond/100)")
    }
}

NotificationCenter.default.rx
    .notification(Notification.Name(rawValue: "456"), object: nil)
    .asObservable()
    .subscribe(onNext: { [weak self](n) in
        if let model = n.object as? CD_Timer.Model {
            self?.title = "\(model.day)天\(model.hour):\(model.minute):\(model.second)"
        }
    })
    .disposed(by: disposeBag)

deinit {
    //如果不需要保持 可以移除
    CD_Timer.remove("456")
}
```

## Author

liucaide, 565726319@qq.com

## License

CaamDau is available under the MIT license. See the LICENSE file for more info.
