
//更多代码自动化可了解 :https://github.com/liucaide/SapSapSeoi .
    
import Foundation
import UIKit


public class AssetsFile {
    public init(){}
    
    public lazy var fileicon:UIImage = {
        return UIImage.cd_bundle("fileicon", forClass:AssetsFile.self)
    }()
}
    
