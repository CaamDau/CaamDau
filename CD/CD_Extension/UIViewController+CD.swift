//Created  on 2018/12/11  by LCD :https://github.com/liucaide .

import Foundation

extension UIViewController{
    static func storyboard(name:String = "Main") -> UIViewController {
        return UIStoryboard(name: name, bundle: nil).instantiateViewController(withIdentifier: NSStringFromClass(self.classForCoder()))
    }
}



