//Created  on 2019/4/13 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 * 分页控制器 子控制器自由
 * 当然子控制器应遵循 CD_UIProtocol 来统一制式 关联数据
 */




import Foundation
import UIKit


public class CD_PageViewController: UIViewController {
    
    private var selfWidth:CGFloat {
        return self.view.bounds.size.width
    }
    private var selfHeight:CGFloat {
        return self.view.bounds.size.height
    }
    private var observer:NSObjectProtocol?
    private var contentOffsetBegin:CGFloat = 0
    public weak var delegate:CD_PageScrollProtocol?
    
    public var model:CD_Page.Model =  {
        var m = CD_Page.Model()
        m.marge = 0
        m.space = 0
        return m
    }(){
        didSet{
            updateScrollView()
            updateLayoutScrollView()
        }
    }
    public var selectIndex:Int = 0 {
        didSet{
            guard oldValue != selectIndex else { return }
            reloadData()
        }
    }
    public lazy var scrollView: CD_PageUIScrollView = {
        return CD_PageUIScrollView().cd
            .bounces(false)
            .shows(verticalScrollIndicator: false)
            .shows(horizontalScrollIndicator: false)
            .delegate(self)
            .isPaging(enabled: true)
            //.background(UIColor.blue)
            .clips(true)
            .build
    }()
    
    public var dataSource:[CD_RowVCProtocol] = [] {
        didSet{
            updateViewControllers()
            reloadData()
        }
    }
    private var dataSourceSize:[(min:CGFloat, max:CGFloat, index:Int)] = []
    public override func viewDidLoad() {
        super.viewDidLoad()
        makeScrollView()
        
        observer = cd_notify().addObserver(forName: UIDevice.orientationDidChangeNotification, object: nil, queue: OperationQueue.main, using: { [weak self](n) in
            self?.updateLayoutScrollView()
            self?.selectTo(false)
        })
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.updateLayoutScrollView()
    }
}


//MARK:--- ScrollView Style ----------
extension CD_PageViewController {
    func makeScrollView()  {
        self.view.cd.add(scrollView)
        CD_Page.makeLayout(withScrollView: scrollView)
        self.view.layoutIfNeeded()
        updateLayoutScrollView()
    }
    func updateScrollView()  {
        scrollView.cd
            .bounces(model.scrollBounces)
            .isPaging(enabled: model.isScrollPaging)
    }
    func updateViewControllers() {
        self.children.forEach { [weak self](vc) in
            let bool =  self?.dataSource.contains{$0.vc == vc} ?? true
            guard !bool else { return }
            vc.view.removeFromSuperview()
            vc.removeFromParent()
        }
        updateLayoutScrollView()
    }
    
    func updateLayoutScrollView() {
        var contentSize:CGSize = CGSize.zero
        var offset:CGFloat = model.marge
        let maxIndex = dataSource.count - 1
        dataSourceSize.removeAll()
        for (i,item) in dataSource.enumerated() {
            item.view.tag = i + model.offsetTag
            switch model.scrollDirection {
            case .horizontal:
                var w = contentSize.width
                w += (item.autoLayout || item.frame.size.width<=0) ? selfWidth : item.frame.size.width
                item.view.frame = CGRect(x: offset, y: 0, w: (item.autoLayout || item.frame.size.width<=0) ? selfWidth : item.frame.size.width, h: (item.autoLayout || item.frame.size.height<=0) ? selfHeight : item.frame.size.height)
                offset += item.view.frame.width + model.space
                let min = item.view.frame.minX - (i == 0 ? model.marge : model.space)
                let max = item.view.frame.maxX + (i == maxIndex ? model.marge : model.space/2.0)
                dataSourceSize.append((min,max,i))
                contentSize = CGSize(width: offset, height: 0)
            case .vertical:
                var h = contentSize.height
                h += (item.autoLayout || item.frame.size.height<=0) ? selfHeight : item.frame.size.height
                item.view.frame = CGRect(x: 0, y: offset, w: (item.autoLayout || item.frame.size.width<=0) ? selfWidth : item.frame.size.width, h: (item.autoLayout || item.frame.size.height<=0) ? selfHeight : item.frame.size.height)
                offset += item.view.frame.height + model.space
                let min = item.view.frame.minY - (i == 0 ? model.marge : model.space)
                let max = item.view.frame.maxY + (i == maxIndex ? model.marge : model.space/2.0)
                dataSourceSize.append((min,max,i))
                contentSize = CGSize(width: 0, height: offset)
            }
        }
        scrollView.contentSize = contentSize
    }
    func reloadData() {
        guard self.selectIndex < dataSource.count else { return }
        let ss = (self.selectIndex-1...self.selectIndex+1)
        for (i,item) in dataSource.enumerated() where ss.contains(i) && !self.children.contains(item.vc) {
            self.addChild(item.vc)
            //item.view.backgroundColor = i%2==0 ? .red : .lightGray
            scrollView.addSubview(item.view)
            if i == selectIndex {
                scroll(toIndex:i, animated:false)
            }
        }
    }
    
