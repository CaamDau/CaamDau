//Created  on 2019/4/17 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 *
 */




import UIKit
import CD


public extension UIView {
    func hud_loading() {
        self.cd.hud_remove()
        self.cd.hud(.loading(.activity))
    }
    func hud_hidden() {
        self.cd.hud_remove()
    }
    func hud_msg(_ title:String) {
        self.cd.hud_remove()
        var model = CD_HUD.modelDefault
        model._position = .bottom
        model._showAnimation = .slide
        self.cd.hud(.text, title: title, model:model)
    }
    
    func hud_succeed(_ title:String) {
        self.cd.hud_remove()
        var model = CD_HUD.modelDefault
        model._axis = .horizontal
        model._isSquare = false
        self.cd.hud(.succeed, title: title, model:model)
    }
    
    func hud_error(_ title:String) {
        self.cd.hud_remove()
        var model = CD_HUD.modelDefault
        model._axis = .horizontal
        model._isSquare = false
        self.cd.hud(.error, title: title, model:model)
    }
    func hud_info(_ title:String) {
        self.cd.hud_remove()
        var model = CD_HUD.modelDefault
        model._axis = .horizontal
        model._isSquare = false
        self.cd.hud(.info, title: title, model:model)
    }
    func hud_warning(_ title:String) {
        self.cd.hud_remove()
        var model = CD_HUD.modelDefault
        model._axis = .horizontal
        model._isSquare = false
        self.cd.hud(.warning, title: title, model:model)
    }
}

