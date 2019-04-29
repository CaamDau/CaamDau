//Created  on 2019/4/13 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 * 分页页面，轮播视图
 */





import Foundation
import UIKit
import SnapKit
import CD

public class CD_PageView: UIView {
    private static let identifier:String = "CD_PageViewUICollectionView"
    
    
    lazy var flowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = self._scrollDirection
        layout.itemSize = self._itemSize
        layout.minimumLineSpacing = self._minimumLineSpacing
        layout.minimumInteritemSpacing = self._minimumInteritemSpacing
        layout.sectionInset = self._sectionInset
        return layout
    }()
    
    lazy var collectionView: UICollectionView = {
        let v = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout)
        v.cd
            .shows(verticalScrollIndicator: false)
            .shows(horizontalScrollIndicator: false)
            .delegate(self)
            .dataSource(self)
            .background(UIColor.white)
        
        v.register(UICollectionViewCell.self, forCellWithReuseIdentifier: CD_PageView.identifier)
        return v
    }()
    
    public var _items:[String] = [] {
        didSet{
            collectionView.reloadData()
        }
    }
    
    public var _scrollDirection:UICollectionView.ScrollDirection = .horizontal {
        didSet{
            flowLayout.scrollDirection = _scrollDirection
        }
    }
    
    public var _itemSize:CGSize = CGSize(w: cd_screenW(), h: 40) {
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        makeUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        makeUI()
    }
    
    convenience init() {
        self.init(frame: CGRect.zero)
    }
}

extension CD_PageView {
    func makeUI() {
        self.collectionView.setNeedsLayout()
        self.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        self.collectionView.layoutIfNeeded()
        
    }
}

extension CD_PageView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return _items.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CD_PageView.identifier, for: indexPath)
        cell.backgroundColor =  UIColor.cd_hex(_items[indexPath.row])
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

