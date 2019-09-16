//Created  on 2019/5/16 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 *
 */




import Foundation
import SnapKit

extension CD_HUD {
    func makeHUDLayoutPositionTop() {
        guard let _ = self.superview else { return }
        if model._isEnabledMask {
            self.snp.makeConstraints { (make) in
                make.top.equalToSuperview().offset(model._offsetTopY)
                make.bottom.lessThanOrEqualToSuperview().offset(-model._margeMask)
                make.centerX.equalToSuperview()
                make.left.greaterThanOrEqualToSuperview().offset(model._margeMask)
            }
            contentView?.snp.makeConstraints({ (make) in
                make.edges.equalToSuperview()
            })
        }else{
            self.snp.makeConstraints { (make) in
                make.edges.equalToSuperview()
            }
            contentView?.snp.makeConstraints({ (make) in
                make.top.equalToSuperview().offset(model._offsetTopY)
                make.bottom.lessThanOrEqualToSuperview().offset(-model._margeMask)
                make.centerX.equalToSuperview()
                make.left.greaterThanOrEqualToSuperview().offset(model._margeMask)
            })
        }
        makeContentViewLayoutDefault()
    }
    
    func makeHUDLayoutPositionBottom() {
        if model._isEnabledMask {
            self.snp.makeConstraints { (make) in
                make.bottom.equalToSuperview().offset(-model._offsetBottomY)
                make.centerX.equalToSuperview()
                make.left.top.greaterThanOrEqualToSuperview().offset(model._margeMask)
            }
            contentView?.snp.makeConstraints({ (make) in
                make.edges.equalToSuperview()
            })
        }else{
            self.snp.makeConstraints { (make) in
                make.edges.equalToSuperview()
            }
            contentView?.snp.makeConstraints({ (make) in
                make.bottom.equalToSuperview().offset(-model._offsetBottomY)
                make.top.greaterThanOrEqualToSuperview().offset(model._margeMask)
                make.centerX.equalToSuperview()
                make.left.greaterThanOrEqualToSuperview().offset(model._margeMask)
            })
        }
        makeContentViewLayoutDefault()
    }
    
    func makeHUDLayoutPositionCenter() {
        if model._isEnabledMask {
            self.snp.makeConstraints { (make) in
                make.center.equalToSuperview()
                make.left.top.greaterThanOrEqualToSuperview().offset(model._margeMask)
            }
            contentView?.snp.makeConstraints({ (make) in
                make.edges.equalToSuperview()
            })
        }else{
            self.snp.makeConstraints { (make) in
                make.edges.equalToSuperview()
            }
            contentView?.snp.makeConstraints({ (make) in
                make.center.equalToSuperview()
                make.left.top.greaterThanOrEqualToSuperview().offset(model._margeMask)
            })
        }
        makeContentViewLayoutDefault()
    }
    
    func makeHUDLayoutPositionCustom(_ offsetY:CGFloat) {
        guard let supV = self.superview else { return }
        if model._isEnabledMask {
            self.snp.makeConstraints { (make) in
                make.centerX.equalToSuperview()
                make.left.top
                    .greaterThanOrEqualToSuperview()
                    .offset(model._margeMask)
                if offsetY < 0 {
                    make.centerY
                        .equalTo(supV.snp.bottom).offset(offsetY)
                }else if offsetY > 0{
                    make.centerY
                        .equalTo(supV.snp.top).offset(offsetY)
                }else{
                    make.centerY.equalToSuperview()
                }
            }
            contentView?.snp.makeConstraints({ (make) in
                make.edges.equalToSuperview()
            })
        }else{
            self.snp.makeConstraints { (make) in
                make.edges.equalToSuperview()
            }
            contentView?.snp.makeConstraints({ (make) in
                make.centerX.equalToSuperview()
                make.left.top
                    .greaterThanOrEqualToSuperview()
                    .offset(model._margeMask)
                if offsetY < 0 {
                    make.centerY
                        .equalTo(self.snp.bottom).offset(offsetY)
                }else if offsetY > 0{
                    make.centerY
                        .equalTo(self.snp.top).offset(offsetY)
                }else{
                    make.centerY.equalToSuperview()
                }
            })
        }
        makeContentViewLayoutDefault()
    }
    
    func makeContentViewLayoutDefault() {
        guard model._isSquare && model._axis == .vertical else { return }
        switch style {
        case .loading, .info, .succeed, .warning, .error,
             .progress(.default(_,_)):
            contentView?.snp.makeConstraints({ (make) in
                make.width.equalTo(contentView!.snp.height)
            })
        case .text:
            break
        case .progress(.view(_)):
            break
        case .custom(_):
            break
        }
    }
    func makeHUDLayot() {
        switch model._position {
        case .top:
            makeHUDLayoutPositionTop()
        case .bottom:
            makeHUDLayoutPositionBottom()
        case .center:
            makeHUDLayoutPositionCenter()
        case .custom(let offsetY):
            makeHUDLayoutPositionCustom(offsetY)
        }
    }
}


extension CD_HUDContentView {
    func makeTextLayout(_ alone:Bool)  {
        if alone {
            view_text.snp.makeConstraints { (make) in
                make.left.top.equalToSuperview().offset(model._marge)
                make.center.equalToSuperview()
            }
        }else{
            switch model._axis {
            case .horizontal:
                view_text.snp.remakeConstraints { (make) in
                    make.top.greaterThanOrEqualToSuperview().offset(model._marge)
                    make.centerY.equalToSuperview()
                    make.right.equalToSuperview().offset(-model._marge)
                }
            case .vertical:
                view_text.snp.remakeConstraints { (make) in
                    make.left.greaterThanOrEqualToSuperview().offset(model._marge)
                    make.centerX.equalToSuperview()
                    make.bottom.equalToSuperview().offset(-model._marge)
                }
            }
        }
    }
    
    func makeIconLayout(_ alone:Bool) {
        if alone {
            view_icon.snp.makeConstraints { (make) in
                make.left.top.equalToSuperview().offset(model._marge)
                make.center.equalToSuperview()
            }
        }else{
            switch model._axis {
            case .horizontal:
                view_icon.snp.makeConstraints { (make) in
                    make.top.greaterThanOrEqualToSuperview().offset(model._marge)
                    make.left.equalToSuperview().offset(model._marge)
                    make.centerY.equalToSuperview()
                    make.right.equalTo(view_text.snp.left).offset(-model._space)
                }
            case .vertical:
                view_icon.snp.makeConstraints { (make) in
                    make.top.left.greaterThanOrEqualToSuperview().offset(model._marge)
                    make.centerX.equalToSuperview()
                    make.bottom.equalTo(view_text.snp.top).offset(-model._space)
                }
            }
        }
    }
}
