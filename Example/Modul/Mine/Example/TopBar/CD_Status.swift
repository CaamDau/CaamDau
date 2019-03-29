//Created  on 2019/3/27 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 *
 */




import UIKit
import CD

@IBDesignable
open class CD_Status: UIView {
    public lazy var lab_1:UILabel = {
        return UILabel().cd
            .text("123")
            .text(UIColor.black)
            //.text(CD_TopBar.Model.font_prompt)
            .text(NSTextAlignment.center)
            .adjusts(true)
            .clips(true)
            .build
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        makeUI()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        makeUI()
    }
    
}

extension CD_Status {
    func makeUI() {
        self.backgroundColor = UIColor.red
        self.addSubview(lab_1)
        lab_1.translatesAutoresizingMaskIntoConstraints = false
        let l = NSLayoutConstraint(item: lab_1, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 0)
        let r = NSLayoutConstraint(item: lab_1, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: 0)
        let b = NSLayoutConstraint(item: lab_1, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0)
        let h = NSLayoutConstraint(item: lab_1, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 20)
        self.addConstraints([l,r,b,h])
    }
}
