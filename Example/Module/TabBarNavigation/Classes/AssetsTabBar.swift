
//更多代码自动化可了解 :https://github.com/liucaide/SapSapSeoi .
    
import Foundation
import UIKit
import CaamDau

public class AssetsTabBar {
    public init(){}
    
    public lazy var home_normal:UIImage = {
        return UIImage.cd_bundle("home_normal", forClass:AssetsTabBar.self)
    }()
    
    public lazy var me_normal:UIImage = {
        return UIImage.cd_bundle("me_normal", forClass:AssetsTabBar.self)
    }()
        
    public lazy var me_selected:UIImage = {
        return UIImage.cd_bundle("me_selected", forClass:AssetsTabBar.self)
    }()
        
    public lazy var home_selected:UIImage = {
        return UIImage.cd_bundle("home_selected", forClass:AssetsTabBar.self)
    }()
        
}
    
