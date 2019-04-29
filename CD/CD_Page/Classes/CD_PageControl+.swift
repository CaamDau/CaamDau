//Created  on 2019/4/16 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 *
 */




import Foundation
import UIKit
import CD


public class CD_PageControlTitle: UICollectionViewCell{
    static let id:String = "CD_PageControlTitle"
    
    public struct Model {
        public var titleNormal:String = ""
        public var titleSelected:String = ""
        
        public var titleColorNormal:UIColor = UIColor.black
        public var titleColorSelected:UIColor = UIColor.red
        
        public var imgNormal:UIImage = UIImage()
        public var imgSelected:UIImage = UIImage()
        
        public var imgBgNormal:UIImage = UIImage()
        public var imgBgSelected:UIImage = UIImage()
        
        public init() {}
    }
    
    lazy var btn: UIButton = {
        return UIButton().cd.isUser(false).build
    }()
    
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        makeUI()
        self.backgroundColor = UIColor.red
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //fatalError("init(coder:) has not been implemented")
    }
    
    func update(_ data: CD_PageControlTitle.Model, id: String, tag: Int, frame: CGRect, callBack: CD_RowCallBack?) {
        btn.cd
            .text(data.titleNormal, .normal)
            .text(data.titleSelected, .selected)
            .text(data.titleSelected, .highlighted)
            .text(data.titleColorNormal, .normal)
            .text(data.titleColorSelected, .selected)
            .text(data.titleColorSelected, .highlighted)
            .background(data.imgBgNormal, for: .normal)
            .background(data.imgSelected, for: .selected)
            .background(data.imgSelected, for: .highlighted)
            .image(data.imgNormal, for: .normal)
            .image(data.imgSelected, for: .highlighted)
            .image(data.imgSelected, for: .selected)
        
    }
    
    func makeUI() {
        self.cd.background(UIColor.clear)
        self.contentView.cd
            .background(UIColor.clear)
            .add(btn)
            .then { [weak self] in
                self?.btn.snp.makeConstraints({ (make) in
                    make.edges.equalToSuperview()
                })
        }
    }
}

extension CD_PageControlTitle:CD_RowUpdateProtocol{
    public typealias DataSource = CD_PageControlTitle.Model
    public func row_update(_ data: CD_PageControlTitle.Model, id: String, tag: Int, frame: CGRect, callBack: CD_RowCallBack?) {
        self.update(data, id: id, tag: tag, frame: frame, callBack: callBack)
    }
}
