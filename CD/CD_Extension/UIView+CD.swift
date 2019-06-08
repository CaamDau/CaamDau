//Created  on 2018/12/13  by LCD :https://github.com/liucaide .

import Foundation
import UIKit








public extension UIView{
    static func cd_loadNib(whthBundle from:String? = nil, nibName:String? = nil, owner: Any? = nil, options: [UINib.OptionsKey : Any]? = nil) -> [Any]? {
        let bundle = Bundle.cd_bundle(self, from) ?? Bundle.main
        return bundle.loadNibNamed(nibName ?? String(describing: self), owner: owner, options: options)
    }
}

