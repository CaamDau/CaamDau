//Created  on 2019/10/9 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 *
 */




import UIKit
import CaamDau


extension CD_DatePickerAlert {
    public class func show(_ style:CD_DatePicker.Style = .yyyyMMdd, date:Date = Date(), callback:((Date)->Void)? = nil, then:((CD_DatePickerAlert)->Void)? = nil) {
        let vc = CD_DatePickerAlert()
        vc.style = style
        vc.date = date
        vc.callback = callback
        then?(vc)
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .custom
        CD.present(vc)
    }
}

public class CD_DatePickerAlert: UIViewController {
    
    var callback:((Date)->Void)?
    var style:CD_DatePicker.Style = .yyyyMMdd
    var date:Date = Date()
    
    public var colorLine:UIColor = UIColor.cd_hex("c")
    public var colorCancel:UIColor = .darkText
    public var colorDone:UIColor = .darkText
    public var font:UIFont = .systemFont(ofSize: 16)
    public var action:(String, String) = ("取消", "确定")
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        makeUI()
    }
    
    func makeUI() {
        let bg = UIView().cd
            .corner(12, clips: true)
            .background(.white)
            .add(toSuperview: self.view)
            .then({
                $0.translatesAutoresizingMaskIntoConstraints = false
                $0.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
                $0.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
                $0.heightAnchor.constraint(equalToConstant: 280*0.618).isActive = true
                $0.widthAnchor.constraint(equalToConstant: 280).isActive = true
            })
            .build
        self.view.layoutIfNeeded()
        
        
        let stack = UIStackView(frame: bg.bounds).cd
            .axis(.vertical)
            .add(toSuperview: bg)
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
    
    @objc func buttonClick(_ sender:UIButton) {
        switch sender.tag {
        case 2:
            callback?(date)
        default:
            break
        }
        self.dismiss(animated: true, completion: nil)
    }
}
