//Created  on 2019/3/29 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 *
 */




import UIKit
import CD

class VC_TopBar: UIViewController {
    
    lazy var itemView:CD_TopNavigationBarItem = {
        let item = CD_TopNavigationBarItem(callBack:{ (i) in
            print("print(idx)->", i)
        })
        item.style = .value3
        item.reloadData(with: .item1, styles: [.title([(CD_IconFont.tback(30).text,CD_IconFont.tback(30).font,.black,.normal), (CD_IconFont.tback(30).text,CD_IconFont.tback(30).font,.lightGray,.highlighted), (CD_IconFont.tback(30).text,CD_IconFont.tback(30).font,.lightGray,.selected)])])
        item.reloadData(with: .item2, styles: [.title([(txt: "String", font: UIFont.systemFont(ofSize: 12), color: UIColor.red, state: UIControl.State.normal)])])
        item.reloadData(with: .item3, styles: [.title([(txt: "333", font: UIFont.systemFont(ofSize: 12), color: UIColor.red, state: UIControl.State.normal)])])
        return item
    }()
    
    lazy var itemView2:CD_TopNavigationBarItem = {
        let item = CD_TopNavigationBarItem(callBack:{ (i) in
            print("print(idx)->", i)
        })
        item.style = .value3
        item.delegate = self
        return item
    }()
    
    
    /// 导航栏
    public lazy var bar_navigation:CD_TopNavigationBar = {
        let bar =  CD_TopNavigationBar()
        bar.delegate = self
        return bar
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.view.addSubview(itemView)
        itemView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.top.equalToSuperview().offset(90)
        }
        
        self.view.addSubview(itemView2)
        itemView2.snp.makeConstraints { (make) in
            make.right.equalToSuperview()
            make.top.equalToSuperview().offset(90)
        }
        
        
        self.view.addSubview(bar_navigation)
        bar_navigation.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(itemView.snp.bottom).offset(30)
        }
    }

}
extension VC_TopBar: CD_TopNavigationBarProtocol {
    func update(withNavigationBar item: CD_TopNavigationBar.Item) -> [CD_TopNavigationBarItem.Item.Style]? {
        return nil
    }
    
    func didSelect(withNavigationBar item: CD_TopNavigationBar.Item) {
        print("NavigationBar.item->", item)
    }
}



extension VC_TopBar: CD_TopNavigationBarItemProtocol {
    func update(withBarItem tag: Int, _ item: CD_TopNavigationBarItem.Item) -> [CD_TopNavigationBarItem.Item.Style]? {
        switch item {
        case .item1:
            return [.title([(CD_IconFont.temoji(30).text,CD_IconFont.temoji(30).font,.black,.normal), (CD_IconFont.temoji(30).text,CD_IconFont.temoji(30).font,.lightGray,.highlighted), (CD_IconFont.temoji(30).text,CD_IconFont.temoji(30).font,.lightGray,.selected)])]
            
        case .item2:
            return [.image([(img: UIImage(named: "com_点赞_正点")!, state: UIControl.State.normal)])]
        case .item3:
            return nil
        case .itemNone:
            return nil
        }
    }
    
    func didSelect(withBarItem tag: Int, _ item: CD_TopNavigationBarItem.Item) {
        print("idx-->", item)
    }
    
}
