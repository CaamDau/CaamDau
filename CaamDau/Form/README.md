# CD_Form  （[OC版本在这里](https://github.com/liucaide/CaamDauObjC)）

```ruby
pod 'CaamDau'
pod 'CaamDau/Form'
```
> 目标：用一点点代码 实现 高耦合的 UI 排版解耦，增强排版随机、变更、扩展能力，增强 UI-Data 关联强度；解决TableView/CollectionView 混合排版 Delegate/DataSource 中 section row height didselect 等多点关系的灾难

> 无论界面多复杂，都是一样的代码，使用这种方式即可轻松完成复杂的 UI 排版，编写可读性、扩展性、维护性强的代码

> 原理：这是一个UI排版模型，将UI排版逻辑 事先转换为 Row 模型单元！
- [如何做到不需要再维护Delegate/DataSource协议的代码](#如何做到不需要再维护Delegate和DataSource协议的代码)
- [如何构建一个单元格模型Row](#如何构建一个单元格模型Row)
- [如何应对混合排版](#如何应对混合排版)
- [如何扩展实现自定义功能](#如何扩展实现自定义功能)
- [对比：以前混乱的代码](#以前混乱的代码)
- [对比：现在有序的代码](#现在有序的代码)

### 如何做到不需要再维护Delegate和DataSource协议的代码
- 首先要明白 Delegate/DataSource 中 section row height didselect 的多点关系是有迹可循的，是可以模型化的，因此可以转化为单个模型单元，即可将多点关系转化为了单点关系
- 了解 CD_CellProtocol 协议
- 了解为 TableView/CollectionView 而定制的CD_RowCell/CD_RowCellClass
- 了解 CD_FormDelegateDataSource


### 如何构建一个单元格模型Row
```
let row = CD_RowCell<Cell_***>()
```
示例：
```
        do{// 倒计时 - 旧的协议
            let row = CD_Row<Cell_MineCountDown>(data: model, frame: CGRect(h:100))
            self.forms[Section.countdown.rawValue].append(row)
        }
        
        do{// 倒计时 - 新的协议
            let row = CD_RowCell<Cell_MineCountDown>(data: model, frame: CGRect(h:100))
            self.forms[Section.countdown.rawValue].append(row)
        }
        
        do{// 倒计时 点击回调didSelect 与内部事件回调 callBack
            let row = CD_RowCell<Cell_MineCountDown>(data: model, frame: CGRect(h:100), callBack:{_ in}, didSelect:{})
            self.forms[Section.countdown.rawValue].append(row)
        }
```

### 如何应对混合排版
- 当混合排版的时候 section row height didselect 等多点关系简直就是灾难
- 而使用CD_Row 就是如此简单

示例：
```ruby
//MARK:--- 应对混合排版 ----------
extension VM_MineTableView{
    func makeForm() {
        for (i,item) in models.enumerated() {
            self.makeFormCountDown(item)
            // 除倒计时外 其余随机排版
            switch Int(arc4random() % 3) {
            case 0:...
            default:
                self.makeFormDetail(i)
            }
            
            do{//分割线
                let row = CD_Row<Cell_MineLine>(data: .bgF0, frame: CGRect(h:10))
                self.forms[Section.countdown.rawValue].append(row)
            }
        }
    }
    func makeFormCountDown(_ model:VM_MineTableView.Model) {
        do{// 倒计时
            let row = CD_Row<Cell_MineCountDown>(data: model, frame: CGRect(h:100))
            self.forms[Section.countdown.rawValue].append(row)
        }
        do{//分割线
            let row = CD_Row<Cell_MineLine>(data: .bgF0, frame: CGRect(h:0.5))
            self.forms[Section.countdown.rawValue].append(row)
        }
    }
}
```
### 如何扩展实现自定义功能
- CD_Form *** DelegateDataSource 内已实现的 Delegate/DataSource 是普遍通用代码，当无法满足需求时，可继承 CD_Form *** DelegateDataSource 实现
```
/// 继承 CD_Form***DelegateDataSource 自行实现 左滑删除功能
class CustomListTableViewDelegateDataSource: CD_FormTableViewDelegateDataSource {
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // 特定状态 特定Cell 具备左滑删除
        guard let vm = vm as? VM_CustomList, vm.status == .t未提交, vm._forms[indexPath.section][indexPath.row].cellClass == Cell_CustomList.self else {
            return false
        }
        return true
    }
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "删除"
    }
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard let vm = vm as? VM_CustomList, let model = vm._forms[indexPath.section][indexPath.row].dataSource as? VM_CustomList.List  else {
            return
        }
        vm.requestDelete(model)
    }
}

```

### 以前混乱的代码
- 以往你的TableView/CollectionView可能是如下这样的； 无论是开发、维护、修改都是灾难，section row height didselect 等必须相应维护，而且每个TableView/CollectionView都需要重复编写这些灾难性的代码

示例：
```
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == * {return *} 
        else if section == * {return *} 
        else if section == * {return *} 
        // 自动忽略几十行代码
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case **:
            switch indexPath.row {
              case **:
               return cell
               // 自动忽略几十行代码
            }
            // 自动忽略几十行代码
        }
    }
    // 自动忽略几十行代码
```
### 现在有序的代码
- 现在代码可以是这样的，不需要维护Delegate/DataSource代理，将任务交给CD_Form***DelegateDataSource（可继承实现未完成的）
```
    /// Cell数据源遵循 CD_FormProtocol 协议
    var form:CD_FormProtocol?
    /// tableView Delegate DataSource 代理类
    lazy var delegateData:CD_FormTableViewDelegateDataSource? = {
        return CD_FormTableViewDelegateDataSource(form)
    }()
    tableView.delegate = delegateData
    tableView.dataSource = delegateData
    delegateData?.makeReloadData(tableView)
```
- 此时 一个单元格信息 全部包含在 CD_RowCell 模型中，无需理会 Delegate DataSource 中的代码
```
    // 设置 活动分组 排版
    func makeActivityForm() {
        do{
            let row = CD_RowCell<Cell_***>.init(data: "数据" config:"配置", frame: CGRect(h:45), callBack: { _ in
                /// Cell 内事件回调处理
            }) {
                /// Cell 点击事件处理
            }
            forms[Section.activity.rawValue] += [row]
        }
        do{
            let row = CD_RowCell<Cell_***>.init(data: "数据", frame: CGRect(h:45))
            forms[Section.activity.rawValue] += [row]
        }
        reloadData?()
    }
    // 此处省略 各组 各种类型状态 下的排版顺序关系
```

- 更多全面的示例请运行Demo查看

## Author

liucaide, 565726319@qq.com

## License

CaamDau is available under the MIT license. See the LICENSE file for more info.
