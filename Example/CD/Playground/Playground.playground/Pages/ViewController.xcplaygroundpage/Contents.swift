//: [Previous](@previous)

import Foundation
import UIKit
import PlaygroundSupport

var cd_fontFitSize:CGFloat = 0
extension UIFont {
    func fit() -> UIFont {
        return self.withSize(self.pointSize+cd_fontFitSize)
    }
}

class MyViewController : UIViewController {
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white
        cd_fontFitSize = 10
        let label = UILabel()
        label.frame = CGRect(x: 20, y: 20, width: 200, height: 50)
        label.text = "Hello World!"
        label.textColor = .black
        
        label.font = UIFont(name: "PingFang SC", size: 23)?.fit()
        print("familyNames:",UIFont.familyNames)
        print("familyName:",label.font.familyName,
              "\npointSize:", label.font.pointSize,
              "\nfontName:",label.font.fontName)
        view.addSubview(label)
        self.view = view
    }
}
PlaygroundPage.current.liveView = MyViewController()

//func cd_codeDescription() -> (Any){
//    return (#file.components(separatedBy: "/").last ?? #file, #line, #function)
//}
//func test(){
//    let tt = cd_codeDescription()
//    print(tt)
//}

//test()

