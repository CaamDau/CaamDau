//Created  on 2018/12/13  by LCD :https://github.com/liucaide .

import Foundation
import UIKit

public extension CD where Base: UITableView {
    func cell(_ cellClass:AnyClass, id:String = "", bundleFrom:String = "") -> UITableViewCell?{
        let identifier = id=="" ? String(describing: cellClass) : id
        var cell = base.dequeueReusableCell(withIdentifier: identifier)
        if cell == nil  {
            if bundleFrom.count == 0 {
                let bundle = Bundle.main.path(forResource:identifier, ofType: "nib")
                if bundle == nil{
                    base.register(cellClass, forCellReuseIdentifier: identifier)
                }else{
                    let nib = UINib(nibName:identifier, bundle: nil)
                    base.register(nib, forCellReuseIdentifier: identifier)
                }
            }else{
                let nib = UINib(nibName:identifier, bundle: Bundle.cd_bundle(cellClass, bundleFrom))
                base.register(nib, forCellReuseIdentifier: identifier)
            }
            cell = base.dequeueReusableCell(withIdentifier: identifier)
        }
        guard let ce = cell else {
            assertionFailure("👉👉👉dequeueReusableCell 失败，请检查你的cell👈👈👈")
            return nil
        }
        return ce
    }
}
