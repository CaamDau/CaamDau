//Created  on 2018/12/16  by LCD :https://github.com/liucaide .

import UIKit





class VM_FormTableView {
    enum Section:Int {
        case value0 = 0
        case value1
        case end
        
        var headerTitle:String {
            switch self {
            case .value0:
                return "Form"
            default:
                return ""
            }
        }
    }
    lazy var forms:[[CellProtocol]] = {
        return (0..<Section.end.rawValue).map{_ in []}
    }()
    
    
    lazy var formsHeader:[CellProtocol] = {
        var f = [CellProtocol]()
        for (i,item) in self.forms.enumerated() {
            f.append(RowCell<View_Header>(data:Section(rawValue: i)!.headerTitle, frame: CGRect(h:30)))
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
