//Created  on 2019/4/13 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 * 分页页面 锚点
 */



import Foundation
import UIKit


extension CD_PageControl: CD_PageControlDataSource {
    public func scrolling(_ offset:CGFloat, index:Int){
        let index:Int = index
        let indexR:Int = index + 1
        let scaleR:CGFloat = offset - CGFloat(index)
        let scale:CGFloat = 1 - scaleR
        guard var item = itemView.viewWithTag(index+model.offsetTag) as? Item else {
            return
        }
        item.scale = scale
        guard indexR < itemView.subviews.count, var itemR = itemView.viewWithTag(indexR+model.offsetTag) as? Item else {
            return
        }
        itemR.scale = scaleR
    }
    
    public func scrollDidEnd(_ index: Int) {
        guard var sender = itemView.viewWithTag(index+model.offsetTag) as? Item else {
            return
        }
        var point = scrollView.contentOffset
        switch model.scrollDirection {
        case .horizontal:
            var offset = sender.center.x - scrollView.frame.size.width * 0.5
            let offsetMax = scrollView.contentSize.width - scrollView.frame.size.width
            if (offset < 0) {
                offset = 0
            } else if (offset > offsetMax) {
                offset = offsetMax
            }
            point.x = offset
            
        case .vertical:
            var offset = sender.center.y - scrollView.frame.size.height * 0.5
            let offsetMax = scrollView.contentSize.height - scrollView.frame.size.height
            if (offset < 0) {
                offset = 0
            } else if (offset > offsetMax) {
                offset = offsetMax
            }
            point.y = offset
        }
        scrollView.setContentOffset(point, animated: true)
        itemView.subviews.forEach { (v) in
            guard var btn = v as? Item else { return }
            btn.scale = 0.0
        }
        sender.scale = 1.0
        self.index = index
    }
    public var selectIndex: Int {
        get {
            return index
        }
        set {
            index = newValue
            self.delegate?.didSelect(withIndex: newValue)
        }
    }
    
    public typealias DataSource = [Any]
    public var dataSource: [Any] {
        get {
            return _dataSource
        }
        set {
            _dataSource = newValue
        }
    }
}


public class CD_PageControl<Item: CD_PageControlItemProtocol, Buoy:CD_PageControlBuoyProtocol>: UIView where Item: UIView, Buoy: UIView {
    public weak var delegate:CD_PageControlProtocol?
    public weak var delegateScroll:CD_PageScrollProtocol?
    public var model:CD_Page.Model = CD_Page.Model() {
        didSet{
            reloadData()
        }
    }
    
    private var _dataSource:[Any] = [] {
        didSet{
            reloadData()
        }
    }
    private var index:Int = 0
    
    public lazy var scrollView: CD_PageUIScrollView = {
        return CD_PageUIScrollView().cd
            .bounces(false)
            .shows(verticalScrollIndicator: false)
            .shows(horizontalScrollIndicator: false)
            .background(UIColor.blue)
            .clips(true)
            .build
    }()
    public lazy var itemView: UIView = {
        return UIView().cd
            .background(UIColor.orange)
            .clips(true)
            .build
    }()
    
    public var buoy: Buoy?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        makeUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        makeUI()
    }
    public var itemConfig:Item.ConfigModel? {
        didSet{
            reloadData()
        }
    }
    public var buoyConfig:Buoy.ConfigModel? {
        didSet{
            self.buoy?.config = buoyConfig
            reloadData()
        }
    }
    public convenience init(frame: CGRect = .zero, itemConfig item:Item.ConfigModel? = nil, buoyConfig buoy:Buoy.ConfigModel? = nil, model:CD_Page.Model? = nil) {
        self.init(frame: CGRect.zero)
        self.model = model ?? CD_Page.Model()
        itemConfig = item
        guard buoy != nil else { return }
        buoyConfig = buoy
        self.buoy = Buoy().cd.tag(-888).build
        self.buoy?.config = buoy
    }
}

