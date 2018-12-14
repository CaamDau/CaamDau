//Created  on 2018/12/13  by LCD :https://github.com/liucaide .

import Foundation

public extension UITableView {
    func cd_cell(_ id:String, _ cellClass:AnyClass) -> UITableViewCell{
        var cell = self.dequeueReusableCell(withIdentifier: id)
        if cell == nil  {
            let bundle = Bundle.main.path(forResource:id, ofType: "nib")
            if bundle == nil{
                self.register(cellClass, forCellReuseIdentifier: id)
            }else{
                let nib = UINib(nibName: id, bundle: nil)
                self.register(nib, forCellReuseIdentifier: id)
            }
            cell = self.dequeueReusableCell(withIdentifier: id)
        }
        return cell ?? UITableViewCell()
    }
}
