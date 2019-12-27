//Created  on 2019/10/9 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 *
 */




import UIKit
import CaamDau


extension CD_DatePickerAlert {
    public class func show(_ style:CD_DatePicker.Style = .yyyyMMdd, date:Date = Date(), preferredStyle:CD_DatePickerAlert.Style = .sheet, callback:((Date)->Void)? = nil, then:((CD_DatePickerAlert)->Void)? = nil) {
        let vc = CD_DatePickerAlert()
        vc.style = style
        vc.preferredStyle = preferredStyle
        vc.date = date
        vc.callback = callback
        then?(vc)
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .custom
        CD.present(vc)
    }
}

public class CD_DatePickerAlert: UIViewController {
    public enum Style {
        case alert
        case sheet
    }
    var preferredStyle:Style = .sheet
    var callback:((Date)->Void)?
    var style:CD_DatePicker.Style = .yyyyMMdd
    var date:Date = Date()
    public var minDate: Date?
    public var maxDate: Date?
    public var colorLine:UIColor = UIColor.cd_hex("c")
    public var colorCancel:UIColor = .darkText
    public var colorDone:UIColor = .darkText
    public var font:UIFont = .systemFont(ofSize: 16)
    public var action:(String, String) = ("取消", "确定")
    lazy var view_bg:UIView = {
        return UIView()
    }()
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        switch preferredStyle {
        case .alert:
            makeAlertUI()
        case .sheet:
            makeSheetUI()
        }
    }
    
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addAnimation(false)
    }
    
    func addAnimation(_ remove:Bool){
        guard preferredStyle == .sheet else { return }
        view_bg.superview?.layoutIfNeeded()
        let value0 = view_bg.layer.position.y + CD.screenW
        let value1 = view_bg.layer.position.y
        let animote = CABasicAnimation(keyPath: "position.y")
        animote.duration = 0.25
        animote.isRemovedOnCompletion = false
        animote.fillMode = .forwards
        animote.fromValue = remove ? value1 : value0
        animote.toValue = remove ? value0 : value1
        animote.timingFunction = CAMediaTimingFunction(name: .easeOut)
        view_bg.layer.add(animote, forKey: animote.keyPath)
    }
    
    func makeAlertUI() {
        view_bg.cd
            .corner(12, clips: true)
            .background(.cd_hex("f", dark: "0"))
            .add(toSuperview: self.view)
            .then({
                $0.translatesAutoresizingMaskIntoConstraints = false
                $0.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
                $0.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
                $0.heightAnchor.constraint(equalToConstant: 280*0.618).isActive = true
                $0.widthAnchor.constraint(equalToConstant: 280).isActive = true
            })
        self.view.layoutIfNeeded()
        
        
        let stack = UIStackView(frame: view_bg.bounds).cd
            .axis(.vertical)
            .add(toSuperview: view_bg)
            .then{ _ in
                
            }
            .build
        
        let picker = CD_DatePicker().cd
            .add(toSuperstack: stack)
            .build
        picker.callback = { [weak self]date in
            self?.date = date
        }
        picker.style = style
        picker.minDate = minDate
        picker.maxDate = maxDate
        picker.date = date
        UIView().cd
            .background(colorLine)
            .add(toSuperstack: stack)
            .then {
                $0.translatesAutoresizingMaskIntoConstraints = false
                $0.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        }
            
        UIStackView().cd
            .axis(.horizontal)
            .distribution(.fill)
            .add(toSuperstack: stack)
            .then {
                $0.translatesAutoresizingMaskIntoConstraints = false
                $0.heightAnchor.constraint(equalToConstant: 45).isActive = true
                
                let btn1 = UIButton().cd
                    .tag(1)
                    .text(font)
                    .text(colorCancel)
                    .text(action.0)
                    .add(toSuperstack: $0)
                    .build
                
                btn1.addTarget(self, action: #selector(CD_DatePickerAlert.buttonClick(_:)), for: UIControl.Event.touchUpInside)
                
                UIView().cd
                    .background(colorLine)
                    .add(toSuperstack: $0)
                    .then {
                        $0.translatesAutoresizingMaskIntoConstraints = false
                        $0.widthAnchor.constraint(equalToConstant: 0.5).isActive = true
                }
                
                let btn2 = UIButton().cd
                    .tag(2)
                    .text(font)
                    .text(colorDone)
                    .text(action.1)
                    .add(toSuperstack: $0)
                    .then {
                        $0.translatesAutoresizingMaskIntoConstraints = false
                        $0.widthAnchor.constraint(equalTo: btn1.widthAnchor, multiplier: 1).isActive = true
                }
                .build
                
                btn2.addTarget(self, action: #selector(CD_DatePickerAlert.buttonClick(_:)), for: UIControl.Event.touchUpInside)
        }
    }
    
    func makeSheetUI() {
        view_bg.cd
            .clips(true)
            .background(.cd_hex("f", dark: "0"))
            .add(toSuperview: self.view)
            .then({
                $0.translatesAutoresizingMaskIntoConstraints = false
                $0.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
                $0.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
                $0.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
                $0.heightAnchor.constraint(equalToConstant: CD.screenW).isActive = true
            })
            
        self.view.layoutIfNeeded()
        
        
        let stack = UIStackView(frame: view_bg.bounds).cd
            .axis(.vertical)
            .add(toSuperview: view_bg)
            .then{ _ in
                
            }
            .build
        
        UIStackView().cd
            .axis(.horizontal)
            .distribution(.fill)
            .add(toSuperstack: stack)
            .then {
                $0.translatesAutoresizingMaskIntoConstraints = false
                $0.heightAnchor.constraint(equalToConstant: 45).isActive = true
                
                UIStackView().cd
                    .axis(.horizontal)
                    .add(toSuperstack: $0)
                    .then {
                        $0.translatesAutoresizingMaskIntoConstraints = false
                        $0.widthAnchor.constraint(equalToConstant: 15).isActive = true
                }
                
                let btn1 = UIButton().cd
                    .tag(1)
                    .text(font)
                    .text(colorCancel)
                    .text(action.0)
                    .add(toSuperstack: $0)
                    .build
                
                btn1.addTarget(self, action: #selector(CD_DatePickerAlert.buttonClick(_:)), for: .touchUpInside)
                
                UIStackView().cd.axis(.horizontal).add(toSuperstack: $0)
                
                
                let btn2 = UIButton().cd
                    .tag(2)
                    .text(font)
                    .text(colorDone)
                    .text(action.1)
                    .add(toSuperstack: $0)
                    .build
                btn2.addTarget(self, action: #selector(CD_DatePickerAlert.buttonClick(_:)), for: .touchUpInside)
                
                UIStackView().cd
                    .axis(.horizontal)
                    .add(toSuperstack: $0)
                    .then {
                        $0.translatesAutoresizingMaskIntoConstraints = false
                        $0.widthAnchor.constraint(equalToConstant: 15).isActive = true
                }
                
        }
        
        UIView().cd
            .background(colorLine)
            .add(toSuperstack: stack)
            .then {
                $0.translatesAutoresizingMaskIntoConstraints = false
                $0.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        }
        
        let picker = CD_DatePicker().cd
            .add(toSuperstack: stack)
            .build
        picker.callback = { [weak self]date in
            self?.date = date
        }
        picker.style = style
        picker.minDate = minDate
        picker.maxDate = maxDate
        picker.date = date
        
        
        if #available(iOS 11.0, *) {
            guard let b = CD.window?.safeAreaInsets.bottom, b > 0 else { return }
            UIStackView().cd
                .axis(.horizontal)
                .add(toSuperstack: stack)
                .then {
                    $0.translatesAutoresizingMaskIntoConstraints = false
                    $0.heightAnchor.constraint(equalToConstant: b).isActive = true
            }
        } else {
            
        }
    }
    
    @objc func buttonClick(_ sender:UIButton) {
        switch sender.tag {
        case 2:
            callback?(date)
        default:
            addAnimation(true)
        }
        self.dismiss(animated: true, completion: nil)
    }
}
