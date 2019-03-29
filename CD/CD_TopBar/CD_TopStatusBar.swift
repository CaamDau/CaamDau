//Created  on 2019/3/25 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 *
 */




import UIKit
import SnapKit

@IBDesignable
open class CD_TopStatusBar: UIView {
    public lazy var img_bg:UIImageView = {
        return UIImageView().cd.clips(true).build
    }()
    public lazy var lab_1:UILabel = {
        let lab = UILabel().cd
            .text("")
            .text(UIColor.black)
            .text(CD_TopBar.Model.font_prompt)
            .text(NSTextAlignment.center)
            .adjusts(true)
            .clips(true)
            .build
        return lab
    }()
    @IBInspectable open var _title:String? = "" {
        didSet{
            self.lab_1.cd.text(_title ?? "")
        }
    }
    @IBInspectable open var _bgImg:String = "" {
        didSet{
            img_bg.image = UIImage(named: _bgImg) ?? UIImage()
        }
    }
    @IBInspectable open var _colorBg:UIColor = UIColor.clear {
        didSet{
            self.backgroundColor = _colorBg
        }
    }
    override public init(frame: CGRect) {
        super.init(frame: frame)
        makeUI()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        makeUI()
    }
    convenience public init(){
        self.init(frame: CGRect.zero)
    }
    
    func makeUI() {
        self.backgroundColor = UIColor.red
        self.cd.add(img_bg).add(lab_1)
        makeSnap()
    }
    func makeSnap(){
        img_bg.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        lab_1.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(8)
            make.centerX.equalToSuperview()
            make.height.equalTo(CD_TopBar.Model.height_prompt)
        }
    }
}

/*
extension CD_TopStatusBar {
    func makeLayout() {
        do{
            lab_1.translatesAutoresizingMaskIntoConstraints = false
            let l = NSLayoutConstraint(item: lab_1, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 0)
            let r = NSLayoutConstraint(item: lab_1, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: 0)
            let b = NSLayoutConstraint(item: lab_1, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0)
            let h = NSLayoutConstraint(item: lab_1, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 20)
            self.addConstraints([l,r,b,h])
        }
    }
}*/
