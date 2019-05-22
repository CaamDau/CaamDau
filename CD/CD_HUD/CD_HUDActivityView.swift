//Created  on 2019/5/14 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 * Loading 活动容器
 */


import UIKit

class CD_HUDActivityView: UIStackView {
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
    
    lazy var gifView: UIImageView = {
        return UIImageView().cd.build
    }()
    lazy var label: UILabel = {
        return UILabel().cd.text(NSTextAlignment.center).build
    }()
    lazy var activityView:UIActivityIndicatorView  = {
        let v = UIActivityIndicatorView().cd
            .build
        v.style = .whiteLarge
        v.startAnimating()
        return v
    }()
    lazy var view: UIView = {
        return UIView().cd.build
    }()
    
    lazy var view_proress: CD_HUDProgressView = {
        return CD_HUDProgressView().cd.build
    }()

    var title:String = ""
    var detail:String = ""
    var model:CD_HUD.Model = CD_HUD.modelDefault
}
//MARK:--- Activity ----------
extension CD_HUDActivityView {
    func makeDefault() {
        self.cd.axis(.vertical)
    }
    func show(_ style:CD_HUD.Style = .loading(nil), model:CD_HUD.Model) {
        self.model = model
        switch style {
        case .loading(let l):
            loading(l)
        case .info:
            self.cd.addArranged(subview: label)
            label.cd
                .text(model._colorActivity)
                .text(CD_IconFont.tinfo(iconFontSize).text)
                .text(CD_IconFont.tinfo(iconFontSize).font)
        case .succeed:
            self.cd.addArranged(subview: label)
            label.cd
                .text(model._colorActivity)
                .text(CD_IconFont.tcheck(iconFontSize).text)
                .text(CD_IconFont.tcheck(iconFontSize).font)
        case .warning:
            self.cd.addArranged(subview: label)
            label.cd
                .text(model._colorActivity)
                .text(CD_IconFont.twarn(iconFontSize).text)
                .text(CD_IconFont.twarn(iconFontSize).font)
        case .error:
            self.cd.addArranged(subview: label)
            label.cd
                .text(model._colorActivity)
                .text(CD_IconFont.tclose(iconFontSize).text)
                .text(CD_IconFont.tclose(iconFontSize).font)
        case .text:
            break
        case .progress(let pro):
            switch pro {
            case .default(let model, let handler):
                view_proress.heightAnchor.constraint(equalToConstant: 60).isActive = true
                view_proress.widthAnchor.constraint(equalToConstant: 60).isActive = true
                self.cd.addArranged(subview: view_proress)
                view_proress.model = model
                view_proress.handler = handler
            case .view(let v):
                self.cd.addArranged(subview: v)
            }
        case .custom(_):
            break
        }
    }
    
    var iconFontSize:CGFloat {
        return model._axis == .vertical ? 40 : model._fontTitle.pointSize*1.6
    }
    
    func loading(_ style:CD_HUD.Style.Loading?)  {
        let style = style ?? .activity
        switch style {
        case .activity:
            self.cd.addArranged(subview: activityView)
            activityView.style = model._axis == .horizontal ? .white : .whiteLarge
            activityView.color = model._colorActivity
        case .images(let imags, let time, let count):
            self.cd.addArranged(subview: gifView)
            gifView.image = imags.last
            guard imags.count > 0 else{return}
            gifView.animationImages = imags
            gifView.animationDuration = time
            gifView.animationRepeatCount = count
            gifView.startAnimating()
        case .ring:
            self.cd.addArranged(subview: label)
            label.cd
                .text(model._colorActivity)
                .text(CD_IconFont.tloading(iconFontSize).text)
                .text(CD_IconFont.tloading(iconFontSize).font)
            makeRotationAnimotion(label)
        case .arrow:
            self.cd.addArranged(subview: label)
            label.cd
                .text(model._colorActivity)
                .text(CD_IconFont.trefresh(iconFontSize).text)
                .text(CD_IconFont.trefresh(iconFontSize).font)
            makeRotationAnimotion(label)
        case .view(let vv):
            self.cd.addArranged(subview: vv)
        }
    }
}


extension CD_HUDActivityView {
    func makeRotationAnimotion(_ view:UIView) {
        let animote = CABasicAnimation(keyPath: "transform.rotation.z")
        animote.duration = 1
        animote.isRemovedOnCompletion = false
        animote.fillMode = .forwards
        animote.fromValue = 0
        animote.toValue = CGFloat.pi*2
        animote.repeatCount = HUGE
        view.layer.add(animote, forKey: animote.keyPath)
    }
}

