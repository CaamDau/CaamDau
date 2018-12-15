//Created  on 2018/12/6  by LCD :https://github.com/liucaide .

import UIKit
import Foundation

//MARK:---  单元格更新协议 ---
public protocol CD_RowProtocol {
    var tag:Int { get }
    var viewId: String { get }
    var viewClass:AnyClass { get }
    var datas: Any { set get }
    var frame: CGRect { set get }
    var x:CGFloat { set get }
    var y:CGFloat { set get }
    var w:CGFloat { set get }
    var h:CGFloat { set get }
    var size:CGSize { set get }
    func bind(_ view: AnyObject)
}

//MARK:---  数据源更新协议 ---
public protocol CD_RowUpdateProtocol {
    /// 数据源 关联类型
    associatedtype DataSource
    func update(_ data: DataSource, id:String, tag:Int, frame:CGRect)
}
public extension CD_RowUpdateProtocol{
    func update(_ data: DataSource, id:String , tag:Int, frame:CGRect) {}
}

//MARK:---  建设单元格模型 ---
public struct CD_Row<T> where T: UIView, T: CD_RowUpdateProtocol {
    public var data: T.DataSource
    public let id: String
    public var tag:Int
    public var frame: CGRect
    public let viewClass:AnyClass = T.self
    
    public init( data: T.DataSource,
          id: String = "",
          tag:Int = 0,
          frame: CGRect = .zero) {
        self.data = data
        self.id = id
        self.frame = frame
        self.tag = tag
    }
}

extension CD_Row:CD_RowProtocol {
    // 单元格模型绑定单元格实例
    public func bind(_ view: AnyObject) {
        if let v = view as? T {
            v.update(self.data, id:self.id, tag:self.tag, frame:self.frame)
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



/********** 示例 **********
 
class Cell_Class: UITableViewCell {
    
}
extension Cell_Class :CD_RowUpdateProtocol{
    public typealias DataSource = String
    public func update(_ data: String, id: String, tag: Int, frame: CGRect) {
        print(data)
        self.textLabel?.text = data
    }
}

struct VM_ViewController {
    var form = [CD_RowProtocol]()
    
    mutating func makeForm(){
        
        let row0 = CD_Row<Cell_Storyboard>(data:Model(img: "", text: "999"),
                                            id:"Cell_Storyboard",
                                            tag:11,
                                            frame:CGRect(x: 0, y: 0, width: 0, height: 50))
        let row1 = CD_Row<Cell_Nib>(data:["text":"777"],
                                     id:"Cell_Nib",
                                     tag:22,
                                     frame:CGRect(x: 0, y: 0, width: 0, height: 100))
        let row2 = CD_Row<Cell_Class>(data:"666",
                                       id:"Cell_Class",
                                       tag:33,
                                       frame:CGRect(x: 0, y: 0, width: 0, height: 150))
        form = [row0, row1, row2]
    }
}
class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var vm = VM_ViewController()
    override func viewDidLoad() {
        super.viewDidLoad()
        vm.makeForm()
        tableView.reloadData()
    }
}
extension ViewController :UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.form.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return vm.form[indexPath.row].h
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = vm.form[indexPath.row]
        let cell = tableView.cd_cell(row.id, row.viewClass)
        row.bind(cell)
        return cell
    }
}
*/
