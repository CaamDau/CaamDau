//Created  on 2019/1/11  by LCD :https://github.com/liucaide .

import Foundation
import CaamDau
import Home

struct M_MainNews {
    var name = "M_MainNews"
    
}


struct VM_ViewController {
    init() {
        makeForm()
    }
    var forms:[[CD_RowProtocol]] = []
}

extension VM_ViewController{
    mutating func makeForm() {
        var f1 = [CD_RowProtocol]()
        let arr = ["Form","Chain","MJRefresh"]
        for item in arr {
            let row = CD_Row<Cell_MainTitle>(data:item, frame:CGRect(h:45))
            f1.append(row)
        }
        forms.append(f1)
        
        var f2 = [CD_RowProtocol]()
        do{
            let data = ("开关", false)
            let row = CD_Row<Cell_MainSwitch>(data:data, frame:CGRect(h:55))
            f2.append(row)
        }
        
        for item in (0..<1) {
            let model = M_MainNews()
            let row = CD_Row<Cell_MainNews>(data:model, tag:item, frame:CGRect(h:80))
            f2.append(row)
        }
        
        do{
            let model = M_MainNews()
            let row9 = CD_Row<Cell_HomeNews>(data:model, frame:CGRect(h:80), bundleFrom:"Home")
            f2.append(row9)
        }
        forms.append(f2)
    }
}
