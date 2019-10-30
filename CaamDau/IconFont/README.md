# CD_IconFont 阿里矢量图标库 管理与使用范例

## Installation

CaamDau is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'CaamDau/IconFont'
```
> 
#### 
```ruby
self.img.cd.iconfont(CD_IconFont.temoji(60), color: UIColor.red, mode: .center)

self.lab_icon.cd.iconfont(CD_IconFont.temoji(60))

self.lab_icon.cd.text(CD_IconFont.temoji(60).attributedString)

self.btn.cd
    .text(CD_IconFont.temoji(60).font)
    .text(CD_IconFont.temoji(60).text)

self.btn.cd.text(CD_IconFont.temoji(60).attributedString)
    
self.btn.cd.iconfont(CD_IconFont.temoji(60), style: .image(.normal, color: UIColor.red, mode: .center))
```
#### 附：[阿里矢量图标资源管理 代码自动化脚本](https://github.com/liucaide/SapSapSeoi)

## Author

liucaide, 565726319@qq.com

## License

CaamDau is available under the MIT license. See the LICENSE file for more info.
