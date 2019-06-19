//Created  on 2018/12/11  by LCD :https://github.com/liucaide .

import Foundation
import CD
/*
 分析 资源图片的使用场景
 1、资源图片多，
 2、在列表中每个单元格都会使用到的图片，使用 实例对象懒加载性能是最优的
 3、在
 */
/*
//MARK:--- 日间模式 ----------
public class Assets {
    public init(){}
    deinit {
        print_cd("Assets deinit")
    }
    public lazy var logo_200:UIImage = {
        return UIImage.cd_podImg(name:"logo_launch", forClass: Assets.self)
    }()
}
//MARK:--- 夜间模式 ----------
public class AssetsDark {
    public init(){}
    public let logo_200:UIImage = UIImage.cd_podImg(name:"logo_launch", forClass: Assets.self)
}
*/

/*
public enum AssetsImg {
    case logo_0
 
    public var light:UIImage{
        switch self {
        case .logo_0:
            return UIImage.cd_podImg(name:"launchScreen", forClass: Assets.self)
        }
    }
    public var dark:UIImage{
        switch self {
        case .logo_0:
            return UIImage.cd_podImg(name:"launchScreen", forClass: Assets.self)
        }
    }
}


public class AssetsShare {
    private init() {
        print_cd("AssetsShare init")
    }
    public static let share = AssetsShare()
    
    public let logo_60:UIImage = UIImage.cd_podImg(name:"launchScreen1", forClass: Assets.self)
}
*/
