//Created  on 2019/12/22 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 *
 */




import UIKit

extension CD_EmptyView {
    public enum Item {
        case activity(_ callback:((UIActivityIndicatorView)->Void)?)
        case lable(_ callback:((UILabel)->Void)?, _ action:(()->Void)?)
        case button(_ callback:((UIButton)->Void)?, _ action:(()->Void)?)
        case image(_ callback:((UIImageView)->Void)?, _ action:(()->Void)?)
    }
    
    public struct Config {
        public var activityCallback:((UIActivityIndicatorView)->Void)?
        public var labelCallback:((UILabel)->Void)?
        public var buttonCallback:((UIButton)->Void)?
        public var imageCallback:((UIImageView)->Void)?
        
        init() {
            labelCallback = {
                $0.cd.text(UIColor.cd_hex("3"))
                    .text(UIFont.systemFont(ofSize: 14))
            }
            buttonCallback = {
                $0.cd.text(UIColor.cd_hex("3"))
                    .text(UIFont.systemFont(ofSize: 14))
            }
            activityCallback = {
                $0.style = .gray
            }
            
        }
    }
}

open class CD_EmptyView: UIView {
    public static var config:Config = Config()
    open var items:[Item] = [.image(nil, nil), .lable(nil, nil), .button(nil, nil)] {
        didSet{
            makeUI()
        }
    }
    
    open lazy var stackView: UIStackView = {
        return UIStackView().cd
            .alignment(.center)
            .spacing(10)
            .axis(.vertical)
            .build
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
        makeStackView()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        makeStackView()
        
        makeUI()
    }
    
    var actions:[(()->Void)?] = []
}

extension CD_EmptyView {
    func makeStackView() {
        self.cd.add(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        stackView.leadingAnchor.constraint(greaterThanOrEqualTo: self.leadingAnchor, constant: 20).isActive = true
        //stackView.topAnchor.constraint(greaterThanOrEqualTo: self.topAnchor, constant: 20).isActive = true
    }
    
    
    func makeUI() {
        stackView.arrangedSubviews.forEach{
            $0.removeFromSuperview()
        }
        for (i, item) in items.enumerated() {
            switch item {
            case let .lable(callback, action):
                let v = UILabel().cd
                    .isUser(true)
                    .tag(i)
                    .add(toSuperstack: stackView)
                    .build
                CD_EmptyView.config.labelCallback?(v)
                let tap = UITapGestureRecognizer(target: self, action: #selector(tapClick(_:)))
                v.addGestureRecognizer(tap)
                actions.append(action)
                callback?(v)
            case let .button(callback, action):
                let v = UIButton().cd
                    .tag(i)
                    .add(toSuperstack: stackView)
                    .action(self, action: #selector(tapClick(_:)), event: .touchUpInside)
                    .build
                CD_EmptyView.config.buttonCallback?(v)
                actions.append(action)
                callback?(v)
            case let .image(callback, action):
                let v = UIImageView().cd
                    .isUser(true)
                    .tag(i)
                    .add(toSuperstack: stackView)
                    .build
                CD_EmptyView.config.imageCallback?(v)
                let tap = UITapGestureRecognizer(target: self, action: #selector(tapClick(_:)))
                v.addGestureRecognizer(tap)
                actions.append(action)
                callback?(v)
            case .activity(let callback):
                let v = UIActivityIndicatorView().cd
                    .add(toSuperstack: stackView)
                    .build
                v.startAnimating()
                CD_EmptyView.config.activityCallback?(v)
                callback?(v)
            }
        }
    }
    
    @objc func tapClick(_ sender:Any) {
        if let v = sender as? UIView {
            actions[v.tag]?()
        }else if let t = sender as? UITapGestureRecognizer, let v = t.view  {
            actions[v.tag]?()
        }
    }
}
