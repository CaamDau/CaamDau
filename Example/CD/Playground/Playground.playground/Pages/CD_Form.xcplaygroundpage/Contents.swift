//: [Previous](@previous)

import Foundation
import UIKit
import PlaygroundSupport

//MARK:--- CD_Row ----------
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

//MARK:--- ViewModel ----------


extension UITableViewCell :CD_RowUpdateProtocol{
    public typealias DataSource = String
    public func update(_ data: String, id: String, tag: Int, frame: CGRect) {
        self.textLabel?.text = data
        
        let button = UIButton(frame: CGRect(x: 100, y: 15, width: 80, height: 50))
        self.contentView.addSubview(button)
        button.backgroundColor = UIColor.red
        button.addTarget(self, action: #selector(clickButton(button:)), for: .touchUpInside)
        button.tag = tag
        button.setTitle(data, for: .normal)
        
    }
    
    @objc func clickButton(button:UIButton) {
        print(button.tag)
    }
}

//MARK:--- ViewController ----------
class VM_MyViewController {
    var form:[CD_RowProtocol] = []
    
    func makeForm() {
        for i in 0...5 {
            let row = CD_Row<UITableViewCell>(data:"666\(i)",
                                         tag:i,
                                         frame:CGRect(x: 0, y: 0, width: 0, height: 80))
            form.append(row)
        }
    }
}
class MyViewController : UIViewController,UITableViewDelegate,UITableViewDataSource {
    lazy var vm:VM_MyViewController = {
        let v = VM_MyViewController()
        return v
    }()
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white
        view.frame = CGRect(x: 0, y: 0, width: 320, height: 550)
        let label = UILabel()
        label.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: 50)
        label.text = "Hello World!"
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont(name: "PingFang SC", size: 23)
//        print("familyNames:",UIFont.familyNames)
//        print("familyName:",label.font.familyName,
//              "\npointSize:", label.font.pointSize,
//              "\nfontName:",label.font.fontName)
        view.addSubview(label)
        
        
        vm.makeForm()
        
        let tableView = UITableView(frame: CGRect(x: 0, y: 50, width: 320, height: 500), style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        
        self.view = view
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.form.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return vm.form[indexPath.row].h
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = vm.form[indexPath.row]
        let cell = UITableViewCell()
        row.bind(cell)
        return cell
    }
    
}
PlaygroundPage.current.liveView = MyViewController()
