<p>
  <img src="https://github.com/liucaide/Images/blob/master/CD/caamdau.png" align=centre />
</p>

[![CI Status](https://img.shields.io/travis/liucaide/CaamDau.svg?style=flat)](https://travis-ci.org/liucaide/CaamDau)
[![Version](https://img.shields.io/cocoapods/v/CaamDau.svg?style=flat)](https://cocoapods.org/pods/CaamDau)
[![License](https://img.shields.io/cocoapods/l/CaamDau.svg?style=flat)](https://cocoapods.org/pods/CaamDau)
[![Platform](https://img.shields.io/cocoapods/p/CaamDau.svg?style=flat)](https://cocoapods.org/pods/CaamDau)
[![](https://img.shields.io/badge/Swift-4.0~5.0-orange.svg?style=flat)](https://cocoapods.org/pods/CaamDau)
> 蚕豆 (粤语caam dau) （[OC版本在这里](https://github.com/liucaide/CaamDauObjC)）（[CaamDauRx - RxSwift扩展版本](https://github.com/liucaide/CaamDauRx)）

> 初心构建一个通用业务组件库和Cocoa便利性扩展，作为底层基础业务组件，在新项目初期与老项目维护期快速完成通用业务代码的构建（其实就是方便自己，同时也希望能方便同志）。

> 备注CaamDau 目前处于开发阶段，在现有多个实际项目中使用、验证、修复并持续输出新的组件，距离发布正式版可能需要一段距离，但并不影响正常使用。
# 目录
- [CaamDau核心组件](#CaamDau核心组件)
  - [Form流式模型化排版组件](#Form流式模型化排版组件)
  - [Extension便利性扩展&链式](#Extension便利性扩展And链式)
  - [RegEx正则表达式](#RegEx正则表达式)
  - [Value基本数据类型转换](#Value基本数据类型转换)
- [CaamDau辅助模块组件](#CaamDau辅助模块组件)
  - [Timer计时管理组件](#Timer计时管理组件)
  - [AppDelegateAppDelegate解耦方案](#AppDelegateAppDelegate解耦方案)
  - [Router极致简约而强大的页面路由协议](#Router极致简约而强大的页面路由协议)
  - [HUD提示窗组件](#HUD提示窗组件)
  - [Page分页导航控制组件](#Page分页导航控制组件)
  - [TopBar自定义导航栏组件](#TopBar自定义导航栏组件)
  - [ViewModel协议](#ViewModel协议)
  - [IconFont阿里矢量图标管理和使用](#IconFont阿里矢量图标管理和使用)
  - [InputBox输入框扩展组件](#InputBox输入框扩展组件)
  - [Indexes一个漂亮的索引View](#Indexes一个漂亮的索引View)
  - [Calendar日历、日期选择组件](#Calendar日历日期选择组件)
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
### Form:流式模型化排版组件
- 流式模型化排版组件—使UI排版更加直观、易扩展、易维护；解决TableView/CollectionView 排版 section row height didselect 等多点关系的灾难
- 原理:将多点关联的UI排版数据转化为单一的 CD_Row 模型单元
- [更多详细的介绍请移步](https://github.com/liucaide/CaamDau/tree/master/CaamDau/Form)
```
/// Cell数据源遵循 CD_FormProtocol 协议
var form:CD_FormProtocol = CD_FormProtocol()

/// tableView Delegate DataSource 代理类
lazy var delegateData:CD_FormTableViewDelegateDataSource? = {
    return CD_FormTableViewDelegateDataSource(form)
}()

/// 代理设置为 CD_FormTableViewDelegateDataSource
tableView.delegate = delegateData
tableView.dataSource = delegateData

// 关联默认的 reloadData
delegateData?.makeReloadData(tableView)
```
```
/// 构建一个单元格模型，包装在 form 数据组内
let row = CD_RowCell<Cell_***>()
form.forms += [row]

reloadData?()
```
[回顶部目录](#目录)

### Extension便利性扩展And链式
```
// UI配置
label?.cd
    .text("内容")
    .text(Config.color.txt_2)
    .text(Config.font.fontBold(13).fit())
    .rounded(...) //半圆角
    .gradient(...) //背景/文字渐变

// UIAlertController
UIAlertController().cd
    .title("提示")
    .title(UIColor.red).title(UIFont.sys..)
    .message("message")
    .action("取消")
    .action("修改", custom:{
        $0.cd.title(UIColor.gray)
    }, handler: { _ in
        
    })
    .show()

// 字符串处理
"13100000000"[3..<8] = "****"

// 数组去重
[["id":1], ["id":2], ["id":1]].cd_filter{$0.stringValue("id")}

// Color
let redhex = UIColor.red.hex
let color = UIColor.cd_hex("f", dark:"0")
let color = UIColor.cd_hex("f0", dark:"#0")


// UserDefauls
UserDefaulsUser.token.save("123")
let token = UserDefaulsUser.token.string ?? ""

// Notification
NoticeOrder.pay.add { (n) in
    debugPrint(n)
}
NoticeOrder.pay.post("123", userInfo: ["id":"456"])

// iconfont
let font = UIFont.iconFont(...)

.... 更多
```
[回顶部目录](#目录)

### RegEx正则表达式
```
CD_RegEx.match("123_a@456", type: CD_RegEx.tPassword(CD_RegEx.Password.value2))
```
```
do{// 获取所有匹配结果
    let pattern = "([\\u4e00-\\u9fa5]+):([\\d]+)"
    let str = "张三:123456 66,99 ,我的， 李四:23457,王麻子:110987 9"
    if let text = CaamDau.makeRegEx(pattern)?.cd.match(allIn: str) {
        text.map{$0.cd.string(in: str)}
        text.map{$0.cd.captures(in: str)![0]}
        text.map{$0.cd.captures(in: str)![1]}
    }else{
        _ = false
    }
}
```
[回顶部目录](#目录)
### Value基本数据类型转换
```
let arr:[Any] = [3.0,
                 "3.6",
                 "",
                 -9,
                 [1,"2"],
                 [1:234,
                  "23":[1:2,
                        2:3,
                        3:4]
    ]
]
arr.intValue(1)
arr.uintValue(1)
let uu = arr.uint(3) ?? UInt(abs(arr.intValue(3)))
arr.uintAbsValue(3)
arr.floatValue(1)
arr.urlValue(2)
arr.arrayValue(4)
arr.stringValue(1).arrayValue(".")
arr.dictValue(5).dictValue("23")
"123.88".intValue
"12a3.88".int ?? 0
"123.88".folatValue
"123.88".arrayValue(".")
```
[回顶部目录](#目录)

## CaamDau辅助模块组件
### Timer计时管理组件
- 应用切到后台依然有效计时
```
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
```
CD_Timer.after(2) { .... }
```
[回顶部目录](#目录)
### AppDelegateAppDelegate解耦方案
```
```
[回顶部目录](#目录)
### Router极致简约而强大的页面路由协议
```
// 路由表
enum Order: CD_RouterProtocol {
    case submit
}

// 路由表配置
switch router {
    case Router.Order.submit:
        R_OrderSubmit.router(r, param, callback)
}

/// 路由
Router.Order.submit.router(["id":999]) { (res) in
    //.....
}
```
[回顶部目录](#目录)
### HUD提示窗组件
<p>
  <img src="https://github.com/liucaide/Images/blob/master/CD/hud10.png" width="10%" />
  <img src="https://github.com/liucaide/Images/blob/master/CD/hud11.png" width="10%" />
  <img src="https://github.com/liucaide/Images/blob/master/CD/hud1.png" width="10%" />
  <img src="https://github.com/liucaide/Images/blob/master/CD/hud2.png" width="10%" />
  <img src="https://github.com/liucaide/Images/blob/master/CD/hud20.png" width="10%" />
  <img src="https://github.com/liucaide/Images/blob/master/CD/hud21.png" width="10%" />
</p>

```
var model = CD_HUD.modelDefault
model._axis = .horizontal
model._textAlignment = .left
model._isSquare = false
view.cd.hud(.succeed, title: title, model:model)
```
[回顶部目录](#目录)
### Page分页导航控制组件

<p>
  <img src="https://github.com/liucaide/Images/blob/master/CD/page1.gif" width="10%" />
  <img src="https://github.com/liucaide/Images/blob/master/CD/page2.gif" width="10%" />
  <img src="https://github.com/liucaide/Images/blob/master/CD/page3.png" width="10%" />
</p>

```
// 指示器
lazy var pageControl: CD_PageControl = {
    return CD_PageControl<CD_PageControlItem,CD_PageControlBuoy>(itemConfig:CD_PageControlItem.Model(), buoyConfig: CD_PageControlBuoy.Model())
}()

pageControl.dataSource = (0..<3).map({ (i) -> CD_PageControlItemDataSource in
    var d = CD_PageControlItemDataSource()
    d.id = i.stringValue
    d.title = "Title-\(i)"
    return d
})

/// 控制器
lazy var pageVC: CD_PageViewController = {
    return CD_PageViewController()
}()
pageVC.dataSource = [CD_RowVC<VC_PageA>(dataSource: "id", config: "config"),
                     CD_RowVC<VC_PageB>(),
                     CD_RowVC<VC_PageC>()]

pageVC.dataSource.append(CD_RowVC<VC_PageA>()) 

pageVC.dataSource += [CD_RowVC<VC_PageA>()]  

// 指定显示
pageControl.selectIndex = 2
```
[回顶部目录](#目录)
### TopBar自定义导航栏组件
- 完全隐藏系统导航栏，使用自定义导航栏
<p>
<img src="https://github.com/liucaide/Images/blob/master/CD/TopBar1.jpeg" width="10%" />
</p>

```
lazy var topBar: CD_TopBar = {
    return CD_TopBar()
}()

extension VC_***: CD_TopBarProtocol {
    func topBarCustom() {
        topBar._style = "22"
        topBar._leftItemsWidth2 = 60
        topBar._rightItemsWidth1 = 80
        topBar._rightItemsWidth2 = 44
        topBar._rightItemsSpace = 5
        topBar._rightItemsSpaceSide = 5
        topBar._heightCustomBar = 70
        topBar.cd.snp().gradient()
    }
    func didSelect(withTopBar item: CD_TopNavigationBar.Item) {
        super_topBarClick(item)
        switch item {
        case .rightItem1:
            ...
        case .rightItem2:
            ...
        default:
            break
        }
    }
    
    func update(withTopBar item: CD_TopNavigationBar.Item) -> [CD_TopNavigationBarItem.Item.Style]? {
        switch item {
        case .leftItem1:
            return topBar.cd.backWhite()
        case .leftItem2:
            return [.title([("购物车",Config.font.fontMedium(20),Config.color.hex("f"),.normal)])]
        case .rightItem2:
            ...
        case .rightItem1:
            ...
        default:
            return nil
        }
    }
}
```
[回顶部目录](#目录)
### ViewModel协议
- Form & MJRefresh & Request 组合扩展
```
/// Cell数据源遵循 CD_FormProtocol 协议
var vm:VM_**** = VM_****()

/// tableView Delegate DataSource 代理类
lazy var delegateData:CD_TableViewDelegateDataSource? = {
    return CD_TableViewDelegateDataSource(vm)
}()

/// 代理设置为 CD_FormTableViewDelegateDataSource
tableView.delegate = delegateData
tableView.dataSource = delegateData

// 关联默认的 reloadData
delegateData?.makeReloadData(tableView)
```
[回顶部目录](#目录)
### IconFont阿里矢量图标管理和使用
```
self.img.cd.iconfont(CD_IconFont.temoji(60), color: UIColor.red, mode: .center)

self.lab_icon.cd.iconfont(CD_IconFont.temoji(60))

self.lab_icon.cd.text(CD_IconFont.temoji(60).attributedString)

self.btn.cd
    .text(CD_IconFont.temoji(60).font)
    .text(CD_IconFont.temoji(60).text)

self.btn.cd.text(CD_IconFont.temoji(60).attributedString)
    
self.btn.cd.iconfont(CD_IconFont.temoji(60), style: .image(.normal, color: UIColor.red, mode: .center))
```
[回顶部目录](#目录)
### InputBox输入框扩展组件
```
lazy var text_search: CD_TextField = {
    let text = CD_TextField().cd
        .tint(Config.color.main_1)
        .background(Config.color.hex("f"))
        .corner(15, clips: true)
        .build
    text.btn_placeholder.cd
        .text(CD_IconFont.tsearch(14).text + " 请输入关键词")
        .text(CD_IconFont.tsearch(14).font)
    text._placeholderAlignment = .left
    text._widthBtnLeft = 10
    text._returnKeyType = .search
    return text
}()
// 搜索
text_search.blockShouldReturn = { (t) -> Bool in
    ....
    return true
}
```
```
@IBOutlet weak var textView: CD_TextView!

textView.placeholder = "详细地址"
textView.textColor = Config.color.txt_1
textView.tintColor = Config.color.main_1
textView.font = Config.font.font(14, fit: true)
textView.blockEditing = { [weak self](t,e) in
    switch e {
    case .editingChanged:
        self?.callback?(t.text ?? "")
    default: break
    }
}
```
```
var keyboard:CD_Keyboard?
keyboard = CD_Keyboard(view: view_bottom)
```
```
CD_InputBoxPopping.show( ... ){ ... }
```
[回顶部目录](#目录)
### Indexes一个漂亮的索引View

<p>
  <img src="https://github.com/liucaide/Images/blob/master/CD/indexes0.gif" width="10%" />
  <img src="https://github.com/liucaide/Images/blob/master/CD/indexes1.gif" width="10%" />
</p>


```
lazy var headers:[String] = {
    return ["选", "主"] + CD.atoz(true) + ["#"]
}()
    
lazy var indexesView: CD_IndexesView = {
    return CD_IndexesView()
}()

indexesView.items = headers.map{ CD_IndexesView.Item(title:$0, color:Config.color.txt_1)}

//indexesView.firstIndex = 1
indexesView.selectHandler = { [weak self](item, idx)in
    let i = self!.headers.index(of: item.title)!
    self?.tableView.scrollToRow(at: IndexPath(row: 0, section: i), at: .top, animated: false)
}
```
[回顶部目录](#目录)
### Calendar日历日期选择组件
```
CD_DatePickerAlert.show(.yyyyMMdd, date: Date(), preferredStyle: .sheet, callback: { (da) in
    print_cd(da)
}) {
    $0.colorLine = Config.color.line_1
    $0.colorCancel = Config.color.txt_1
    $0.colorDone = Config.color.main_1
    $0.minDate = "2019-3-10".cd_date("yyyy-MM-dd")!
    $0.maxDate = "2020-11-20".cd_date("yyyy-MM-dd")!
}
```
#### 持续增新...
[回顶部目录](#目录)
## 第三方扩展组件
### MJRefresh扩展组件
```
self.tableView.cd
    .headerMJGifWithModel({ [weak self] in
        
    })
    .footerMJAutoWithModel({ [weak self] in
        
    })
```
[回顶部目录](#目录)
### Alamofire扩展组件
```
CD_Net.config.log = true
CD_Net.config.baseURL = "https://..."
CD_Net()
    .method(.get)
    .path("/order/info")
    .parameters(["id":"999"])
    .success({ [weak self](res) in
        print_cd(res)
    })
    .failure({ (error) in
        print_cd(error)
    })
    .request()
```
[回顶部目录](#目录)
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

[回顶部目录](#目录)

## Author

liucaide, 565726319@qq.com

## License

CaamDau is available under the MIT license. See the LICENSE file for more info.
