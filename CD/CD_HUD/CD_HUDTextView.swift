//Created  on 2019/5/14 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 * text 容器
 */




import UIKit

class CD_HUDTextView: UIStackView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        makeDefault()
    }
    required init(coder: NSCoder) {
        super.init(coder: coder)
        makeDefault()
    }
    convenience init() {
        self.init(frame: CGRect.zero)
        
    }
    lazy var lab_title: UILabel = {
        return UILabel().cd
            //.background(UIColor.red)
            .text(UIColor.white)
            .build
    }()
    lazy var lab_detail: UILabel = {
        return UILabel().cd
            //.background(UIColor.red)
            .text(UIColor.white)
            .build
    }()
    var title:String = ""
    var detail:String = ""
    var model:CD_HUD.Model = CD_HUD.modelDefault
}

extension CD_HUDTextView {
    func makeDefault() {
        self.cd.axis(.vertical)
    }
    func show(title:String = "", detail:String = "", model:CD_HUD.Model = CD_HUD.modelDefault){
        self.title = title
        self.detail = detail
        self.model = model
        self.cd.spacing(model._space)
        if !self.title.isEmpty {
            self.cd.addArranged(subview: self.lab_title)
            self.lab_title.cd
                .number(model._linesTitle)
                .text(model._textAlignment)
                .text(model._fontTitle)
                .text(title)
        }
        if !self.detail.isEmpty {
            self.cd.addArranged(subview: self.lab_detail)
            self.lab_detail.cd
                .number(model._linesDetail)
                .text(model._textAlignment)
                .text(model._fontDetail)
                .text(detail)
        }
    }
}


