//Created  on 2019/2/27 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 *
 */




import Foundation
import CD
import Sign

struct VM_Mine {
    lazy var form:[[CD_RowProtocol]] = {
        return [[],[]]
    }()
    lazy var title0:[String] = {
        return ["登录"]
    }()
    
    var block:(()->Void)?
    
    mutating func makeForm(){
        do{
            let row = CD_Row<Cell_MineTitle>.init(data: "登录") {
                VC_Sign.isSignUp(true)
                
            }
            form[1].append(row)
        }
        
        
        block?()
    }
    
    
    init() {
        makeForm()
    }
}



class Cell_MineTitle:UITableViewCell{
    
}
extension Cell_MineTitle:CD_RowUpdateProtocol{
    typealias DataSource = String
    func row_update(_ data: String, id: String, tag: Int, frame: CGRect, callBack: CD_RowCallBack?) {
        self.textLabel?.cd.text(data)
    }
    
}
