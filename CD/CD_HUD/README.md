# CD_HUD 提示窗

## Installation

CD is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'CD/HUD'
```
<p>
  <img src="https://github.com/liucaide/CD/blob/master/images/QQ20190522-151106%402x.png" width="20%" />
  <img src="https://github.com/liucaide/CD/blob/master/images/QQ20190522-151137%402x.png" width="20%" />
  <img src="https://github.com/liucaide/CD/blob/master/images/QQ20190522-151145%402x.png" width="20%" />
  <img src="https://github.com/liucaide/CD/blob/master/images/QQ20190522-151201%402x.png" width="20%" />
</p>

<p>
  <img src="https://github.com/liucaide/CD/blob/master/images/QQ20190522-151216%402x.png" width="20%" />
  <img src="https://github.com/liucaide/CD/blob/master/images/QQ20190522-151345%402x.png" width="20%" />
  <img src="https://github.com/liucaide/CD/blob/master/images/QQ20190522-153426%402x.png" width="20%" />
  <img src="https://github.com/liucaide/CD/blob/master/images/QQ20190522-153501%402x.png" width="20%" />
</p>

```ruby

CD_HUD().show(with:view, style:style, title: title, detail: detail, model: model)

```

```ruby

cd_window()?.cd.hud(.text, title:"HUD")

cd_window()?.cd.hud(.loading(.activity), title: "HUD", detail: "Detail").hud_remove(10)

cd_window()?.cd.hud(.loading(.images(images,0.3,0)), title: "HUD", detail: "Detail").hud_remove(10)

```

## Author

liucaide, 565726319@qq.com

## License

CD is available under the MIT license. See the LICENSE file for more info.
