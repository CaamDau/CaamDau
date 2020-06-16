<p>
  <img src="https://github.com/CaamDau/Images/blob/master/CaamDau/caamdau.png" align=centre />
</p>

[![CI Status](https://img.shields.io/travis/CaamDau/CaamDau.svg?style=flat)](https://travis-ci.org/CaamDau/CaamDau)
[![Version](https://img.shields.io/cocoapods/v/CaamDau.svg?style=flat)](https://cocoapods.org/pods/CaamDau)
[![License](https://img.shields.io/cocoapods/l/CaamDau.svg?style=flat)](https://cocoapods.org/pods/CaamDau)
[![Platform](https://img.shields.io/cocoapods/p/CaamDau.svg?style=flat)](https://cocoapods.org/pods/CaamDau)
[![](https://img.shields.io/badge/Swift-4.0~5.0-orange.svg?style=flat)](https://cocoapods.org/pods/CaamDau)

### CaamDau 各组件正在拆分扩展中...，如果你有兴趣，欢迎联系管理员加入

> 蚕豆 (粤语caam dau) （[OC版本在这里](https://github.com/CaamDau/CaamDauObjC)）（[CaamDauRx - RxSwift扩展版本](https://github.com/CaamDau/CaamDauRx)）

> 前言：CaamDau是一个开发套件，旨在构建一个通用业务组件库和Cocoa便利性扩展，作为基础业务组件，在新项目初期与老项目维护期快速完成通用业务代码的构建（其实就是方便自己，同时也希望能方便同志）。

# 目录
- [CocoaPods](#CocoaPods)
- [CaamDau核心组件](#CaamDau核心组件)
  - [Form流式模型化排版组件](#Form流式模型化排版组件)
  - [Extension便利性扩展&链式](#Extension便利性扩展And链式)
  - [RegEx正则表达式](#RegEx正则表达式)
  - [Value基本数据类型转换](#Value基本数据类型转换)
- [CaamDau辅助模块组件](#CaamDau辅助模块组件)
  - [Timer计时管理组件](#Timer计时管理组件)
  - [AppDelegate解耦方案](#AppDelegate解耦方案)
  - [Router极致简约而强大的页面路由协议](#Router极致简约而强大的页面路由协议)
  - [HUD提示窗组件](#HUD提示窗组件)
  - [Page分页导航控制组件](#Page分页导航控制组件)
  - [TopBar自定义导航栏组件](#TopBar自定义导航栏组件)
  - [ViewModel协议](#ViewModel协议)
  - [IconFont阿里矢量图标管理和使用](#IconFont阿里矢量图标管理和使用)
  - [InputBox输入框扩展组件](#InputBox输入框扩展组件)
  - [Indexes一个漂亮的索引View](#Indexes一个漂亮的索引View)
  - [Calendar日历、日期选择组件](#Calendar日历日期选择组件)
  - [PencilKit 图片编辑组件](#PencilKit图片编辑组件)
  - 持续增新...
 
- [第三方扩展组件](#第三方扩展组件)
  - [MJRefresh扩展组件](#MJRefresh扩展组件)
  - [Alamofire扩展组件](#Alamofire扩展组件)
 
- [附录](#附录)
  - [Python自动化工具集](#Python自动化工具集)
  - [工程统一配置&适配方案](#工程统一配置&适配方案)
  - [组件化示例](#组件化示例)
  - [友情链接](#友情链接)
 
# CocoaPods
```
pod 'CaamDau'
pod 'CaamDau', :git => 'https://github.com/CaamDau/CaamDau.git'
# 码云有同步仓库，国内速度更快
pod 'CaamDau', :git => 'https://gitee.com/CaamDau/CaamDau.git'

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
- 原理:将多点关联的UI排版数据转化为单一的 Row 模型单元
- [更多详细的介绍请移步](https://github.com/CaamDau/CaamDau/tree/master/CaamDau/Form)
```
/// Cell数据源遵循 FormProtocol 协议
var form:FormProtocol = FormProtocol()

/// tableView Delegate DataSource 代理类
lazy var delegateData:FormTableViewDelegateDataSource? = {
    return FormTableViewDelegateDataSource(form)
}()

/// 代理设置为 FormTableViewDelegateDataSource
tableView.delegate = delegateData
tableView.dataSource = delegateData

// 关联默认的 reloadData
delegateData?.makeReloadData(tableView)
```
```
/// 构建一个单元格模型，包装在 form 数据组内
let row = RowCell<Cell_***>()
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
RegEx.match("123_a@456", type: RegEx.tPassword(RegEx.Password.value2))
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
        Timer.make(.delegate(self, "123", 120, 0.1))
    case 1://广播
        Timer.make(.notification("456", 120, 0.1))
    case 2://闭包回调接收
        Timer.make(.callBack("789", 60, 0.1, { [weak self](model) in
            self?.lab_3.cd.text("\(model.day)天\(model.hour):\(model.minute):\(model.second):\(model.millisecond/100)")
            }))
    default:
        break
    }
}
```
```
Time.after(2) { .... }
```
[回顶部目录](#目录)
### AppDelegate解耦方案
```
class App_Win: AppDelegate { // 实现window 主页面切换、配置，
    func application( ...
}
class App_Config: AppDelegate { // 统一信息配置
    func application( ...
}
class App_Net: AppDelegate { // 网络配置
    func application( ...
}
class App_Test: AppDelegate { // DEBUG
    func application( ...
}
```
```
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    lazy var composite: AppDelegateComposite = {
        window = UIWindow(frame: UIScreen.main.bounds)
        var arr:[AppDelegate] = [
            App_Net(),
            App_Win(window),
            App_Config()
        ]
        #if DEBUG
        arr.append(App_Test())
        #endif
        return AppDelegateComposite(arr)
    }()
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        return composite.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    ...
}
```
[回顶部目录](#目录)
### Router极致简约而强大的页面路由协议
```
// 路由表
enum Order: RouterProtocol {
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
  <img src="https://github.com/CaamDau/Images/blob/master/CaamDau/hud10.png" width="15%" />
  <img src="https://github.com/CaamDau/Images/blob/master/CaamDau/hud11.png" width="15%" />
  <img src="https://github.com/CaamDau/Images/blob/master/CaamDau/hud1.png" width="15%" />
  <img src="https://github.com/CaamDau/Images/blob/master/CaamDau/hud2.png" width="15%" />
  <img src="https://github.com/CaamDau/Images/blob/master/CaamDau/hud20.png" width="15%" />
  <img src="https://github.com/CaamDau/Images/blob/master/CaamDau/hud21.png" width="15%" />
</p>

```
var model = HUD.modelDefault
model._axis = .horizontal
model._textAlignment = .left
model._isSquare = false
view.cd.hud(.succeed, title: title, model:model)
```
[回顶部目录](#目录)
### Page分页导航控制组件

<p>
  <img src="https://github.com/CaamDau/Images/blob/master/CaamDau/page1.gif" width="15%" />
  <img src="https://github.com/CaamDau/Images/blob/master/CaamDau/page2.gif" width="15%" />
  <img src="https://github.com/CaamDau/Images/blob/master/CaamDau/page3.png" width="15%" />
</p>

```
// 指示器
lazy var pageControl: PageControl = {
    return PageControl<PageControlItem,PageControlBuoy>(itemConfig:PageControlItem.Model(), buoyConfig: PageControlBuoy.Model())
}()

pageControl.dataSource = (0..<3).map({ (i) -> PageControlItemDataSource in
    var d = PageControlItemDataSource()
    d.id = i.stringValue
    d.title = "Title-\(i)"
    return d
})

/// 控制器
lazy var pageVC: PageViewController = {
    return PageViewController()
}()
pageVC.dataSource = [RowVC<VC_PageA>(dataSource: "id", config: "config"),
                     RowVC<VC_PageB>(),
                     RowVC<VC_PageC>()]

pageVC.dataSource.append(RowVC<VC_PageA>()) 

pageVC.dataSource += [RowVC<VC_PageA>()]  

// 指定显示
pageControl.selectIndex = 2
```
[回顶部目录](#目录)
### TopBar自定义导航栏组件
- 完全隐藏系统导航栏，使用自定义导航栏
<p>
<img src="https://github.com/CaamDau/Images/blob/master/CaamDau/TopBar1.jpeg" width="15%" />
</p>

```
lazy var topBar: TopBar = {
    return TopBar()
}()

extension VC_***: TopBarProtocol {
    func topBar(custom topBar:TopBar) {
        topBar._style = "22"
        topBar._leftItemsWidth2 = 60
        topBar._rightItemsWidth1 = 80
        topBar._rightItemsWidth2 = 44
        topBar._rightItemsSpace = 5
        topBar._rightItemsSpaceSide = 5
        topBar._heightCustomBar = 70
        topBar.cd.snp().gradient()
    }
    func topBar(_ topBar:TopBar, didSelectAt item:TopNavigationBar.Item) {
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
    
     func topBar(_ topBar:TopBar, updateItemStyleForItem item:TopNavigationBar.Item) -> [TopNavigationBarItem.Item.Style]? {
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
/// Cell数据源遵循 FormProtocol 协议
var vm:VM_**** = VM_****()

/// tableView Delegate DataSource 代理类
lazy var delegateData:TableViewDelegateDataSource? = {
    return TableViewDelegateDataSource(vm)
}()

/// 代理设置为 FormTableViewDelegateDataSource
tableView.delegate = delegateData
tableView.dataSource = delegateData

// 关联默认的 reloadData
delegateData?.makeReloadData(tableView)
```
[回顶部目录](#目录)
### IconFont阿里矢量图标管理和使用
```
self.img.cd.iconfont(IconFont.temoji(60), color: UIColor.red, mode: .center)

self.lab_icon.cd.iconfont(IconFont.temoji(60))

self.lab_icon.cd.text(IconFont.temoji(60).attributedString)

self.btn.cd
    .text(IconFont.temoji(60).font)
    .text(IconFont.temoji(60).text)

self.btn.cd.text(IconFont.temoji(60).attributedString)
    
self.btn.cd.iconfont(IconFont.temoji(60), style: .image(.normal, color: UIColor.red, mode: .center))
```
[回顶部目录](#目录)
### InputBox输入框扩展组件
```
lazy var text_search: TextField = {
    let text = TextField().cd
        .tint(Config.color.main_1)
        .background(Config.color.hex("f"))
        .corner(15, clips: true)
        .build
    text.btn_placeholder.cd
        .text(IconFont.tsearch(14).text + " 请输入关键词")
        .text(IconFont.tsearch(14).font)
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
@IBOutlet weak var textView: TextView!

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
var keyboard:Keyboard?
keyboard = Keyboard(view: view_bottom)
```
```
InputBoxPopping.show( ... ){ ... }
```
[回顶部目录](#目录)
### Indexes一个漂亮的索引View

<p>
  <img src="https://github.com/CaamDau/Images/blob/master/CaamDau/indexes0.gif" width="15%" />
  <img src="https://github.com/CaamDau/Images/blob/master/CaamDau/indexes1.gif" width="15%" />
</p>


```
lazy var headers:[String] = {
    return ["选", "主"] + CD.atoz(true) + ["#"]
}()
    
lazy var indexesView: IndexesView = {
    return IndexesView()
}()

indexesView.items = headers.map{ IndexesView.Item(title:$0, color:Config.color.txt_1)}

//indexesView.firstIndex = 1
indexesView.selectHandler = { [weak self](item, idx)in
    let i = self!.headers.index(of: item.title)!
    self?.tableView.scrollToRow(at: IndexPath(row: 0, section: i), at: .top, animated: false)
}
```
[回顶部目录](#目录)
### Calendar日历日期选择组件
```
DatePickerAlert.show(.yyyyMMdd, date: Date(), preferredStyle: .sheet, callback: { (da) in
    print_cd(da)
}) {
    $0.colorLine = Config.color.line_1
    $0.colorCancel = Config.color.txt_1
    $0.colorDone = Config.color.main_1
    $0.minDate = "2019-3-10".cd_date("yyyy-MM-dd")!
    $0.maxDate = "2020-11-20".cd_date("yyyy-MM-dd")!
}
```

[回顶部目录](#目录)
### PencilKit图片编辑组件
<p>
  <img src="https://github.com/CaamDau/Images/blob/master/CaamDau/pencil1.png" width="15%" />
  <img src="https://github.com/CaamDau/Images/blob/master/CaamDau/pencil2.png" width="25%" />
</p>

```
if #available(iOS 13.0, *) {
    PencilDraw.show(imageView.image ?? Assets().logo_0, drawing: drawing as? PKDrawing ?? PKDrawing()) { [weak self](draw, image) in
        self?.drawing = draw
        self?.imageView.image = image
    }
} else {
    
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
Net.config.log = true
Net.config.baseURL = "https://..."
Net()
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
- [通用型 基本资源、配置管理](https://github.com/CaamDau/CaamDau/tree/master/Example/Util)

### 组件化示例
### 友情链接
- [Pircate](https://github.com/Pircate)
  - [EachNavigationBar 原生扩展](https://github.com/Pircate/EachNavigationBar)
  - [CleanJSON](https://github.com/Pircate/CleanJSON)

[回顶部目录](#目录)

## Author

- Email：565726319@qq.com 
- QQ & Wechat：565726319

## License

CaamDau is available under the MIT license. See the LICENSE file for more info.