    func selectTo(_ animated:Bool) {
        if model.isScrollPaging {
            scroll(toIndex: selectIndex, animated:animated)
        }
    }
    func scroll(toIndex index:Int, animated:Bool = false) {
        guard index < dataSourceSize.count else { return }
        var offset:CGPoint = .zero
        switch model.scrollDirection {
        case .horizontal:
            offset.x = dataSourceSize[index].min
            offset.y = 0
        case .vertical:
            offset.x = 0
            offset.y = dataSourceSize[index].min
        }
        self.scrollView.setContentOffset(offset, animated: animated)
        guard !animated else { return }
        scrollViewDidEndScrollingAnimation(self.scrollView)
    }
    
}

extension CD_PageViewController: CD_PageControlProtocol {
    public func didSelect(withIndex index:Int) {
        guard self.selectIndex != index else {return}
        self.selectIndex = index
        scroll(toIndex:index)
//        self.delegate?.scroll(didEndScrollingAnimation: scrollView, index:index, animotion:false)
    }
}
extension CD_PageViewController: UIScrollViewDelegate {
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        var contentOffset:CGFloat = 0
        var size:CGFloat = 0
        var index = selectIndex
        switch model.scrollDirection {
        case .horizontal:
            contentOffset = scrollView.contentOffset.x
            index = dataSourceSize.filter{($0.min..<$0.max).contains(contentOffset)}.map{$0.index}.first ?? selectIndex
            
            if (0..<dataSource.count).contains(index) {
                size = dataSource[index].view.frame.size.width
            }else{
                size = dataSource[selectIndex].view.frame.size.width
            }
            
        case .vertical:
            contentOffset = scrollView.contentOffset.y
            index = dataSourceSize.filter{($0.min..<$0.max).contains(contentOffset)}.map{$0.index}.first ?? selectIndex
            if (0..<dataSource.count).contains(index) {
                size = dataSource[index].view.frame.size.height
            }else{
                size = dataSource[selectIndex].view.frame.size.height
            }
        }
        let offsetRatio = contentOffset / size
        
        self.delegate?.scroll(didScroll: scrollView, contentOffset: contentOffset, offsetRatio: offsetRatio, size: size, index: index)
    }
    public func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        var contentOffset = CGFloat(self.selectIndex)
        switch model.scrollDirection {
        case .horizontal:
            contentOffset = scrollView.contentOffset.x
        case .vertical:
            contentOffset = scrollView.contentOffset.y
        }
        let index = dataSourceSize.filter{($0.min..<$0.max).contains(contentOffset)}.map{$0.index}.first ?? selectIndex
        self.delegate?.scroll(didEndScrollingAnimation: scrollView, index:index, animotion:abs(index-selectIndex)==1)
        self.selectIndex = index
    }
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        var contentOffset = CGFloat(self.selectIndex)
        switch model.scrollDirection {
        case .horizontal:
            contentOffset = scrollView.contentOffset.x
        case .vertical:
            contentOffset = scrollView.contentOffset.y
        }
        let index = dataSourceSize.filter{($0.min..<$0.max).contains(contentOffset)}.map{$0.index}.first ?? selectIndex
        self.delegate?.scroll(didEndDecelerating: scrollView, index:index)
        self.selectIndex = index
        
    }
    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        var contentOffset = CGFloat(self.selectIndex)
        switch model.scrollDirection {
        case .horizontal:
            if (scrollView.contentOffset.x == 0 || scrollView.contentOffset.x + scrollView.bounds.size.width == scrollView.contentSize.width) {
                contentOffset = scrollView.contentOffset.x
                let index = dataSourceSize.filter{($0.min..<$0.max).contains(contentOffset)}.map{$0.index}.first ?? selectIndex
                self.delegate?.scroll(didEndDragging: scrollView, index:index)
                self.selectIndex = index
            }
        case .vertical:
            if (scrollView.contentOffset.y == 0 || scrollView.contentOffset.y + scrollView.bounds.size.height == scrollView.contentSize.height) {
                
                contentOffset = scrollView.contentOffset.y
                let index = dataSourceSize.filter{($0.min..<$0.max).contains(contentOffset)}.map{$0.index}.first ?? selectIndex
                self.delegate?.scroll(didEndDragging: scrollView, index:index)
                self.selectIndex = index
            }
        }
    }
    public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        switch model.scrollDirection {
        case .horizontal:
            contentOffsetBegin = scrollView.contentOffset.x
        case .vertical:
            contentOffsetBegin = scrollView.contentOffset.y
        }
        self.delegate?.scroll(willBeginDragging: scrollView, offset:contentOffsetBegin)
    }
}
