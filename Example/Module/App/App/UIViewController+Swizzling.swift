//Created  on 2019/9/17 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 *
 */


import Foundation
import UIKit

infix operator <=>
private extension Selector {
    static func <=> (left: Selector, right: Selector) {
        if let originalMethod = class_getInstanceMethod(UIViewController.self, left),
            let swizzledMethod = class_getInstanceMethod(UIViewController.self, right) {
            method_exchangeImplementations(originalMethod, swizzledMethod)
        }
    }
}
extension UIViewController {
    @objc public static func cd_methodSwizzling() {
        methodSwizzling
    }
}

extension UIViewController {
    static let methodSwizzling: Void = {
        #selector(viewDidLoad) <=> #selector(swizzling_viewDidLoad)
        #selector(viewDidAppear(_:)) <=> #selector(swizzling_viewDidAppear(_:))
    }()
    
    @objc var swizzling_modalPresentationStyle: UIModalPresentationStyle {
        return .fullScreen
    }
    
    @objc private func swizzling_viewDidLoad() {
        swizzling_viewDidLoad()
        
        /// ios11 以下 需要
        //self.automaticallyAdjustsScrollViewInsets = false
        
        /// CD_ Form基类控制器没有设置背景色，
        /// 导致表单下行约束在安全区的小段Home键位置是黑色的
        guard self.isKind(of: CD_TableViewController.self)
            || self.isKind(of: CD_CollectionViewController.self)  else {
            return
        }
        self.view.backgroundColor = Config.color.bg
    }
    
    @objc private func swizzling_viewDidAppear(_ animated:Bool) {
        swizzling_viewDidAppear(animated)
        
        debugPrint("☢️☢️☢️ 当前VC：", self.title, CD.visibleVC?.title)
    }
    
}
