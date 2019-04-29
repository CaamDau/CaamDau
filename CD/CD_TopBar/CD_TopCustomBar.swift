//Created  on 2019/3/25 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 *
 */




import UIKit
import SnapKit

//@IBDesignable
open class CD_TopCustomBar: UIView {
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.backgroundColor = UIColor.clear
    }
    
    convenience public init(){
        self.init(frame: CGRect.zero)
    }
}
