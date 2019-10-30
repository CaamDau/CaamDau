# CD_Page 标签导航分页控制

## Installation

CaamDau is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'CaamDau/Page'
```
<p>
  <img src="https://github.com/liucaide/Images/blob/master/CD/page1.gif" width="25%" />
  <img src="https://github.com/liucaide/Images/blob/master/CD/page2.gif" width="25%" />
  <img src="https://github.com/liucaide/Images/blob/master/CD/page3.png" width="25%" />
</p>

## Usage
#### CD_PageControl 指示器

```ruby
lazy var pageControl: CD_PageControl = {
    return CD_PageControl<CD_PageControlItem,CD_PageControlBuoy>(itemConfig:CD_PageControlItem.Model(), buoyConfig: CD_PageControlBuoy.Model())
}()

pageControl.dataSource = (0..<3).map({ (i) -> CD_PageControlItemDataSource in
    var d = CD_PageControlItemDataSource()
    d.id = i.stringValue
    d.title = "Title-\(i)"
    return d
})
```
#### CD_PageViewController 分页控制器

```ruby
lazy var pageVC: CD_PageViewController = {
    return CD_PageViewController()
}()

pageVC.dataSource = [CD_RowVC<VC_PageA>(dataSource: "id", config: "config"),
                     CD_RowVC<VC_PageB>(),
                     CD_RowVC<VC_PageC>()]

pageVC.dataSource.append(CD_RowVC<VC_PageA>()) 

pageVC.dataSource += [CD_RowVC<VC_PageA>()]  

pageVC.selectIndex = 2
```

## Author

liucaide, 565726319@qq.com

## License

CaamDau is available under the MIT license. See the LICENSE file for more info.
