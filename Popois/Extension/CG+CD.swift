//Created  on 2018/12/11  by LCD :https://github.com/liucaide .

import Foundation
import UIKit

public extension CGRect{
    init(x:CGFloat = 0, y:CGFloat = 0, w:CGFloat = 0, h:CGFloat = 0) {
        self.init(x: x, y: y, width: w, height: h)
    }
}

public extension CGPoint{
    init(xx:CGFloat = 0, yy:CGFloat = 0) {
        self.init(x: xx, y: yy)
    }
}

public extension CGSize{
    init(w:CGFloat = 0, h:CGFloat = 0) {
        self.init(width: w, height: h)
    }
}

public extension UIEdgeInsets {
    init(t:CGFloat = 0, l:CGFloat = 0, b:CGFloat = 0, r:CGFloat = 0) {
        self.init(top: t, left: l, bottom: b, right: r)
    }
}
public extension CGFloat {
    static var auto:CGFloat {
        return -66.66
    }
}
