# CD_Value 基本数据类型转换

## Installation

CD is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'CD/Value'
```
> 基本数据类型转换更便捷
#### 
```ruby
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

## Author

liucaide, 565726319@qq.com

## License

CD is available under the MIT license. See the LICENSE file for more info.
