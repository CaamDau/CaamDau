//Created  on 2019/1/11  by LCD :https://github.com/liucaide .

import UIKit
import CD
import Assets


class Cell_MainNews: UITableViewCell {
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lab: UILabel!
    @IBOutlet weak var button: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
extension Cell_MainNews:CD_RowUpdateProtocol{
    typealias DataSource = M_MainNews
    func row_update(_ data: M_MainNews, id: String, tag: Int, frame: CGRect, callBack: CD_RowCallBack?) {
        lab.text = data.name
        /*
        time_consuming("耗时->\(tag)：") { [weak self] in
            self?.img.image = AssetsShare.share.logo_60
            switch tag%3 {
            case 0:
                self?.img.image = Assets.logo_200
            case 1:
                self?.img.image = AssetsImg.logo_0.light
            case 2:
                self?.img.image = AssetsShare.share.logo_60
            default:
                self?.img.image = Assets.logo_200
            }
            
        }*/
        
    }
    
}


//MARK:---  ----------
class Cell_MainTitle: UITableViewCell {
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
extension Cell_MainTitle:CD_RowUpdateProtocol{
    typealias DataSource = String
    func update(_ data: String, id: String, tag: Int, frame: CGRect) {
        self.textLabel?.text = data
    }
}
//MARK:--- 开关 ----------
class Cell_MainSwitch: UITableViewCell {
    @IBOutlet weak var `switch`: UISwitch!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}


extension Cell_MainSwitch:CD_RowUpdateProtocol{
    typealias DataSource = (String,Bool)
    func update(_ data: (String,Bool), id: String, tag: Int, frame: CGRect) {
        self.textLabel?.text = data.0
        self.switch.isOn = data.1
    }
}
