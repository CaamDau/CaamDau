<p>
  <img src="https://github.com/liucaide/Images/blob/master/CD/caamdau.png" align=centre />
</p>

[![CI Status](https://img.shields.io/travis/liucaide/CaamDau.svg?style=flat)](https://travis-ci.org/liucaide/CaamDau)
[![Version](https://img.shields.io/cocoapods/v/CaamDau.svg?style=flat)](https://cocoapods.org/pods/CaamDau)
[![License](https://img.shields.io/cocoapods/l/CaamDau.svg?style=flat)](https://cocoapods.org/pods/CaamDau)
[![Platform](https://img.shields.io/cocoapods/p/CaamDau.svg?style=flat)](https://cocoapods.org/pods/CaamDau)
[![](https://img.shields.io/badge/Swift-4.2-orange.svg?style=flat)](https://cocoapods.org/pods/CaamDau)
> 蚕豆 (粤语：caam dau) （[OC版本在这里](https://github.com/liucaide/CaamDauObjC)）

> 初心：构建一个通用业务组件库和Cocoa便利性扩展，作为底层基础业务组件，在项目初期与维护期快速完成通用业务代码的构建（其实就是方便自己）。

## [目录](http://naotu.baidu.com/file/77191ea402a709285dd7af36fbaa47ee?token=6c06ab5d592c67c7)

<p>
  <img src="https://github.com/liucaide/Images/blob/master/CD/cd.png" width="70%" />
</p>

#### CaamDau 核心组件
- [Form：UI排版组件—使UI排版更加直观、易扩展、易维护](https://github.com/liucaide/CaamDau/tree/master/CaamDau/Form)
- [Extension：便利性扩展&链式](https://github.com/liucaide/CaamDau/tree/master/CaamDau/Extension)
- [RegEx：正则表达式](https://github.com/liucaide/CaamDau/tree/master/CaamDau/RegEx)
- [Value：基本数据类型转换](https://github.com/liucaide/CaamDau/tree/master/CaamDau/Value) 
- [Timer：计时管理组件](https://github.com/liucaide/CaamDau/tree/master/CaamDau/Timer)
- [AppDelegate：AppDelegate解耦方案](https://github.com/liucaide/CaamDau/tree/master/CaamDau/AppDelegate)
- [Router：极致简约而强大的页面路由协议](https://github.com/liucaide/CaamDau/tree/master/CaamDau/Router)
- [HUD：提示窗组件](https://github.com/liucaide/CaamDau/tree/master/CaamDau/HUD) 
- [Page：分页导航控制组件](https://github.com/liucaide/CaamDau/tree/master/CaamDau/Page) 
- [TopBar：自定义导航栏组件](https://github.com/liucaide/CaamDau/tree/master/CaamDau/TopBar) 
- [ViewModel 协议，Form 配合的 TableView、CollectionView代理方案](https://github.com/liucaide/CaamDau/tree/master/CaamDau/ViewModel)
- [IconFont：阿里矢量图标管理和使用](https://github.com/liucaide/CaamDau/tree/master/CaamDau/IconFont) 
- [InputBox：输入框扩展组件](https://github.com/liucaide/CaamDau/tree/master/CaamDau/InputBox) 
- [IBInspectable sb/xib 辅助](https://github.com/liucaide/CaamDau/tree/master/CaamDau/IBInspectable) 
- ... 持续增新

#### 第三方扩展组件
- [MJRefresh : MJRefresh 扩展组件](https://github.com/liucaide/CaamDau/tree/master/CaamDau/MJRefresh)
- [Net : Alamofire 扩展组件](https://github.com/liucaide/CaamDau/tree/master/CaamDau/NetWork)

#### RxSwift 扩展
- 

#### 附录
-[Python 自动化工具集](https://github.com/liucaide/SapSapSeoi)
  - [图片资源管理类](https://github.com/liucaide/SapSapSeoi/blob/master/swift/swift_assets.py)
  - [阿里矢量图标资源管理类](https://github.com/liucaide/SapSapSeoi/blob/master/swift/swift_iconfont.py)
  
- Form 场景使用示例
    - [Form 之于UITableView](https://github.com/liucaide/CaamDau/tree/master/Example/Modul/Mine/Classes)
    - [Form 之于UICollectionView](https://github.com/liucaide/CaamDau/tree/master/Example/Modul/Mine/Classes)
    
- [组件化示例](https://github.com/liucaide/CaamDau/tree/master/Example)
  - [通用型 基本资源、配置管理](https://github.com/liucaide/CaamDau/tree/master/Example/Util)
    - [资源图片管理 Assets](https://github.com/liucaide/CaamDau/tree/master/Example/Util/Assets)
    - [基本配置管理 Config <颜色配置、字体配置、字体适配、屏幕适配、基础图片配置...>](https://github.com/liucaide/CaamDau/tree/master/Example/Util/Config)
    - [登录页面响应模型+账号管理+范例](https://github.com/liucaide/CaamDau/tree/master/Example/Util/User)
    - [登录页面响应模型 RxSwift扩展](https://github.com/liucaide/CaamDau/tree/master/Example/Util/M_SignRx)
  - 项目业务模块
  - ......
- [Playground](https://github.com/liucaide/CaamDau/tree/master/Playground)

- 友情链接
  - [JianweiWangs](https://github.com/JianweiWangs)
  - [Pircate](https://github.com/Pircate)
    - [EachNavigationBar 原生扩展](https://github.com/Pircate/EachNavigationBar)
    - [CleanJSON](https://github.com/Pircate/CleanJSON)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

CaamDau is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'CaamDau'

pod 'CaamDau', :git => 'https://github.com/liucaide/CaamDau.git'
```
```ruby
pod 'CaamDau/Core'  # 只引入CaamDau核心插件
pod 'CaamDau/Module'  # 引入CaamDau核心插件+辅助插件
```
```ruby
pod 'CaamDau/All' # 引入CaamDau所有插件
```
```ruby
# 引入CaamDau单项插件
pod 'CaamDau/Form'
pod 'CaamDau/Extension'
pod 'CaamDau/Timer'
pod 'CaamDau/Value'
pod 'CaamDau/RegEx'
pod 'CaamDau/Router'

pod 'CaamDau/HUD'
pod 'CaamDau/Page'
pod 'CaamDau/TopBar'
pod 'CaamDau/IconFont'
pod 'CaamDau/IBInspectable'

pod 'CaamDau/MJRefresh'
pod 'CaamDau/Net/Core'
```
## Author

liucaide, 565726319@qq.com

## License

CaamDau is available under the MIT license. See the LICENSE file for more info.
