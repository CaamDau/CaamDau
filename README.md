# Popois  （[OC版本在这里](https://github.com/liucaide/PopoisObjC)）

[![CI Status](https://img.shields.io/travis/liucaide/Popois.svg?style=flat)](https://travis-ci.org/liucaide/Popois)
[![Version](https://img.shields.io/cocoapods/v/Popois.svg?style=flat)](https://cocoapods.org/pods/Popois)
[![License](https://img.shields.io/cocoapods/l/Popois.svg?style=flat)](https://cocoapods.org/pods/Popois)
[![Platform](https://img.shields.io/cocoapods/p/Popois.svg?style=flat)](https://cocoapods.org/pods/Popois)
[![](https://img.shields.io/badge/Swift-4.2-orange.svg?style=flat)](https://cocoapods.org/pods/Popois)

> 初心：构建一个通用业务组件库和Cocoa便利性扩展，作为底层基础业务组件，在项目初期与维护期快速完成通用业务代码的构建（其实就是方便自己）。

## [目录](http://naotu.baidu.com/file/77191ea402a709285dd7af36fbaa47ee?token=6c06ab5d592c67c7)

<p>
  <img src="https://github.com/liucaide/Images/blob/master/Popois/Popois.png" width="70%" />
</p>

#### Popois 核心组件
- [Form：UI排版组件—使UI排版更加直观、易扩展、易维护](https://github.com/liucaide/Popois/tree/master/Popois/Form)
- [Chain：链式调用组件](https://github.com/liucaide/Popois/tree/master/Popois/Chain)
- [Extension：便利性扩展](https://github.com/liucaide/Popois/tree/master/Popois/Extension)
- [Value：基本数据类型转换](https://github.com/liucaide/Popois/tree/master/Popois/Value) 
- [RegEx：正则表达式](https://github.com/liucaide/Popois/tree/master/Popois/RegEx)
- ... 持续增新

#### Popois 辅助组件
- [HUD：提示窗组件](https://github.com/liucaide/Popois/tree/master/Popois/HUD) 
  - 友情链接 [SwiftMessages](https://github.com/SwiftKickMobile/SwiftMessages)
- [Page：分页导航控制组件](https://github.com/liucaide/Popois/tree/master/Popois/Page) 
- [TopBar：自定义导航栏组件](https://github.com/liucaide/Popois/tree/master/Popois/TopBar) 
  - 扩展依赖 [FDFullscreenPopGesture](https://github.com/forkingdog/FDFullscreenPopGesture)
  - 友情链接 [EachNavigationBar 原生扩展](https://github.com/Pircate/EachNavigationBar)
- [AppDelegate：AppDelegate解耦方案](https://github.com/liucaide/Popois/tree/master/Popois/AppDelegate)
- [CountDown：计时管理组件](https://github.com/liucaide/Popois/tree/master/Popois/CountDown) 
- [MVVM：MVVM ](https://github.com/liucaide/Popois/tree/master/Popois/MVVM)
- [IconFont：阿里矢量图标管理和使用](https://github.com/liucaide/Popois/tree/master/Popois/IconFont) 
- [InputBox：输入框扩展组件](https://github.com/liucaide/Popois/tree/master/Popois/InputBox) 
- [IBInspectable sb/xib 辅助](https://github.com/liucaide/Popois/tree/master/Popois/IBInspectable) 

- ... 持续增新

#### 第三方扩展组件
- [MJRefresh MJRefresh 扩展组件](https://github.com/liucaide/Popois/tree/master/Popois/MJRefresh)
- [Net Alamofire 扩展组件](https://github.com/liucaide/Popois/tree/master/Popois/Net)

#### RxSwift 扩展
- 

#### 附录
- [Python 自动化工具集](https://github.com/liucaide/Popois/tree/master/PyToSwift)
  - [图片资源管理类](https://github.com/liucaide/Popois/blob/master/PyToSwift/swift_assets.py)
  - [阿里矢量图标资源管理类](https://github.com/liucaide/Popois/blob/master/PyToSwift/swift_iconfont.py)
  - [基础配置资源管理类](https://github.com/liucaide/Popois/blob/master/PyToSwift/swift_config.py)
  - MVVM<Form> 代码模板
  - MVVM<Form> Rx 代码模板
  
- Form 场景使用示例
    - [Form 之于UITableView](https://github.com/liucaide/Popois/tree/master/Example/Modul/Mine/Classes)
    - [Form 之于UICollectionView](https://github.com/liucaide/Popois/tree/master/Example/Modul/Mine/Classes)
    
- [组件化示例](https://github.com/liucaide/Popois/tree/master/Example)
  - [通用型 基本资源、配置管理](https://github.com/liucaide/Popois/tree/master/Example/Util)
    - [资源图片管理 Assets](https://github.com/liucaide/Popois/tree/master/Example/Util/Assets)
    - [基本配置管理 Config <颜色配置、字体配置、字体适配、屏幕适配、基础图片配置...>](https://github.com/liucaide/Popois/tree/master/Example/Util/Config)
    - [登录页面响应模型+账号管理+范例](https://github.com/liucaide/Popois/tree/master/Example/Util/User)
    - [登录页面响应模型 RxSwift扩展](https://github.com/liucaide/Popois/tree/master/Example/Util/M_SignRx)
  - 项目业务模块
  - ......
- [Playground](https://github.com/liucaide/Popois/tree/master/Playground)

- 友情链接
  - [JianweiWangs](https://github.com/JianweiWangs)
  - [Pircate](https://github.com/Pircate)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

Popois is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'Popois'  # 只引入Popois核心插件
pod 'Popois/Core'  # 只引入Popois核心插件

pod 'Popois/Module'  # 引入Popois核心插件+辅助插件
```
```ruby
pod 'Popois/All' # 引入Popois所有插件
```
```ruby
# 引入Popois单项插件
pod 'Popois/Form'
pod 'Popois/Chain'
pod 'Popois/Extension'
pod 'Popois/CountDown'
pod 'Popois/Value'
pod 'Popois/RegEx'

pod 'Popois/HUD'
pod 'Popois/Page'
pod 'Popois/TopBar'
pod 'Popois/IconFont'
pod 'Popois/IBInspectable'

pod 'Popois/MJRefresh'
```
## Author

liucaide, 565726319@qq.com

## License

Popois is available under the MIT license. See the LICENSE file for more info.
