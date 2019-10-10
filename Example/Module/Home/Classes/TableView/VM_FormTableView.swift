//Created  on 2018/12/16  by LCD :https://github.com/liucaide .

import UIKit
import CaamDau
import Web




class VM_FormTableView {
    enum Section:Int {
        case value0 = 0
        case value1
        case end
        
        var headerTitle:String {
            switch self {
            case .value0:
                return "CD_Form"
            default:
                return ""
            }
        }
    }
    lazy var forms:[[CD_RowProtocol]] = {
        return (0..<Section.end.rawValue).map{_ in []}
    }()
    
    
    lazy var formsHeader:[CD_RowProtocol] = {
        var f = [CD_RowProtocol]()
        for (i,item) in self.forms.enumerated() {
            f.append(CD_Row<View_Header>(data:Section(rawValue: i)!.headerTitle, frame: CGRect(h:30)))
        }
        return f
    }()
    
    
    init() {
        makeForm()
    }
    
}
//MARK:--- 排版 ----------
extension VM_FormTableView{
    func makeForm() {
        
    }
}
