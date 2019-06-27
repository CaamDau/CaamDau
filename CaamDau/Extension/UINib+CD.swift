//Created  on 2018/12/13  by LCD :https://github.com/liucaide .

import Foundation
import UIKit

public extension UINib{
    static func cd_xib(_ name:String? = nil, from:String? = nil) -> UINib? {
        return UINib(nibName: name ?? String(describing: self), bundle: Bundle.cd_bundle(self, from))
    }
}
