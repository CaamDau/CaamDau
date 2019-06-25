//Created  on 2019/2/17 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 *
 */




import Foundation
import UIKit

public extension CD where Base: UIColor {
    @discardableResult
    func alpha(_ a:CGFloat) -> CD {
        base.withAlphaComponent(a)
        return self
    }
}
