<p>
  <img src="https://github.com/liucaide/Images/blob/master/CD/caamdau.png" align=centre />
</p>

[![CI Status](https://img.shields.io/travis/liucaide/CaamDau.svg?style=flat)](https://travis-ci.org/liucaide/CaamDau)
[![Version](https://img.shields.io/cocoapods/v/CaamDau.svg?style=flat)](https://cocoapods.org/pods/CaamDau)
[![License](https://img.shields.io/cocoapods/l/CaamDau.svg?style=flat)](https://cocoapods.org/pods/CaamDau)
[![Platform](https://img.shields.io/cocoapods/p/CaamDau.svg?style=flat)](https://cocoapods.org/pods/CaamDau)
[![](https://img.shields.io/badge/Swift-4.0~5.0-orange.svg?style=flat)](https://cocoapods.org/pods/CaamDau)
> 蚕豆 (粤语：caam dau) （[OC版本在这里](https://github.com/liucaide/CaamDauObjC)）（[CaamDauRx - RxSwift扩展版本](https://github.com/liucaide/CaamDauRx)）

> 初心：构建一个通用业务组件库和Cocoa便利性扩展，作为底层基础业务组件，在新项目初期与老项目维护期快速完成通用业务代码的构建（其实就是方便自己，同时也希望能方便同志）。

> 备注：CaamDau 目前处于开发阶段，在现有多个实际项目中使用、验证、修复并持续输出新的组件，距离发布正式版可能需要一段距离，但并不影响正常使用。

- [CaamDau核心组件](#CaamDau核心组件)
  - [Form：流式模型化排版组件](#Form：流式模型化排版组件)
  - [Extension：便利性扩展&链式](#Extension：便利性扩展&链式)
  - [RegEx：正则表达式](#RegEx：正则表达式)
  - [Value：基本数据类型转换](#Value：基本数据类型转换)
- [CaamDau辅助模块组件](#CaamDau辅助模块组件)
  - [Timer：计时管理组件](#Timer：计时管理组件)
  - [AppDelegate：AppDelegate解耦方案](#AppDelegate：AppDelegate解耦方案)
  - [Router：极致简约而强大的页面路由协议](#Router：极致简约而强大的页面路由协议)
  - [HUD：提示窗组件](#HUD：提示窗组件)
  - [Page：分页导航控制组件](#Page：分页导航控制组件)
  - [TopBar：自定义导航栏组件](#TopBar：自定义导航栏组件)
  - [ViewModel协议](#ViewModel协议)
  - [IconFont：阿里矢量图标管理和使用](#IconFont：阿里矢量图标管理和使用)
  - [InputBox：输入框扩展组件](#InputBox：输入框扩展组件)
  - [Indexes：一个漂亮的索引View](#Indexes：一个漂亮的索引View)
  - [Calendar：日历、日期选择组件](#Calendar：日历、日期选择组件)
  - [持续增新...](#持续增新...)
 
- [第三方扩展组件](#第三方扩展组件)
  - [MJRefresh扩展组件](#MJRefresh扩展组件)
  - [Alamofire扩展组件](#Alamofire扩展组件)
 
- [附录](#附录)
  - [Python自动化工具集](#Python自动化工具集)
  - [工程统一配置&适配方案](#工程统一配置&适配方案)
  - [组件化示例](#组件化示例)
  - [友情链接](#友情链接)
 
```
pod 'CaamDau'
pod 'CaamDau', :git => 'https://github.com/liucaide/CaamDau.git'
# swift5.0  ios >= 10.0
pod 'CaamDau/All', :git => 'https://github.com/liucaide/CaamDau.git', :branch => 'swift5.0'

pod 'CaamDau/Core'  # 只引入CaamDau核心组件
pod 'CaamDau/Module'  # 引入CaamDau核心组件+辅助组件

pod 'CaamDau/All' # 引入CaamDau所有组件

# 引入CaamDau单项组件
pod 'CaamDau/Form'
pod 'CaamDau/Net/Core'
pod 'CaamDau/.../...'
```

## CaamDau核心组件
### Form：流式模型化排版组件
- 流式模型化排版组件—使UI排版更加直观、易扩展、易维护
- 解决TableView,CollectionView 排版 section row height didselect 等多点关系的灾难
- 原理：将多点关联的UI排版数据转化为单一的 CD_Row 模型单元
### Extension：便利性扩展&链式
```
```
### RegEx：正则表达式
```
```
### Value：基本数据类型转换
```
```

## CaamDau辅助模块组件
### Timer：计时管理组件
```
```
### AppDelegate：AppDelegate解耦方案
```
```
### Router：极致简约而强大的页面路由协议
```
```
### HUD：提示窗组件
```
```
### Page：分页导航控制组件
```
```
### TopBar：自定义导航栏组件
```
```
### ViewModel 协议
```
```
### IconFont：阿里矢量图标管理和使用
```
```
### InputBox：输入框扩展组件
```
```
### Indexes：一个漂亮的索引View
```
```
### Calendar：日历、日期选择组件
```
```
#### 持续增新...

## 第三方扩展组件
### MJRefresh扩展组件
```
```
### Alamofire扩展组件
```
```

## 附录
### Python自动化工具集
- [图片资源管理类](https://github.com/liucaide/SapSapSeoi/blob/master/swift/swift_assets.py)
- [阿里矢量图标资源管理类](https://github.com/liucaide/SapSapSeoi/blob/master/swift/swift_iconfont.py)

### 工程统一配置&适配方案
- [通用型 基本资源、配置管理](https://github.com/liucaide/CaamDau/tree/master/Example/Util)

### 组件化示例
### 友情链接
- [Pircate](https://github.com/Pircate)
  - [EachNavigationBar 原生扩展](https://github.com/Pircate/EachNavigationBar)
  - [CleanJSON](https://github.com/Pircate/CleanJSON)

## Author

liucaide, 565726319@qq.com

## License

CaamDau is available under the MIT license. See the LICENSE file for more info.
