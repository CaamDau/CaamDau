//Created  on 2019/7/2 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 *
 */




import Foundation
import IQKeyboardManagerSwift
import CaamDau

public class App_Config: CD_AppDelegate {
    public func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        makeTopBar()
        makeIQKeyboard()
        makeRefresh()
        return true
    }
    
    func makeTopBar() {
        CD_TopBar.Model.color_bg = Config.color.hex("f", dark: "0f")
        CD_TopBar.Model.color_line = Config.color.line_1
        CD_TopBar.Model.color_title = Config.color.txt_1
        CD_TopBar.Model.color_subTitle = Config.color.txt_1
        CD_TopBar.Model.color_prompt = Config.color.txt_1
        CD_TopBar.Model.color_normal = Config.color.txt_1
        CD_TopBar.Model.color_selected = Config.color.txt_3
        CD_TopBar.Model.color_highlighted = Config.color.txt_3
        let icon = CD_IconFont.tback_light(22)
        CD_TopBar.Model.back = .title([(icon.text, icon.font, Config.color.txt_1, .normal), (icon.text, icon.font, Config.color.txt_1.cd_alpha(0.6), .highlighted), (icon.text, icon.font, Config.color.txt_1.cd_alpha(0.6), .selected)])
        
        CD.iOSAdjustmentBehavior()
        UITextView.appearance().tintColor = Config.color.main_1
        UITextField.appearance().tintColor = Config.color.main_1
        UITableViewCell.appearance().selectionStyle = .none
        UITableView.appearance().backgroundColor = Config.color.bg
        UICollectionView.appearance().backgroundColor = Config.color.bg
       
        UINavigationBar.appearance().tintColor = Config.color.hex("0f", dark: "f")
        UINavigationBar.appearance().backIndicatorImage = UIImage.cd_iconfont(CD_IconFont.tback_light(22), color: Config.color.hex("0f", dark: "f"))
        UINavigationBar.appearance().backIndicatorTransitionMaskImage = UIImage.cd_iconfont(CD_IconFont.tback_light(22), color: Config.color.hex("0f", dark: "f"))
    }
    
    func makeIQKeyboard(){
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
    }
    
    func makeRefresh() {
        
    }
}



