# CD_IndexesView 一个漂亮的侧边索引

## Installation

CD is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'CaamDau/Indexes'
```
<p>
  <img src="https://github.com/liucaide/Images/blob/master/CD/indexes0.gif" width="25%" />
  <img src="https://github.com/liucaide/Images/blob/master/CD/indexes1.gif" width="25%" />
</p>

## Usage
```ruby
    @IBOutlet weak var tableView: UITableView!
    
    lazy var headers:[String] = {
        return ["选", "主"] + CD.atoz(true) + ["#"]
    }()
    
    lazy var indexesView: CD_IndexesView = {
        return CD_IndexesView()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.cd.add(indexesView)
        indexesView.snp.makeConstraints {
            $0.right.equalToSuperview().offset(10)
            $0.centerY.equalTo(tableView)
            $0.top.greaterThanOrEqualTo(tableView).offset(20)
        }
        indexesView.items = headers.map{ CD_IndexesView.Item(title:$0, color:Config.color.txt_1)}
        //indexesView.firstIndex = 1
        indexesView.selectHandler = { [weak self](item, idx)in
            let i = self!.headers.index(of: item.title)!
            self?.tableView.scrollToRow(at: IndexPath(row: 0, section: i), at: .top, animated: false)
        }
    }
    
    @IBAction func click(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            indexesView.hudStyle.style = .bubble
            indexesView.hudStyle.alphaMax = 0.3
            indexesView.hudStyle.size = CGSize(w: 60, h: 50)
        case 1:
            indexesView.hudStyle.style = .hud
            indexesView.hudStyle.alphaMax = 0.6
            indexesView.hudStyle.size = CGSize(w: 80, h: 80)
        default:
            break
        }
    }
```

## Author

liucaide, 565726319@qq.com

## License

CD is available under the MIT license. See the LICENSE file for more info.
