# CD_Form  （[OC版本在这里](https://github.com/liucaide/CD_ObjC/tree/master/CD_ObjC/CD_Form)）

## Installation

CD is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'CD/Form'
```
#### 目标：用一点点代码 实现 高耦合的 UI 排版解耦，增强排版随机、变更、扩展能力，增强 UI-Data 关联强度；解决TableView,CollectionView 混合排版 section row height didselect 等多点关系的灾难
#### 无论界面多复杂，都是一样的代码，使用这种方式即可轻松完成复杂的 UI 排版,适用所有 UIView，编写可读性、扩展性、维护性强的代码

### 原理：这是一个UI排版模型，将UI排版逻辑 事先转换为 Row 模型！
### 更新：
- 核心代码在 CD_Row。CD_Form 尚未完全编写。
- CD_Row 已变更到新的协议，旧的协议 CD_RowProtocol 比较单一，新的协议进行了更多的拆分，分工更加明确，当然旧的协议由于历史项目原因依然可用。
- CaamDau 在 ViewModel 模块中提供了一个 TableView & CollectionView 代理的中间件 [.....DelegateDataSource](https://github.com/liucaide/CaamDau/tree/master/CaamDau/ViewModel)，使用此中间件无需编写重复性的.....Delegate/.....DataSource 代码,如下示例：

```
        var delegateData:CD_TableViewDelegateDataSource?
        delegateData = CD_TableViewDelegateDataSource(vm)
        tableView.cd.background(Config.color.bg)
            .delegate(delegateData)
            .dataSource(delegateData)
//--- 剩下的几十行甚至 上百上千行 Delegate/DataSource 代码无需编写、无需理会
```

- 排版示例
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

- 当混合排版的时候 section row height didselect 等多点关系简直就是灾难
- 而使用CD_Row 就是如此简单
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
        do{//分割线
            let row = CD_Row<Cell_MineLine>(data: .bgFF, frame: CGRect(h:10))
            self.forms[Section.countdown.rawValue].append(row)
        }
        do{// 倒计时
            let row = CD_Row<Cell_MineCountDown>(data: model, frame: CGRect(h:100))
            self.forms[Section.countdown.rawValue].append(row)
        }
        do{//分割线
            let row = CD_Row<Cell_MineLine>(data: .bgFF, frame: CGRect(h:10))
            self.forms[Section.countdown.rawValue].append(row)
        }
        do{//分割线
            let row = CD_Row<Cell_MineLine>(data: .bgF0, frame: CGRect(h:0.5))
            self.forms[Section.countdown.rawValue].append(row)
        }
    }
}
```

#### 对于 UITableView/UICollectionView，都是一样的代码，基本无需维护，无需考虑检查 section row  height didselect 等多点关系，...ViewDelegate/...ViewDataSource 代码无需编写；如果有更高一点的要求，比如....ViewDelegateFlowLayout 、 scrollViewDidScroll 等，可将中间件 [.....DelegateDataSource](https://github.com/liucaide/CaamDau/tree/master/CaamDau/ViewModel) 里的代码完全复制，无需改动任何地方，而后添加未实现的功能即可。




```

## Author

liucaide, 565726319@qq.com

## License

CD is available under the MIT license. See the LICENSE file for more info.
