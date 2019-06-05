//Created  on 2019/5/30 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 *
 */




import Foundation
import UIKit
import SnapKit
import CD

extension CD_Page {
    static func makeLayout(withScrollView view:UIScrollView) {
        view.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    static func updateLayout(withScrollView view:UIScrollView, maxW:CGFloat, model:CD_Page.Model) {
        switch model.alignment {
        case .leftOrTop where model.scrollDirection == .horizontal:
            view.snp.remakeConstraints { (make) in
                make.left.equalToSuperview()
                make.top.bottom.equalToSuperview()
                make.width.equalTo(maxW)
            }
        case .leftOrTop where model.scrollDirection == .vertical:
            view.snp.remakeConstraints { (make) in
                make.left.right.equalToSuperview()
                make.top.equalToSuperview()
                make.height.equalTo(maxW)
            }
        case .center where model.scrollDirection == .horizontal:
            view.snp.remakeConstraints { (make) in
                make.centerX.equalToSuperview()
                make.top.bottom.equalToSuperview()
                make.width.equalTo(maxW)
            }
        case .center where model.scrollDirection == .vertical:
            view.snp.remakeConstraints { (make) in
                make.centerY.equalToSuperview()
                make.left.right.equalToSuperview()
                make.height.equalTo(maxW)
            }
        case .rightOrBottom where model.scrollDirection == .horizontal:
            view.snp.remakeConstraints { (make) in
                make.right.equalToSuperview()
                make.top.bottom.equalToSuperview()
                make.width.equalTo(maxW)
            }
        case .rightOrBottom where model.scrollDirection == .vertical:
            view.snp.remakeConstraints { (make) in
                make.bottom.equalToSuperview()
                make.left.right.equalToSuperview()
                make.height.equalTo(maxW)
            }
        case .leftOrTop:
            break
        case .center:
            break
        case .rightOrBottom:
            break
        }
    }
    
    static func makeLayout(withItemView view:UIView, model:CD_Page.Model) {
        switch model.scrollDirection {
        case .horizontal:
            view.snp.makeConstraints { (make) in
                make.left.top.right.height.equalToSuperview()
            }
        case .vertical:
            view.snp.makeConstraints { (make) in
                make.left.top.bottom.width.equalToSuperview()
            }
        }
        
    }
    static func updateLayout(withItemView view:UIView, item:UIView, model:CD_Page.Model) {
        switch model.scrollDirection {
        case .horizontal:
            view.snp.remakeConstraints { (make) in
                make.left.top.right.height.equalToSuperview()
                make.right.equalTo(item.snp.right)
                    .offset(model.marge)
            }
        case .vertical:
            view.snp.remakeConstraints { (make) in
                make.left.top.bottom.width.equalToSuperview()
                make.bottom.equalTo(item.snp.bottom)
                    .offset(model.marge)
            }
        }
    }
    
    static func makeLayout(withItem view:UIView, offset:CGFloat, model:CD_Page.Model) {
        switch model.scrollDirection {
        case .horizontal:
            view.snp.makeConstraints { (make) in
                make.left.equalToSuperview().offset(offset)
                make.centerY.equalToSuperview()
                make.height.equalToSuperview()
            }
        case .vertical:
            view.snp.makeConstraints { (make) in
                make.top.equalToSuperview().offset(offset)
                make.centerX.equalToSuperview()
                make.width.equalToSuperview()
            }
        }
    }
    
    
    static func layoutForEach(_ marge:inout CGFloat, idx:Int, scrollView:UIScrollView, itemView:UIView, item:UIView, count:Int, model:CD_Page.Model) {
        let offset = marge + (idx==0 ? model.marge : model.space)
        CD_Page.makeLayout(withItem: item, offset: offset, model: model)
        scrollView.layoutIfNeeded()
        switch model.scrollDirection {
        case .horizontal:
            marge = item.frame.maxX
        case .vertical:
            marge = item.frame.maxY
        }
        
        if idx == count-1 {
            CD_Page.updateLayout(withItemView: itemView, item: item, model: model)
            let maxW = marge+model.marge
            switch model.scrollDirection {
            case .horizontal:
                if let v = scrollView.superview, maxW < v.frame.size.width {
                    CD_Page.updateLayout(withScrollView: scrollView, maxW: maxW, model: model)
                }
            case .vertical:
                if let v = scrollView.superview, maxW < v.frame.size.height {
                    CD_Page.updateLayout(withScrollView: scrollView, maxW: maxW, model: model)
                }
            }
        }
    }
}

/*
//MARK:--- CD_PageControl ----------
extension CD_PageControl {
    func makeLayoutScrollView() {
        scrollView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    func updateLayoutScrollView(_ maxW:CGFloat) {
        switch model.alignment {
        case .leftOrTop where model.scrollDirection == .horizontal:
            scrollView.snp.remakeConstraints { (make) in
                make.left.equalToSuperview()
                make.top.bottom.equalToSuperview()
                make.width.equalTo(maxW)
            }
        case .leftOrTop where model.scrollDirection == .vertical:
            scrollView.snp.remakeConstraints { (make) in
                make.left.right.equalToSuperview()
                make.top.equalToSuperview()
                make.height.equalTo(maxW)
            }
        case .center where model.scrollDirection == .horizontal:
            scrollView.snp.remakeConstraints { (make) in
                make.centerX.equalToSuperview()
                make.top.bottom.equalToSuperview()
                make.width.equalTo(maxW)
            }
        case .center where model.scrollDirection == .vertical:
            scrollView.snp.remakeConstraints { (make) in
                make.centerY.equalToSuperview()
                make.left.right.equalToSuperview()
                make.height.equalTo(maxW)
            }
        case .rightOrBottom where model.scrollDirection == .horizontal:
            scrollView.snp.remakeConstraints { (make) in
                make.right.equalToSuperview()
                make.top.bottom.equalToSuperview()
                make.width.equalTo(maxW)
            }
        case .rightOrBottom where model.scrollDirection == .vertical:
            scrollView.snp.remakeConstraints { (make) in
                make.bottom.equalToSuperview()
                make.left.right.equalToSuperview()
                make.height.equalTo(maxW)
            }
        case .leftOrTop:
            break
        case .center:
            break
        case .rightOrBottom:
            break
        }
    }
    
    func makeLayoutItemView() {
        switch model.scrollDirection {
        case .horizontal:
            itemView.snp.makeConstraints { (make) in
                make.left.top.right.height.equalToSuperview()
            }
        case .vertical:
            itemView.snp.makeConstraints { (make) in
                make.left.top.bottom.width.equalToSuperview()
            }
        }
        
    }
    func updateLayoutItemView(_ view:UIView) {
        switch model.scrollDirection {
        case .horizontal:
            itemView.snp.remakeConstraints { (make) in
                make.left.top.right.height.equalToSuperview()
                make.right.equalTo(view.snp.right)
                    .offset(model.marge)
            }
        case .vertical:
            itemView.snp.remakeConstraints { (make) in
                make.left.top.bottom.width.equalToSuperview()
                make.bottom.equalTo(view.snp.bottom)
                    .offset(model.marge)
            }
        }
    }
    
    func makeLayoutControlItem(_ view:UIView, _ offset:CGFloat) {
        switch model.scrollDirection {
        case .horizontal:
            view.snp.makeConstraints { (make) in
                make.left.equalToSuperview().offset(offset)
                make.centerY.equalToSuperview()
                make.height.equalToSuperview()
            }
        case .vertical:
            view.snp.makeConstraints { (make) in
                make.top.equalToSuperview().offset(offset)
                make.centerX.equalToSuperview()
                make.width.equalToSuperview()
            }
        }
    }
    
}


//MARK:--- CD_PageViewController ----------
extension CD_PageViewController {
    func makeLayoutScrollView() {
        scrollView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    func updateLayoutScrollView(_ maxW:CGFloat) {
        switch model.alignment {
        case .leftOrTop where model.scrollDirection == .horizontal:
            scrollView.snp.remakeConstraints { (make) in
                make.left.equalToSuperview()
                make.top.bottom.equalToSuperview()
                make.width.equalTo(maxW)
            }
        case .leftOrTop where model.scrollDirection == .vertical:
            scrollView.snp.remakeConstraints { (make) in
                make.left.right.equalToSuperview()
                make.top.equalToSuperview()
                make.height.equalTo(maxW)
            }
        case .center where model.scrollDirection == .horizontal:
            scrollView.snp.remakeConstraints { (make) in
                make.centerX.equalToSuperview()
                make.top.bottom.equalToSuperview()
                make.width.equalTo(maxW)
            }
        case .center where model.scrollDirection == .vertical:
            scrollView.snp.remakeConstraints { (make) in
                make.centerY.equalToSuperview()
                make.left.right.equalToSuperview()
                make.height.equalTo(maxW)
            }
        case .rightOrBottom where model.scrollDirection == .horizontal:
            scrollView.snp.remakeConstraints { (make) in
                make.right.equalToSuperview()
                make.top.bottom.equalToSuperview()
                make.width.equalTo(maxW)
            }
        case .rightOrBottom where model.scrollDirection == .vertical:
            scrollView.snp.remakeConstraints { (make) in
                make.bottom.equalToSuperview()
                make.left.right.equalToSuperview()
                make.height.equalTo(maxW)
            }
        case .leftOrTop:
            break
        case .center:
            break
        case .rightOrBottom:
            break
        }
    }
    
    func makeLayoutItemView() {
        switch model.scrollDirection {
        case .horizontal:
            itemView.snp.makeConstraints { (make) in
                make.left.top.right.height.equalToSuperview()
            }
        case .vertical:
            itemView.snp.makeConstraints { (make) in
                make.left.top.bottom.width.equalToSuperview()
            }
        }
        
    }
    func updateLayoutItemView(_ view:UIView) {
        switch model.scrollDirection {
        case .horizontal:
            itemView.snp.remakeConstraints { (make) in
                make.left.top.right.height.equalToSuperview()
                make.right.equalTo(view.snp.right)
            }
        case .vertical:
            itemView.snp.remakeConstraints { (make) in
                make.left.top.bottom.width.equalToSuperview()
                make.bottom.equalTo(view.snp.bottom)
            }
        }
    }
    
    func makeLayoutControlItem(_ view:UIView, _ offset:CGFloat) {
        switch model.scrollDirection {
        case .horizontal:
            view.snp.makeConstraints { (make) in
                make.left.equalToSuperview().offset(offset)
                make.centerY.equalToSuperview()
                make.height.equalToSuperview()
            }
        case .vertical:
            view.snp.makeConstraints { (make) in
                make.top.equalToSuperview().offset(offset)
                make.centerX.equalToSuperview()
                make.width.equalToSuperview()
            }
        }
    }
}
*/



extension CD_PageControlItem {
    func makeLayoutLine(_ line:UIView, _ m:CD_PageControlItem.Model)  {
        line.snp.makeConstraints { (make) in
            switch m.linePosition {
            case .left(let f):
                make.left.equalToSuperview().offset(f)
                make.centerY.equalToSuperview()
            case .right(let f):
                make.centerY.equalToSuperview()
                make.right.equalToSuperview().offset(f)
            case .top(let f):
                make.centerX.equalToSuperview()
                make.top.equalToSuperview().offset(f)
            case .center(let x, let y):
                make.centerY.equalToSuperview().offset(y)
                make.centerX.equalToSuperview().offset(x)
            case .bottom(let f):
                make.centerX.equalToSuperview()
                make.bottom.equalToSuperview().offset(f)
            }
            
            if case .auto = m.lineSize.w  {
                make.width.equalToSuperview()
            }else{
                make.width.equalTo(m.lineSize.w.rawValue)
            }
            if case .auto = m.lineSize.h  {
                make.height.equalToSuperview()
            }else{
                make.height.equalTo(m.lineSize.h.rawValue)
            }
        }
    }
}
