//Created  on 2019/10/9 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 *
 */




import UIKit
import CaamDau
import SnapKit

class CD_DatePickerAlert: UIViewController {
    
    class func show() {
        let vc = CD_DatePickerAlert()
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .custom
        CD.present(vc)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        makeUI()
    }
    var completionHandler:((Date)->Void)?
    var colorLine:UIColor = .lightGray
    
    
    var date:Date = Date()
    
    
    func makeUI() {
        let bg = UIView().cd
            .corner(12, clips: true)
            .background(.white)
            .add(toSuperview: self.view)
            .then({
                $0.snp.makeConstraints {
                    $0.center.equalToSuperview()
                    $0.left.equalToSuperview().offset(30)
                }
            })
            .build
        self.view.layoutIfNeeded()
        
        
        let stack = UIStackView().cd
            .axis(.vertical)
            .add(toSuperview: bg)
            .then{
                $0.snp.makeConstraints {
                    $0.edges.equalToSuperview()
                }
            }
            .build
        
        let picker = CD_DatePicker(frame: CGRect(w:bg.bounds.size.width, h:150)).cd
            .add(toSuperstack: stack)
            .build
        picker.style = .yyyyMMdd
        picker.completionHandler = { [weak self]date in
            self?.date = date
        }
        
        UIView().cd
            .background(colorLine)
            .add(toSuperstack: stack)
            .then {
                $0.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
                
        }
            
        
        UIStackView().cd
            .axis(.horizontal)
            .distribution(.fill)
            .add(toSuperstack: stack)
            .then {
                $0.heightAnchor.constraint(equalToConstant: 45).isActive = true
                
                
                let btn1 = UIButton().cd
                    .tag(1)
                    .text(UIColor.darkText)
                    .text("取消")
                    .add(toSuperstack: $0)
                    .build
                
                btn1.addTarget(self, action: #selector(CD_DatePickerAlert.buttonClick(_:)), for: UIControl.Event.touchUpInside)
                
                UIView().cd
                    .background(colorLine)
                    .add(toSuperstack: $0)
                    .then {
                        $0.widthAnchor.constraint(equalToConstant: 0.5).isActive = true
                }
                
                let btn2 = UIButton().cd
                    .tag(2)
                    .text(UIColor.darkText)
                    .text("确定")
                    .add(toSuperstack: $0)
                    .then {
                        $0.widthAnchor.constraint(equalTo: btn1.widthAnchor, multiplier: 1).isActive = true
                }
                .build
                
                btn2.addTarget(self, action: #selector(CD_DatePickerAlert.buttonClick(_:)), for: UIControl.Event.touchUpInside)
        }
        
        self.view.layoutIfNeeded()
            
    }
    
    @objc func buttonClick(_ sender:UIButton) {
        switch sender.tag {
        case 2:
            completionHandler?(date)
        default:
            break
        }
        self.dismiss(animated: true, completion: nil)
    }
}
