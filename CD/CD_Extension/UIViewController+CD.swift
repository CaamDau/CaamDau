//Created  on 2018/12/11  by LCD :https://github.com/liucaide .

import Foundation

public extension UIViewController{
    class func cd_storyboard(name:String = "Main", id:String = "") -> UIViewController {
        let identifier = id == "" ? String(describing: self) : id
        return UIStoryboard(name: name, bundle: nil).instantiateViewController(withIdentifier: identifier)
    }
}



