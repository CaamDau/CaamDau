# CD_Form  （[OC版本在这里](https://github.com/liucaide/CD_ObjC/tree/master/CD_ObjC/CD_Form)）

## Installation

CD is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'CD/Form'
```

### 无论界面多复杂，都是如下一样的代码，使用这种方式即可轻松完成复杂的 UI 排版,适用所有 UIView，编写可读性、扩展性、维护性强的代码

- 排版

```ruby
//MARK:--- 排版 ----------
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

- 对于 UITableView

```ruby
extension VC_Mine:UITableViewDelegate,UITableViewDataSource {
    public func numberOfSections(in tableView: UITableView) -> Int {
        return vm.forms.count
    }
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.forms[section].count
    }
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let row = vm.forms[indexPath.section][indexPath.row]
        return row.h
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = vm.forms[indexPath.section][indexPath.row]
        let cell = tableView.cd.cell(row.viewClass)
        row.bind(cell!)
        return cell!
    }
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let row = vm.forms[indexPath.section][indexPath.row]
        row.didSelect?()
    }
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.001
    }
    public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
}
```

- 对于UICollectionView

```ruby
extension VC_MineCollection: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return vm.forms.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return vm.forms[section].count
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return vm.forms[indexPath.section][indexPath.row].size
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let row = vm.forms[indexPath.section][indexPath.row]
        let cell = collectionView.cd.cell(row.viewId, indexPath)
        row.bind(cell)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return vm.forms[section].first?.x ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return vm.forms[section].first?.y ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return vm.formsHeader[section].insets
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize{
        return vm.formsHeader[section].size
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize{
        return vm.formsFooter[section].size
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if CD<UICollectionView>.CD_Kind.tHeader.stringValue == kind {
            let row = vm.formsHeader[indexPath.section]
            let v = collectionView.cd.view(row.viewId, kind, indexPath)
            row.bind(v)
            return v
        }else{
            let row = vm.formsFooter[indexPath.section]
            let v = collectionView.cd.view(row.viewId, kind, indexPath)
            row.bind(v)
            return v
        }
    }
}

```

## Author

liucaide, 565726319@qq.com

## License

CD is available under the MIT license. See the LICENSE file for more info.
