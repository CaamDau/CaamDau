//Created  on 2019/4/13 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 * 分页控制器
 */




import Foundation
import UIKit
import SnapKit
import CD
import FDFullscreenPopGesture


class UICollectionViewCDPage: UICollectionView, UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        if self.contentOffset.x <= 0 {
            if (otherGestureRecognizer.delegate?.isKind(of: NSClassFromString("_FDFullscreenPopGestureRecognizerDelegate")!.self))! {
                return true
            }
        }
        return false
    }
}

extension CD_PageViewController {
    static func show() -> CD_PageViewController {
        return CD_PageViewController()
    }
}

public class CD_PageViewController: UIViewController {
    private static let identifier:String = "CD_PageUICollectionView"
    public weak var delegate:CD_PageProtocol?
    
    lazy var flowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = self._scrollDirection
        layout.itemSize = self._itemSize
        layout.minimumLineSpacing = self._minimumLineSpacing
        layout.minimumInteritemSpacing = self._minimumInteritemSpacing
        layout.sectionInset = self._sectionInset
        return layout
    }()
    
    lazy var collectionView: UICollectionViewCDPage = {
        let v = UICollectionViewCDPage(frame: CGRect.zero, collectionViewLayout: flowLayout)
        v.cd
            .shows(verticalScrollIndicator: false)
            .shows(horizontalScrollIndicator: false)
            .isPaging(enabled: true)
            .bounces(false)
            .delegate(self)
            .dataSource(self)
            .background(UIColor.white)
        
        v.register(UICollectionViewCell.self, forCellWithReuseIdentifier: CD_PageViewController.identifier)
        return v
    }()
    
    public var _viewControllers:[UIViewController] = [] {
        didSet{
            self.collectionView.reloadData()
        }
    }
    
    public var _scrollDirection:UICollectionView.ScrollDirection = .horizontal {
        didSet{
            flowLayout.scrollDirection = _scrollDirection
        }
    }
    ///itemSize 的设置注意不要超出 collectionView.bounds.size
    public var _itemSize:CGSize = CGSize(w: cd_screenW(), h: cd_screenH()) {
        didSet{
            flowLayout.itemSize = _itemSize
        }
    }
    
    public var _minimumLineSpacing:CGFloat = 0 {
        didSet{
            flowLayout.minimumLineSpacing = _minimumLineSpacing
        }
    }
    public var _minimumInteritemSpacing:CGFloat =  0 {
        didSet{
            flowLayout.minimumInteritemSpacing = _minimumInteritemSpacing
        }
    }
    public var _sectionInset:UIEdgeInsets = .zero {
        didSet{
            flowLayout.sectionInset = _sectionInset
        }
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        self.collectionView.reloadData()
    }
}

extension CD_PageViewController {
    func scroll(toItem item:Int, at:UICollectionView.ScrollPosition = .left, animated:Bool = false) {
        self.collectionView.scrollToItem(at: IndexPath(item: item, section: 0), at:at, animated: animated)
    }
    
    public func didSelect(_ index: Int) {
        if self._scrollDirection == .vertical {
            self.scroll(toItem: index, at: .centeredVertically)
        }else{
            self.scroll(toItem: index, at: .centeredHorizontally)
        }
    }
}

extension CD_PageViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self._viewControllers.count
    }
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CD_PageViewController.identifier, for: indexPath)
        
        if !self.children.contains(self._viewControllers[indexPath.row]) {
            self.addChild(self._viewControllers[indexPath.row])
        }
        
        let vv = self._viewControllers[indexPath.row].view!
        if !cell.contentView.subviews.contains(vv) {
            cell.contentView.addSubview(vv)
            vv.snp.makeConstraints { (make) in
                make.edges.equalToSuperview()
            }
        }
        cell.contentView.bringSubviewToFront(vv)
        return cell
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.delegate?.scroll(didScroll: scrollView)
    }
    public func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        self.delegate?.scroll(didEndScrollingAnimation: scrollView)
    }
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.delegate?.scroll(didEndDecelerating: scrollView)
    }
    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        self.delegate?.scroll(didEndDragging: scrollView)
    }
    public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.delegate?.scroll(willBeginDragging: scrollView)
    }
}

