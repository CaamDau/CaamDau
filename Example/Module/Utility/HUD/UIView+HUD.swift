//Created  on 2019/4/17 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 *
 */




import UIKit
import CaamDau

public func hud_loading(_ view:UIView? = CD.visibleVC?.view, title:String = "") {
    view?.hud_loading(title)
}

public func hud_succeed(_ title:String) {
    CD.window?.hud_succeed(title)
}

public func hud_msg(_ title:String, detail:String = "") {
    if detail.count > 30 {
        CD.visibleVC?.view.hud_msg(title, detail:title)
    }
    else if title.count > 30 &&  detail.isEmpty {
        CD.visibleVC?.view.hud_msg("", detail:title)
    }
    else{
        CD.window?.hud_msg(title, detail:detail)
    }
}

public func hud_error(_ title:String, detail:String = "") {
    if detail.count > 30 {
        CD.visibleVC?.view.hud_error(title, detail:title)
    }
    else if title.count > 30 &&  detail.isEmpty {
        CD.visibleVC?.view.hud_error("", detail:title)
    }
    else{
        CD.window?.hud_error(title, detail:detail)
    }
}

public func hud_info(_ title:String) {
    CD.window?.hud_info(title)
}

public func hud_hidden() {
    CD.window?.hud_hidden()
    CD.visibleVC?.view?.hud_hidden()
}

public extension UIView {
    func hud_loading(_ title:String = "") {
        self.cd.hud_remove()
        //var model = HUD.modelDefault
        //model._axis = .horizontal
        //model._textAlignment = .left
        //model._isSquare = false
        self.cd.hud(.loading(.activity), title: title)
    }
    func hud_hidden() {
        self.cd.hud_remove()
        CD.window?.cd.hud_remove()
    }
    func hud_msg(_ title:String, detail:String = "") {
        self.cd.hud_remove()
        var model = HUD.modelDefault
        model._position = .bottom
        model._showAnimation = .slide
        model._isEnabledMask = true
        self.cd.hud(.text, title: title, model:model)
    }
    
    func hud_succeed(_ title:String) {
        self.cd.hud_remove()
        var model = HUD.modelDefault
        model._axis = .horizontal
        model._textAlignment = .left
        model._isSquare = false
        self.cd.hud(.succeed, title: title, model:model)
    }
    
    func hud_error(_ title:String, detail:String = "") {
        self.cd.hud_remove()
        var model = HUD.modelDefault
        model._axis = .horizontal
        if title.count > 30 || detail.count > 30 {
            model._axis = .vertical
        }
        model._textAlignment = .left
        model._isSquare = false
        self.cd.hud(.error, title: title, detail: detail, model:model)
    }
    func hud_info(_ title:String) {
        self.cd.hud_remove()
        var model = HUD.modelDefault
        model._axis = .horizontal
        if title.count > 30 {
            model._axis = .vertical
        }
        model._textAlignment = .left
        model._isSquare = false
        self.cd.hud(.info, title: title, model:model)
    }
    func hud_warning(_ title:String) {
        self.cd.hud_remove()
        var model = HUD.modelDefault
        model._axis = .horizontal
        if title.count > 30 {
            model._axis = .vertical
        }
        model._textAlignment = .left
        model._isSquare = false
        self.cd.hud(.warning, title: title, model:model)
    }
}

