//Created  on 2018/12/13  by LCD :https://github.com/liucaide .

import Foundation
import UIKit

public extension UINib{
    
    static func cd_xibWithBundle(from:String, name:String) -> UINib? {
        return UINib(nibName: name, bundle: Bundle.cd_bundle(self, from))
    }
}
