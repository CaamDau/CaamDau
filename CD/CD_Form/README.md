# CD_Form  （[OC版本在这里](https://github.com/liucaide/CD_ObjC/tree/master/CD_ObjC/CD_Form)）

## Installation

CD is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'CD/Form'
```

### 无论界面多复杂，都是如下一样的代码，使用这种方式即可轻松完成复杂的 UI 排版,适用所有 UIView，编写可读性、扩展性、维护性强的代码
```ruby
extension VC_Form:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.forms.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return vm.forms[indexPath.row].h
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = vm.forms[indexPath.row]
        let cell = tableView.cd.cell(row.viewClass) ?? UITableViewCell()
        row.bind(cell)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = vm.forms[indexPath.row]
        row.didSelect?()
    }
}
```

## Author

liucaide, 565726319@qq.com

## License

CD is available under the MIT license. See the LICENSE file for more info.
