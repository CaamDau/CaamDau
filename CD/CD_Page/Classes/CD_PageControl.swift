//Created  on 2019/4/13 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 * 分页页面 锚点
 */



import Foundation
import UIKit
import SnapKit
import CD

public class CD_PageControl: UIView {
    public weak var delegate:CD_PageProtocol?
    
    lazy var scrollView: UIScrollView = {
        let v = UICollectionView(frame: CGRect.zero)
        v.cd
            .shows(verticalScrollIndicator: false)
            .shows(horizontalScrollIndicator: false)
            .background(UIColor.white)
        return v
    }()
    
    public var _items:[CD_RowProtocol] = [] {
        didSet{
            self.reloadData()
        }
    }
    
    public var _scrollDirection:UICollectionView.ScrollDirection = .horizontal {
        didSet{
            
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

extension CD_PageControl {
    func makeUI() {
        self.addSubview(self.scrollView)
        self.scrollView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    func reloadData() {
        for item in _items {
            
        }
    }
}

public extension CD_PageControl {
    
}

