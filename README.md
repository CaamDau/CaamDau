# CD  （[OC版本在这里](https://github.com/liucaide/CD_ObjC)）

[![CI Status](https://img.shields.io/travis/liucaide/CD.svg?style=flat)](https://travis-ci.org/liucaide/CD)
[![Version](https://img.shields.io/cocoapods/v/CD.svg?style=flat)](https://cocoapods.org/pods/CD)
[![License](https://img.shields.io/cocoapods/l/CD.svg?style=flat)](https://cocoapods.org/pods/CD)
[![Platform](https://img.shields.io/cocoapods/p/CD.svg?style=flat)](https://cocoapods.org/pods/CD)
[![](https://img.shields.io/badge/Swift-4.2-orange.svg?style=flat)](https://cocoapods.org/pods/CD)

## 目录
#### CD 核心插件
- [CD_Form：UI排版插件—使UI排版更加直观、易扩展、易维护](https://github.com/liucaide/CD/tree/master/CD/CD_Form)
- [CD_Chain：链式调用插件](https://github.com/liucaide/CD/tree/master/CD/CD_Chain)
- [CD_Extension：便利性扩展](https://github.com/liucaide/CD/tree/master/CD/CD_Extension)
- [CD_CountDown：计时管理](https://github.com/liucaide/CD/tree/master/CD/CD_CountDown) 
- [CD_Value：基本数据类型转换](https://github.com/liucaide/CD/tree/master/CD/CD_Value) 
- [CD_RegEx：正则表达式](https://github.com/liucaide/CD/tree/master/CD/CD_RegEx)
- ... 持续增新
#### CD 辅助插件
- [CD_TopBar：自定义导航栏](https://github.com/liucaide/CD/tree/master/CD/CD_TopBar) 
  - 扩展依赖 [FDFullscreenPopGesture](https://github.com/forkingdog/FDFullscreenPopGesture)
  - 友情链接 [EachNavigationBar 原生扩展](https://github.com/Pircate/EachNavigationBar)
- [CD_IconFont：阿里矢量图标管理和使用](https://github.com/liucaide/CD/tree/master/CD/CD_IconFont) 
- [CD_IBInspectable sb/xib 辅助](https://github.com/liucaide/CD/tree/master/CD/CD_IBInspectable) 
- ... 持续增新

#### 第三方扩展插件
- [CD_MJRefresh MJRefresh 扩展插件](https://github.com/liucaide/CD/tree/master/CD/CD_MJRefresh)

#### RxSwift 扩展
- 

#### 附录
- [Python 自动化工具集](https://github.com/liucaide/CD/tree/master/PyToSwift)
  - [图片资源管理类](https://github.com/liucaide/CD/blob/master/PyToSwift/swift_assets.py)
  - [阿里矢量图标资源管理类](https://github.com/liucaide/CD/blob/master/PyToSwift/swift_iconfont.py)
  - [基础配置资源管理类](https://github.com/liucaide/CD/blob/master/PyToSwift/swift_config.py)
  - MVVM<CD_Form> 代码模板
  - MVVM<CD_Form> Rx 代码模板
  
- CD_Form 场景使用示例
    - [CD_Form 之于UITableView](https://github.com/liucaide/CD/tree/master/Example/Modul/Mine/Classes)
    - [CD_Form 之于UICollectionView](https://github.com/liucaide/CD/tree/master/Example/Modul/Mine/Classes)
    
- [组件化示例](https://github.com/liucaide/CD/tree/master/Example)
  - [通用型 基本资源、配置管理](https://github.com/liucaide/CD/tree/master/Example/Util)
    - [资源图片管理 Assets](https://github.com/liucaide/CD/tree/master/Example/Util/Assets)
    - [基本配置管理 Config <颜色配置、字体配置、字体适配、屏幕适配、基础图片配置...>](https://github.com/liucaide/CD/tree/master/Example/Util/Config)
    - [登录页面响应模型+范例](https://github.com/liucaide/CD/tree/master/Example/Util/M_Sign)
    - [登录页面响应模型 RxSwift扩展](https://github.com/liucaide/CD/tree/master/Example/Util/M_SignRx)
  - 项目业务模块
  - ......
- [Playground](https://github.com/liucaide/CD/tree/master/Playground)

- 友情链接
  - [JianweiWangs](https://github.com/JianweiWangs)
  - [Pircate](https://github.com/Pircate)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

CD is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'CD'  # 只引入CD核心插件
```
```ruby
pod 'CD/All' # 引入CD所有插件
```
```ruby
# 引入CD单项插件
pod 'CD/Form'
pod 'CD/Chain'
pod 'CD/Extension'
pod 'CD/CountDown'
pod 'CD/Value'
pod 'CD/RegEx'

pod 'CD/IconFont'
pod 'CD/IBInspectable'

pod 'CD/MJRefresh'
```
## Author

liucaide, 565726319@qq.com

## License

CD is available under the MIT license. See the LICENSE file for more info.
