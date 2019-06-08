# CD_HUD 提示窗

## Installation

CD is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'CD/HUD'
```
<p>
  <img src="https://github.com/liucaide/Images/blob/master/CD/hud10.png" width="20%" />
  <img src="https://github.com/liucaide/Images/blob/master/CD/hud11.png" width="20%" />
  <img src="https://github.com/liucaide/Images/blob/master/CD/hud12.png" width="20%" />
  <img src="https://github.com/liucaide/Images/blob/master/CD/hud13.png" width="20%" />
</p>

<p>
  <img src="https://github.com/liucaide/Images/blob/master/CD/hud14.png" width="20%" />
  <img src="https://github.com/liucaide/Images/blob/master/CD/hud1.png" width="20%" />
  <img src="https://github.com/liucaide/Images/blob/master/CD/hud2.png" width="20%" />
  <img src="https://github.com/liucaide/Images/blob/master/CD/hud3.png" width="20%" />
  
  
</p>

<p>
  <img src="https://github.com/liucaide/Images/blob/master/CD/hud15.png" width="20%" />
  <img src="https://github.com/liucaide/Images/blob/master/CD/hud20.png" width="20%" />
  <img src="https://github.com/liucaide/Images/blob/master/CD/hud21.png" width="20%" />
  <img src="https://github.com/liucaide/Images/blob/master/CD/hud22.png" width="20%" />
</p>

## Usage
```ruby

hud = CD_HUD().show(with:view, style:style, title: title, detail: detail, model: model)
hud.remove()

CD_HUD.show(with:view, style:style, title: title, detail: detail, model: model)
CD_HUD.remove(for:view)
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
