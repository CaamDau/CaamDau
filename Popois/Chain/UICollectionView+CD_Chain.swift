//Created  on 2019/2/28 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 *
 */

import Foundation
import UIKit

public extension CD where Base: UICollectionView {
    
    @discardableResult
    func background(view v: UIView?) -> CD {
        base.backgroundView = v
        return self
    }
    
    @discardableResult
    func layout(_ l: UICollectionViewLayout) -> CD {
        base.collectionViewLayout = l
        return self
    }
    
    @discardableResult
    func dataSource(_ d: UICollectionViewDataSource?) -> CD {
        base.dataSource = d
        return self
    }
    
    @discardableResult
    func delegate(_ d: UICollectionViewDelegate?) -> CD {
        base.delegate = d
        return self
    }
    
    @discardableResult
    func prefetch(dataSource d: UICollectionViewDataSourcePrefetching?) -> CD {
        if #available(iOS 10.0, *) {
            base.prefetchDataSource = d
        } else {
            // Fallback on earlier versions
        }
        return self
    }
    
    @discardableResult
    func isPrefetching(enabled e: Bool) -> CD {
        if #available(iOS 10.0, *) {
            base.isPrefetchingEnabled = e
        } else {
            // Fallback on earlier versions
        }
        return self
    }
    
}
