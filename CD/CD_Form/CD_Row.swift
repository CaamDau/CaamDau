//Created  on 2018/12/6  by LCD :https://github.com/liucaide .

/***** 模块文档 *****
 * CD_Row UI 排版组件
 
 ******************** 示例 ********************
class Cell_Form1: UITableViewCell {
    var callBack:CD_RowCallBack?
    @IBOutlet weak var lab_title: UILabel!
    @IBOutlet weak var btn_r: UIButton!
    @IBAction func clickButton(_ sender: UIButton) {
        callBack?("点击了按钮")
    }
}
extension Cell_Form1: CD_RowUpdateProtocol{
    typealias DataSource = M_Form
    func update(_ data: M_Form, id: String, tag: Int, frame: CGRect, callBack: CD_RowCallBack?) {
        lab_title.text = data.title
        self.callBack = callBack
    }
}
struct M_Form{
    var title:String = "123"
    init() {
    }
}
class VM_Form {
    var forms = [CD_RowProtocol]()
    var block:(()->Void)? = nil
    var data = M_Form()
    func makeForm() {
        forms.removeAll()
        do{
            let row = CD_Row<Cell_Form1>(data: data, frame: CGRect(h:80), callBack: { [weak self](any) in
                print(any)
                self?.data.title = "\((Int(self!.data.title) ?? 0) + 1)"
                self?.makeForm()
                
            }) {
                print("点击")
            }
            self.forms.append(row)
        }
        do{
            for _ in 0..<30 {
                let row = CD_Row<Cell_Form1>(data: M_Form(), frame: CGRect(h:80))
                self.forms.append(row)
            }
        }
        
        block?()
    }
}
class VC_Form: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    lazy var vm:VM_Form = {
        var m = VM_Form()
        m.makeForm()
        return m
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        vm.block = { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
}
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
*/













import UIKit
import Foundation

//MARK:---  单元格配置协议 ---
public protocol CD_RowProtocol {
    var tag:Int { get }
    var viewId: String { get }
    var viewClass:AnyClass { get }
    var bundleFrom:String { get }
    var datas: Any { set get }
    var frame: CGRect { set get }
    var x:CGFloat { set get }
    var y:CGFloat { set get }
    var w:CGFloat { set get }
    var h:CGFloat { set get }
    var size:CGSize { set get }
    var insets:UIEdgeInsets { set get }
    var insetsTitle:UIEdgeInsets { set get }
    var callBack:CD_RowCallBack?{ set get }
    var didSelect:CD_RowDidSelectBlock?{ set get }
    func bind(_ view: AnyObject)
}

//MARK:---  数据源更新协议 ---
public protocol CD_RowUpdateProtocol {
    /// 数据源 关联类型
    associatedtype DataSource
    func update(_ data: DataSource, id:String, tag:Int, frame:CGRect, callBack:CD_RowCallBack?)
}
public extension CD_RowUpdateProtocol{
    func update(_ data: DataSource, id:String , tag:Int, frame:CGRect, callBack:CD_RowCallBack?) {}
}

//MARK:---  建设单元格模型 ---
public typealias CD_RowDidSelectBlock = () -> Void
public typealias CD_RowCallBack = (Any) -> Void
public struct CD_Row<T> where T: UIView, T: CD_RowUpdateProtocol {
    public var data: T.DataSource
    public let id: String
    public var tag:Int
    public var frame: CGRect
    public let viewClass:AnyClass = T.self
    public let bundleFrom:String
    public var callBack:CD_RowCallBack? = nil
    public var didSelect:CD_RowDidSelectBlock? = nil
    public var insets:UIEdgeInsets
    public var insetsTitle:UIEdgeInsets
    
    /*
     data  ：View Data 数据源
     id    ：View Id 标识 输入空则默认以类名 viewClass 为标识
     tag   ：View Tag 标签 - 同类不同数据源或同控件不同UI展示效果做区分
     frame ：View frame 数据源
     insets  ：View UIButton imageEdgeInsets | UICollectionView sectionInset
     另 UICollectionView LineSpacing InteritemSpacing 使用 frame - x  y
     insetsTitle  ：View UIButton titleEdgeInsets
     bundleFrom ：View bundle 索引（组件化 | pod   nib 资源。。。。）
     callBack ： View 类内执行回调
     didSelect ： View 点击回调 UITableView | UICollectionView didSelectRow
     */
    public init(data: T.DataSource,
          id: String = "",
          tag:Int = 0,
          frame: CGRect = .zero,
          insets:UIEdgeInsets = .zero,
          insetsTitle:UIEdgeInsets = .zero,
          bundleFrom:String = "",
          callBack:CD_RowCallBack? = nil,
          didSelect:CD_RowDidSelectBlock? = nil) {
        self.data = data
        self.id = id
        self.frame = frame
        self.tag = tag
        self.bundleFrom = bundleFrom
        self.callBack = callBack
        self.didSelect = didSelect
        self.insets = insets
        self.insetsTitle = insetsTitle
    }
}

extension CD_Row:CD_RowProtocol {
    // 单元格模型绑定单元格实例
    public func bind(_ view: AnyObject) {
        if let v = view as? T {
            v.update(self.data, id:self.id, tag:self.tag, frame:self.frame, callBack:self.callBack)
        }
    }
}

//MARK:--- 附加 ---
extension CD_Row {
    public var viewId:String {
        get{
            return id=="" ? String(describing: viewClass) : id
        }
    }
    public var datas: Any {
        get { return data }
        set { data = newValue as! T.DataSource }
    }
    public var x:CGFloat {
        get{ return frame.origin.x }
        set{ frame.origin.x = newValue }
    }
    public var y:CGFloat{
        get{ return frame.origin.y }
        set{ frame.origin.y = newValue }
    }
    public var w:CGFloat{
        get{ return frame.size.width }
        set{ frame.size.width = newValue }
    }
    public var h:CGFloat{
        get{ return frame.size.height }
        set{ frame.size.height = newValue }
    }
    public var size:CGSize{
        get{ return frame.size }
        set{ frame.size = newValue }
    }
}
