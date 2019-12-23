//Created  on 2019/12/22 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 *
 */




import UIKit

open class CD_EmptyView: UIView {

    open lazy var stackView: UIStackView = {
        return UIStackView().cd.build
    }()
    
    open lazy var btn_icon: UIButton = {
        return UIButton().cd.build
    }()
    
    open lazy var lab_title: UILabel = {
        return UILabel().cd.build
    }()
    
    open lazy var lab_decs: UILabel = {
        return UILabel().cd.build
    }()
    
    open lazy var btn_tap: UIButton = {
        return UIButton().cd.build
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
