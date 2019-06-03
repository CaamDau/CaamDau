//Created  on 2019/4/13 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 * 分页控制器 子控制器自由
 * 当然子控制器可遵循 CD_PageViewControllerProtocol 来统一制式 关联数据
 */




import Foundation
import UIKit

//MARK:--- 提供 ----------
public extension CD_PageViewController {
    func addViewController<T:CD_PageViewControllerProtocol>(_ t:T.Type, dataSource:T.DataSource? = nil, config:T.ConfigModel? = nil) {
        _viewControllers.append(t.initialize(withDataSource: dataSource, config: config))
    }
    
    func makeViewControllers<T:CD_PageViewControllerProtocol>(_ vc:[(T.Type,T.DataSource?, T.ConfigModel?)]) {
        _viewControllers = vc.map{$0.0.initialize(withDataSource: $0.1, config: $0.2)}
    }
}

public class CD_PageViewController: UIViewController {
    private lazy var model:CD_Page.Model =  {
        var m = CD_Page.Model()
        m.marge = 0
        m.space = 0
        return m
    }()
    private var selfWidth:CGFloat {
        return self.view.bounds.size.width
    }
    private var selfHeight:CGFloat {
        return self.view.bounds.size.height
    }
    private var observer:NSObjectProtocol?
    
    public weak var delegate:CD_PageScrollProtocol?
    
    public var _model:CD_Page.Model = CD_Page.Model() {
        didSet{
            var m = _model
            m.marge = 0
            m.space = 0
            model = _model
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
            .background(UIColor.blue)
            .clips(true)
            .build
    }()
    public var _viewControllers:[UIViewController] = [] {
        didSet{
            updateViewControllers()
        }
    }
    
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
    func updateViewControllers() {
        self.children.forEach { [weak self](vc) in
            let bool =  self?._viewControllers.contains(vc) ?? true
            guard !bool else { return }
            vc.view.removeFromSuperview()
            vc.removeFromParent()
        }
        updateLayoutScrollView()
    }
    func updateLayoutScrollView() {
        let count = _viewControllers.count
        switch model.scrollDirection {
        case .horizontal:
            scrollView.contentSize = CGSize(w: (CGFloat(count) * selfWidth), h: 0)
            for (i,item) in _viewControllers.enumerated() {
                debugPrint(item.view.frame)
                item.view.frame = CGRect(x: CGFloat(i)*selfWidth, y: 0, w: selfWidth, h: selfHeight)
            }
        case .vertical:
            scrollView.contentSize = CGSize(w: 0, h: (CGFloat(count) * selfHeight))
            for (i,item) in _viewControllers.enumerated() {
                debugPrint(item.view.frame)
                item.view.frame = CGRect(x:0, y: CGFloat(i)*selfHeight, w: selfWidth, h: selfHeight)
            }
        }
        //self.selectTo(false)
    }
    func reloadData() {
        guard self.selectIndex < _viewControllers.count else { return }
        for (i,item) in _viewControllers.enumerated() where (i == self.selectIndex || i == self.selectIndex+1 || i == self.selectIndex-1) && !self.children.contains(item) {
            self.addChild(item)
            item.view.tag = i + model.offsetTag
            item.view.backgroundColor = i%2==0 ? .red : .lightGray
            scrollView.addSubview(item.view)
            switch model.scrollDirection {
            case .horizontal:
                item.view.frame = CGRect(x: CGFloat(i)*selfWidth, y: 0, w: selfWidth, h: selfHeight)
            case .vertical:
                item.view.frame = CGRect(x:0, y: CGFloat(i)*selfHeight, w: selfWidth, h: selfHeight)
            }
            
            self.selectTo(true)
        }
    }
    
    func selectTo(_ animated:Bool) {
        guard selectIndex < _viewControllers.count else { return }
        guard let item = scrollView.viewWithTag(selectIndex + model.offsetTag) else { return }
        let offset = item.frame.origin
        /*
        var offset = scrollView.contentOffset
        switch model.scrollDirection {
        case .horizontal:
            offset = CGPoint(x: CGFloat(selectIndex)*selfWidth, y: 0)
        case .vertical:
            offset = CGPoint(x: 0, y: CGFloat(selectIndex)*selfHeight)
        }*/
        self.scroll(toOffset: offset, animated: animated)
    }
    func scroll(toOffset offset:CGPoint, animated:Bool = false) {
        self.scrollView.setContentOffset(offset, animated: animated)
        guard !animated else { return }
        scrollViewDidEndScrollingAnimation(self.scrollView)
    }
}

extension CD_PageViewController: CD_PageControlProtocol {
    public func didSelect(withIndex index:Int) {
        guard self.selectIndex != index else {return}
        let oldIndex = self.selectIndex
        self.selectIndex = index
        guard index < _viewControllers.count else { return }
        //guard let item = scrollView.viewWithTag(index + model.offsetTag) else { return }
        //let offset = item.frame.origin
        selectTo(abs(index-oldIndex)==1)
        //self.scroll(toOffset: offset, animated: abs(index-oldIndex)==1)
    }
}
extension CD_PageViewController: UIScrollViewDelegate {
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        var offset = CGFloat(selectIndex)
        switch model.scrollDirection {
        case .horizontal:
            offset = scrollView.contentOffset.x / scrollView.frame.size.width
        case .vertical:
            offset = scrollView.contentOffset.y / scrollView.frame.size.height
        }
        self.delegate?.scroll(didScroll: scrollView, offset:offset)
    }
    public func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        var index:Int = selectIndex
        switch model.scrollDirection {
        case .horizontal:
            index = Int(scrollView.contentOffset.x/scrollView.frame.size.width)
        case .vertical:
            index = Int(scrollView.contentOffset.y/scrollView.frame.size.height)
        }
        self.delegate?.scroll(didEndScrollingAnimation: scrollView, index:index)
        self.selectIndex = index
    }
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        var index:Int = selectIndex
        switch model.scrollDirection {
        case .horizontal:
            index = Int(scrollView.contentOffset.x/scrollView.frame.size.width)
        case .vertical:
            index = Int(scrollView.contentOffset.y/scrollView.frame.size.height)
        }
        self.delegate?.scroll(didEndDecelerating: scrollView, index:index)
        self.selectIndex = index
        
    }
    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        switch model.scrollDirection {
        case .horizontal:
            if (scrollView.contentOffset.x == 0 || scrollView.contentOffset.x + scrollView.bounds.size.width == scrollView.contentSize.width) {
                let index = Int(scrollView.contentOffset.x/scrollView.frame.size.width)
                self.delegate?.scroll(didEndDragging: scrollView, index:index)
                self.selectIndex = index
            }
        case .vertical:
            if (scrollView.contentOffset.y == 0 || scrollView.contentOffset.y + scrollView.bounds.size.height == scrollView.contentSize.height) {
                let index = Int(scrollView.contentOffset.y/scrollView.frame.size.height)
                self.delegate?.scroll(didEndDragging: scrollView, index:index)
                self.selectIndex = index
            }
        }
    }
    public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.delegate?.scroll(willBeginDragging: scrollView)
    }
}













