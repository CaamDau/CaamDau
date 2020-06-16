//Created  on 2018/12/16  by LCD :https://github.com/liucaide .

import UIKit


public class M_HomeNews:NSObject {
    var img = ""
    var name = "LCD"
    override init() {
        
    }
}



class VM_Home {
    enum Section:Int {
        case value0 = 0
        case value1
        case end
    }
    
    lazy var forms:[[CellProtocol]] = {
        return (0..<Section.end.rawValue).map{_ in []}
    }()
    
    init() {
        makeForm()
    }
    
}
//MARK:--- 排版 ----------
extension VM_Home{
    func makeForm() {
        
    }
}
