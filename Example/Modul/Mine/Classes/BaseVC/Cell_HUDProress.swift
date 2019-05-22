//Created  on 2019/5/21 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 *
 */




import UIKit
import CD
class Cell_HUDProress: UITableViewCell {
    @IBOutlet weak var lab_num: UILabel!
    @IBOutlet weak var step0: UIStepper!
    @IBOutlet weak var step1: UIStepper!
    @IBOutlet weak var view_bg: UIView!
    
    lazy var proress1: CD_HUDProgressView = {
        return CD_HUDProgressView(frame: CGRect(w: 80, h: 80))
    }()
    
    lazy var proress2: CD_HUDProgressView = {
        return CD_HUDProgressView()
    }()
    
    lazy var proress3: CD_HUDProgressView = {
        return CD_HUDProgressView(frame: CGRect(x:180, w: 80, h: 80))
    }()
    
    lazy var proress4: CD_HUDProgressView = {
        return CD_HUDProgressView()
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.view_bg.cd
            .add(proress1)
            .add(proress2)
            .add(proress3)
            .add(proress4)
        
        proress1.progress = 10
        proress2.progress = 20
        proress3.progress = 30
        proress4.progress = 40
        proressCycle3()
        proressCycle4()
        
        
        proress2.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalTo(proress1.snp.right).offset(10)
            make.width.height.equalTo(80)
        }
        
        proress4.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalTo(proress3.snp.right).offset(10)
            make.width.height.equalTo(80)
        }
        lab_num.text = "\(step0.value)"
        
        
    }
    func proressCycle3() {
        guard proress2.progress < 100 else {return}
        CD_CountDown.after(2) {[weak self] in
            self?.proress3.progress += 10
            self?.proressCycle3()
        }
    }
    func proressCycle4() {
        guard proress4.progress < 100 else {return}
        CD_CountDown.after(2) {[weak self] in
            self?.proress4.progress += 15
            self?.proressCycle4()
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func stepClick(_ sender: UIStepper) {
        if sender == step0 {
            step1.value = sender.value
        }else{
            step0.value = sender.value
        }
        lab_num.text = "\(sender.value)"
        proress1.progress = CGFloat(sender.value)
        proress2.progress = CGFloat(sender.value)
    }
    
}

extension Cell_HUDProress: CD_RowUpdateProtocol {
    typealias DataSource = Any
    func row_update(_ data: Any, id: String, tag: Int, frame: CGRect, callBack: CD_RowCallBack?) {
        
    }
}