extension CD_PageControl {
    func makeUI() {
        self.backgroundColor = UIColor.yellow
        self.cd.add(scrollView)
        self.scrollView.cd.add(itemView)
        CD_Page.makeLayout(withScrollView: scrollView)
        CD_Page.makeLayout(withItemView: itemView, model: model)
        reloadData()
    }
    
    func reloadData() {
        itemView.subviews.forEach{$0.removeFromSuperview()}
        var marge:CGFloat = 0
        for (i,item) in _dataSource.enumerated() {
            var controlItem = Item()
            controlItem.config = itemConfig
            controlItem.dataSource = item as? Item.DataSource
            controlItem.scale = i == index ? 1.0 : 0.0
            controlItem.click = { [weak self] in
                self?.clickControl(withIndex:i)
            }
            controlItem.tag = i + model.offsetTag
            controlItem.backgroundColor = i%2==0 ? .red : .lightGray
            itemView.addSubview(controlItem)
            
            CD_Page.layoutForEach(&marge, idx: i, scrollView: scrollView, itemView: itemView, item: controlItem, count: _dataSource.count, model: model)
        }
        
        
        itemView.cd.add(buoy)
        scrollView.layoutIfNeeded()
        buoy?.config = buoyConfig
        my_scrollViewDidEndScrolling(nil, index:index, animotion:false)
        //buoy?.scroll(endScroll: nil, index: index, animotion:false)
    }
    func clickControl(withIndex idx:Int) {
        self.delegate?.didSelect(withIndex: idx)
    }
}



//MARK:--- 默认的，后期再看怎么更好的将 item 部分拆出去 ----------
extension CD_PageControl: CD_PageScrollProtocol {
    func my_scrollViewDidEndScrolling(_ view: UIScrollView?, index:Int, animotion:Bool) {
        // 浮漂部分
        let item = itemView.viewWithTag(index + model.offsetTag)
        buoy?.scroll(endScroll: view, index:index, item:item, scrollDirection:model.scrollDirection, animotion:animotion)
        self.scrollDidEnd(index)
    }
    
    public func scroll(didScroll view: UIScrollView, contentOffset:CGFloat, offsetRatio:CGFloat, size:CGFloat, index:Int) {
        
        self.scrolling(offsetRatio, index: index)
        
        
        func makeOffset() -> CGFloat {
            let index:Int = index
            let indexR:Int = index + 1
            guard let item = itemView.viewWithTag(index+model.offsetTag) else {
                return 0
            }
            guard indexR < itemView.subviews.count, let itemR = itemView.viewWithTag(indexR+model.offsetTag) else {
                return 0
            }
            var offsetMax:CGFloat = 0
            switch model.scrollDirection {
            case .horizontal:
                offsetMax = itemR.frame.size.width/2 + item.frame.size.width/2 + abs(CGFloat(itemR.frame.minX-item.frame.maxX))
            case .vertical:
                offsetMax = itemR.frame.size.height/2 + item.frame.size.height/2 + abs(CGFloat(itemR.frame.minY-item.frame.maxY))
            }
            return offsetMax/size
        }
        
        buoy?.scroll(didScroll: view, contentOffset:contentOffset, offsetRatio:offsetRatio, size:size, index:index, offsetItemWidthScale: makeOffset(), scrollDirection:model.scrollDirection)
    }
    
    public func scroll(didEndScrollingAnimation view: UIScrollView, index:Int, animotion:Bool) {
        my_scrollViewDidEndScrolling(view, index:index, animotion:animotion)
    }
    
    public func scroll(didEndDecelerating view: UIScrollView, index:Int) {
        my_scrollViewDidEndScrolling(view, index:index, animotion:true)
    }
    
    public func scroll(didEndDragging view: UIScrollView, index:Int) {
        my_scrollViewDidEndScrolling(view, index:index, animotion:true)
        
    }
    
    public func scroll(willBeginDragging view: UIScrollView, offset: CGFloat) {
        
        buoy?.scroll(willBeginDragging: view, offset: offset)
    }
}
