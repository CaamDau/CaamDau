//Created  on 2018/12/16  by LCD :https://github.com/liucaide .

import UIKit
import CD
import Util

struct VM_Sign {
    
    var form:[CD_RowProtocol] = []
    var m_sign:M_Sign = M_Sign(M_Sign.Style.loginPwd)
    
    mutating func makeForm() {
        do {
            let row = CD_Row<Cell_SignLine>.init(data: "", frame: CGRect(h: 60))
            form.append(row)
        }
        do {
            let row = CD_Row<Cell_SignInput>.init(data: (Cell_SignInput.Style.account("账号：", "请输入账号"), m_sign), frame: CGRect(h: 40))
            form.append(row)
        }
        do {
            let row = CD_Row<Cell_SignLine>.init(data: "", frame: CGRect(h: 15))
            form.append(row)
        }
        do {
            let row = CD_Row<Cell_SignInput>.init(data: (Cell_SignInput.Style.pwd("密码：", "请输入6~20位密码"), m_sign), frame: CGRect(h: 40))
            form.append(row)
        }
        do {
            let row = CD_Row<Cell_SignLine>.init(data: "", frame: CGRect(h: 15))
            form.append(row)
        }
        do {
            let row = CD_Row<Cell_SignOption>.init(data: "", frame: CGRect(h: 40))
            form.append(row)
        }
        do {
            let row = CD_Row<Cell_SignLine>.init(data: "", frame: CGRect(h: 15))
            form.append(row)
        }
        do {
            let row = CD_Row<Cell_SignSubmit>.init(data: m_sign, frame: CGRect(h: 40))
            form.append(row)
        }
        do {
            let row = CD_Row<Cell_SignLine>.init(data: "", frame: CGRect(h: 10))
            form.append(row)
        }
        do {
            let row = CD_Row<Cell_SignAgreement>.init(data: m_sign, frame: CGRect(h: 30))
            form.append(row)
        }
        do {
            let row = CD_Row<Cell_SignLine>.init(data: "", frame: CGRect(h: 15))
            form.append(row)
        }
        
        do {
            let row = CD_Row<Cell_SignOther>.init(data: "", frame: CGRect(h: 40))
            form.append(row)
        }
        do {
            let row = CD_Row<Cell_SignOtherBtn>.init(data: "", frame: CGRect(h: 100))
            form.append(row)
        }
    }
    
    
    init() {
        makeForm()
    }
}
