//Created  on 2018/12/13  by LCD :https://github.com/liucaide .

import Foundation
import UIKit

public extension CaamDau where Base: UITableView {
    
    @discardableResult
    func estimatedAll(_ height:CGFloat = CGFloat.leastNormalMagnitude) -> CaamDau {
        if #available(iOS 11.0, *) {
            base.contentInsetAdjustmentBehavior = .never
            base.estimatedRowHeight = height
            base.estimatedSectionHeaderHeight = height
            base.estimatedSectionFooterHeight = height
        }else{
            let height = height >= 2 ? height : 2
            base.estimatedRowHeight = height
            base.estimatedSectionHeaderHeight = height
            base.estimatedSectionFooterHeight = height
        }
        base.rowHeight = UITableView.automaticDimension
        base.sectionHeaderHeight = UITableView.automaticDimension
        base.sectionFooterHeight = UITableView.automaticDimension
        return self
    }
    
    @discardableResult
    func dataSource(_ d: UITableViewDataSource?) -> CaamDau {
        base.dataSource = d
        return self
    }
    
    @discardableResult
    func delegate(_ d: UITableViewDelegate?) -> CaamDau {
        base.delegate = d
        return self
    }
    
    @available(iOS 10.0, *)
    @discardableResult
    func prefetch(dataSource d: UITableViewDataSourcePrefetching?) -> CaamDau {
        base.prefetchDataSource = d
        return self
    }
    
    @available(iOS 11.0, *)
    @discardableResult
    func drag(delegate d: UITableViewDragDelegate?) -> CaamDau {
        return self
    }
    
    @available(iOS 11.0, *)
    @discardableResult
    func drop(delegate d: UITableViewDropDelegate?) -> CaamDau {
        base.dropDelegate = d
        return self
    }
    
    @discardableResult
    func background(view v: UIView?) -> CaamDau {
        base.backgroundView = v
        return self
    }
    
    @discardableResult
    func table(headerView v: UIView?) -> CaamDau {
        base.tableHeaderView = v
        return self
    }
    
    @discardableResult
    func table(footerView v: UIView?) -> CaamDau {
        base.tableFooterView = v
        return self
    }
    
    @discardableResult
    func row(height h: CGFloat) -> CaamDau {
        base.rowHeight = h
        return self
    }
    
    @discardableResult
    func section(headerHeight h: CGFloat) -> CaamDau {
        base.sectionHeaderHeight = h
        return self
    }
    
    @discardableResult
    func section(footerHeight h: CGFloat) -> CaamDau {
        base.sectionFooterHeight = h
        return self
    }
    
    @discardableResult
    func estimated(rowHeight h: CGFloat) -> CaamDau {
        base.estimatedRowHeight = h
        return self
    }
    
    @discardableResult
    func estimated(sectionHeaderHeight h: CGFloat) -> CaamDau {
        base.estimatedSectionHeaderHeight = h
        return self
    }
    
    @discardableResult
    func estimated(sectionFooterHeight h: CGFloat) -> CaamDau {
        base.estimatedSectionFooterHeight = h
        return self
    }
    
    @discardableResult
    func section(indexColor c: UIColor?) -> CaamDau {
        base.sectionIndexColor = c
        return self
    }
    
    @discardableResult
    func section(indexBackgroundColor c: UIColor?) -> CaamDau {
        base.sectionIndexBackgroundColor = c
        return self
    }
    
    @discardableResult
    func section(indexTrackingBackgroundColor c: UIColor?) -> CaamDau {
        base.sectionIndexTrackingBackgroundColor = c
        return self
    }
    
    @discardableResult
    func section(indexMinimumDisplayRowCount c: Int) -> CaamDau {
        base.sectionIndexMinimumDisplayRowCount = c
        return self
    }
    
    @discardableResult
    func separator(style s: UITableViewCell.SeparatorStyle) -> CaamDau {
        base.separatorStyle = s
        return self
    }
    
    @discardableResult
    func separator(color c: UIColor?) -> CaamDau {
        base.separatorColor = c
        return self
    }
    
    @discardableResult
    func separator(inset i: UIEdgeInsets) -> CaamDau {
        base.separatorInset = i
        return self
    }
    
    @available(iOS 11.0, *)
    @discardableResult
    func separator(insetReference i: UITableView.SeparatorInsetReference) -> CaamDau {
        base.separatorInsetReference = i
        return self
    }
}



public extension CaamDau where Base: UITableView {
    func cell(_ cellClass:AnyClass, id:String = "", bundleFrom:String = "") -> UITableViewCell? {
        let identifier = id=="" ? String(describing: cellClass) : id
        var cell = base.dequeueReusableCell(withIdentifier: identifier)
        if cell == nil  {
            if bundleFrom.isEmpty {
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
    
    func view(_ viewClass:AnyClass, id:String = "", bundleFrom:String = "") -> UITableViewHeaderFooterView? {
        let identifier = id=="" ? String(describing: viewClass) : id
        var cell = base.dequeueReusableHeaderFooterView(withIdentifier: identifier)
        if cell == nil  {
            if bundleFrom.isEmpty {
                let bundle = Bundle.main.path(forResource:identifier, ofType: "nib")
                if bundle == nil{
                    base.register(viewClass, forHeaderFooterViewReuseIdentifier: identifier)
                }else{
                    let nib = UINib(nibName:identifier, bundle: nil)
                    base.register(nib, forHeaderFooterViewReuseIdentifier: identifier)
                }
            }else{
                let nib = UINib(nibName:identifier, bundle: Bundle.cd_bundle(viewClass, bundleFrom))
                base.register(nib, forHeaderFooterViewReuseIdentifier: identifier)
            }
            cell = base.dequeueReusableHeaderFooterView(withIdentifier: identifier)
        }
        guard let ce = cell else {
            assertionFailure("👉👉👉dequeueReusableHeaderFooterView 失败，请检查你的View  👻")
            return nil
        }
        return ce
    }
}


public extension UITableView {
    
}
