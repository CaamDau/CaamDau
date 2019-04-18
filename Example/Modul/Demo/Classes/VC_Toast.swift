//Created  on 2019/4/17 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 *
 */




import UIKit
import CD
import Toast_Swift

class VC_Toast: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ToastManager.shared.isQueueEnabled = true
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
        case 0:
            cd_window()?.hud_loading()
            CD_CountDown.after(3) {
                cd_window()?.hud_loadingHidden()
            }
        case 1:
            cd_window()?.hud_msg("哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈")
        default:
            break
        }
    }
}


public extension UIView {
    
    private var hud_toastStyle:ToastStyle {
        get{
            var style = ToastStyle()
            style.backgroundColor = UIColor.black.withAlphaComponent(0.8)
            style.activitySize = CGSize(width: 80.0, height: 80.0)
            return style
        }
    }
    
    func hud_loading() {
        self.makeToastActivity(.center)
    }
    func hud_loadingHidden() {
        self.hideToastActivity()
    }
    
    
    func hud_msg(_ s:String) {
        self.makeToast(s, style:hud_toastStyle)
    }
    func hud_hidden() {
        self.hideAllToasts()
    }
}
