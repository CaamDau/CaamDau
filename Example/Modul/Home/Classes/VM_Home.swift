//Created  on 2018/12/16  by LCD :https://github.com/liucaide .

import UIKit
import CD

public class M_HomeNews:NSObject {
    var img = ""
    var name = "LCD"
    override init() {
        
    }
}

class VM_Home {
    var forms:[[CD_RowProtocol]] = []
    
    init() {
        makeForm()
    }
    
}
//MARK:--- 排版 ----------
extension VM_Home{
    func makeForm() {
        
        var f1 = [CD_RowProtocol]()
        let row4 = CD_Row<Cell_HomeTitle>(data:"Form", frame:CGRect(h:45))
        f1.append(row4)
        let row5 = CD_Row<Cell_HomeTitle>(data:"Chain", frame:CGRect(h:45))
        f1.append(row5)
        let row6 = CD_Row<Cell_HomeTitle>(data:"MJRefresh", frame:CGRect(h:45))
        f1.append(row6)
        forms.append(f1)
 
        var f2 = [CD_RowProtocol]()
        let data = ("开关", false)
        let row8 = CD_Row<Cell_HomeSwitch>(data:data, frame:CGRect(h:55))
        f2.append(row8)
        
        var model = M_HomeNews()
        let row9 = CD_Row<Cell_HomeNews>(data:model, frame:CGRect(h:80))
        f2.append(row9)
        forms.append(f2)
    
        
    }
}
