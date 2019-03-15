//Created  on 2019/2/28 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 *
 */

import Foundation
import UIKit

public extension CD where Base: UITableView {
    func cell(_ cellClass:AnyClass, id:String = "", bundleFrom:String = "") -> UITableViewCell? {
        let identifier = id=="" ? String(describing: cellClass) : id
        var cell = base.dequeueReusableCell(withIdentifier: identifier)
        if cell == nil  {
            if bundleFrom.count == 0 {
                let bundle = Bundle.main.path(forResource:identifier, ofType: "nib")
                if bundle == nil{
                    base.register(cellClass, forCellReuseIdentifier: identifier)
                }else{
                    let nib = UINib(nibName:identifier, bundle: nil)
                    base.register(nib, forCellReuseIdentifier: identifier)
                }
            }else{
                let nib = UINib(nibName:identifier, bundle: Bundle.cd_bundle(cellClass, bundleFrom))
                base.register(nib, forCellReuseIdentifier: identifier)
            }
            cell = base.dequeueReusableCell(withIdentifier: identifier)
        }
        guard let ce = cell else {
            assertionFailure("👉👉👉dequeueReusableCell 失败，请检查你的cell  👻")
            return nil
        }
        return ce
    }
    
    @discardableResult
    func estimatedAll() -> CD {
        if #available(iOS 11.0, *) {
            base.contentInsetAdjustmentBehavior = .never
        }
        base.estimatedRowHeight = 0
        base.estimatedSectionHeaderHeight = 0
        base.estimatedSectionFooterHeight = 0
        return self
    }
    
    @discardableResult
    func dataSource(_ d: UITableViewDataSource?) -> CD {
        base.dataSource = d
        return self
    }
    
    @discardableResult
    func delegate(_ d: UITableViewDelegate?) -> CD {
        base.delegate = d
        return self
    }
    
    @available(iOS 10.0, *)
    @discardableResult
    func prefetch(dataSource d: UITableViewDataSourcePrefetching?) -> CD {
        base.prefetchDataSource = d
        return self
    }
    
    @available(iOS 11.0, *)
    @discardableResult
    func drag(delegate d: UITableViewDragDelegate?) -> CD {
        return self
    }
    
    @available(iOS 11.0, *)
    @discardableResult
    func drop(delegate d: UITableViewDropDelegate?) -> CD {
        base.dropDelegate = d
        return self
    }
    
    @discardableResult
    func background(view v: UIView?) -> CD {
        base.backgroundView = v
        return self
    }
    
    @discardableResult
    func table(headerView v: UIView?) -> CD {
        base.tableHeaderView = v
        return self
    }
    
    @discardableResult
    func table(footerView v: UIView?) -> CD {
        base.tableFooterView = v
        return self
    }
    
    @discardableResult
    func row(height h: CGFloat) -> CD {
        base.rowHeight = h
        return self
    }
    
    @discardableResult
    func section(headerHeight h: CGFloat) -> CD {
        base.sectionHeaderHeight = h
        return self
    }
    
    @discardableResult
    func section(footerHeight h: CGFloat) -> CD {
        base.sectionFooterHeight = h
        return self
    }
    
    @discardableResult
    func estimated(rowHeight h: CGFloat) -> CD {
        base.estimatedRowHeight = h
        return self
    }
    
    @discardableResult
    func estimated(sectionHeaderHeight h: CGFloat) -> CD {
        base.estimatedSectionHeaderHeight = h
        return self
    }
    
    @discardableResult
    func estimated(sectionFooterHeight h: CGFloat) -> CD {
        base.estimatedSectionFooterHeight = h
        return self
    }
    
    @discardableResult
    func section(indexColor c: UIColor?) -> CD {
        base.sectionIndexColor = c
        return self
    }
    
    @discardableResult
    func section(indexBackgroundColor c: UIColor?) -> CD {
        base.sectionIndexBackgroundColor = c
        return self
    }
    
    @discardableResult
    func section(indexTrackingBackgroundColor c: UIColor?) -> CD {
        base.sectionIndexTrackingBackgroundColor = c
        return self
    }
    
    @discardableResult
    func section(indexMinimumDisplayRowCount c: Int) -> CD {
        base.sectionIndexMinimumDisplayRowCount = c
        return self
    }
    
    @discardableResult
    func separator(style s: UITableViewCell.SeparatorStyle) -> CD {
        base.separatorStyle = s
        return self
    }
    
    @discardableResult
    func separator(color c: UIColor?) -> CD {
        base.separatorColor = c
        return self
    }
    
    @discardableResult
    func separator(inset i: UIEdgeInsets) -> CD {
        base.separatorInset = i
        return self
    }
    
    @available(iOS 11.0, *)
    @discardableResult
    func separator(insetReference i: UITableView.SeparatorInsetReference) -> CD {
        base.separatorInsetReference = i
        return self
    }
}
