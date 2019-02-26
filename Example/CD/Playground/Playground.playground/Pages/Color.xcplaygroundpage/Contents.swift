//: [Previous](@previous)

import Foundation
import UIKit

public extension UIColor {
    @discardableResult
    static func cd_rgb(_ red:CGFloat = 0, _ green:CGFloat = 0, _ blue:CGFloat = 0, _ alpha:CGFloat = 1) -> UIColor {
        return UIColor(red: CGFloat(red)/255.0, green: CGFloat(green)/255.0, blue: CGFloat(blue)/255.0, alpha: alpha)
    }
    
    @discardableResult
    static func cd_hex(_ hex:String) -> UIColor {
        var str: String = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        if str.hasPrefix("#") {
            str = str[1..<7]
        }else if s.hasPrefix("0X") {
            str = str[2..<8]
        }
        switch str.count {
        case 0: //  - 000000
            str = "000000"
        case 1:// F - FFFFFF
            str[0..<6] = str[0..<1]
        case 2:// F1 - F1F1F1
            str[0..<5] = str[0..<1]
        case 3:// F1F - F1FFFF
            str[0..<4] = str[0..<1]
        case 4:// F1F2 - F1F2F2
            str[0..<3] = str[0..<1]
        case 5:// F1F2D - F1F2DD
            str[0..<2] = str[0..<1]
        case 6:// F1F2D4 - F1F2D4
            break
        default:
            break
        }
        guard s.count == 6 else {
            return UIColor.white
        }
        //这是string的一个扩展需要在String扩展中找
        s = s[1..<7]
        let sr = s[0..<2]
        let sg = s[2..<4]
        let sb = s[4..<6]
        var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0;
        Scanner(string: sr).scanHexInt32(&r)
        Scanner(string: sg).scanHexInt32(&g)
        Scanner(string: sb).scanHexInt32(&b)
        return UIColor.cd_rgb(CGFloat(r), CGFloat(g), CGFloat(b))
        
    }
    
    func cd_alpha(_ a:CGFloat) -> UIColor {
        return self.withAlphaComponent(a)
    }
}




