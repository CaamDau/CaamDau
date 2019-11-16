# Calendar 日历组件

## Installation

CaamDau is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'CaamDau/Calendar'
```
<p>
  <img src="https://github.com/liucaide/Images/blob/master/CD/calendar0.png" width="20%" />
  <img src="https://github.com/liucaide/Images/blob/master/CD/calendar1.png" width="20%" />
  <img src="https://github.com/liucaide/Images/blob/master/CD/calendar2.png" width="20%" />
  <img src="https://github.com/liucaide/Images/blob/master/CD/calendar3.png" width="20%" />
</p>

## Usage
#### 日期选择器
```ruby
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
#### 日历
```ruby

```
## Author

liucaide, 565726319@qq.com

## License

CaamDau is available under the MIT license. See the LICENSE file for more info.
