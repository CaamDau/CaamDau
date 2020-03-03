//Created  on 2019/12/4 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 *
 */




import UIKit
import CaamDau
import Utility

class Cell_FileList: UITableViewCell {
    
    @IBOutlet weak var btn_icon: UIButton!
    @IBOutlet weak var lab_name: UILabel!
    @IBOutlet weak var btn_select: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        lab_name.cd
        .text(Config.font.font(14))
        .text(Config.color.txt_1)
        btn_icon.cd
            .background(AssetsFile().fileicon)
            .corner(2, clips: true)
    }

    var callBack: CD_RowCallBack?
    @IBAction func buttonClick(_ sender: Any) {
        callBack?("")
    }
}

extension Cell_FileList: CD_RowCellUpdateProtocol {
    typealias ConfigModel = Bool
    
    typealias DataSource = FileList.Model
    
    func row_update(config data: Bool) {
         btn_select.cd.isHidden(data)
    }
    func row_update(callBack block: CD_RowCallBack?) {
        callBack = block
    }
    func row_update(dataSource data: FileList.Model) {
        btn_icon.cd
            .background(data.color)
            .text(data.suffix)
        lab_name.cd.text(data.name)
        let icon = data.select ? CD_IconFont.tsquare_check(20) : CD_IconFont.tsquare(20)
        btn_select.cd
            .text(data.select ? Config.color.main_1 : Config.color.txt_5)
            .text(icon.font)
            .text(icon.text)
    }
}
