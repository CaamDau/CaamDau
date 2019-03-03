import UIKit
import Foundation


struct M_Sign {
    enum Style {
        case loginPwd
        case loginCode
        case register
        case pwdChange
        case pwdForget
    }
    
    var style:Style
    
    var account:String = "" {
        didSet{
            verification()
        }
    }
    var accountMaxCount:Int = 11
    var accountMixCount:Int = 1
    
    
    var password:String = "" {
        didSet{
            verification()
        }
    }
    var passwordVerify:String = "" {
        didSet{
            verification()
        }
    }
    var passwordMaxCount:Int = 20
    var passwordMixCount:Int = 6
    
    
    var verifyCode:String = "" {
        didSet{
            verification()
        }
    }
    var verifyCodeMaxCount:Int = 6
    var verifyCodeMixCount:Int = 4
    var blockCodeEnabled:(() -> (Void))?
    var isCodeEnabled:Bool = false {
        didSet{
            guard isCodeEnabled != oldValue else {
                return
            }
            blockCodeEnabled?()
        }
    }
    
    
    var blockSubmitEnabled:(() -> (Void))?
    var isSubmitEnabled:Bool = false {
        didSet{
            guard isSubmitEnabled != oldValue else {
                return
            }
            blockSubmitEnabled?()
        }
    }
    
    
    mutating func verification() {
        switch style {
        case .loginPwd:
            isSubmitEnabled =
                account.count >= accountMixCount
                && account.count <= accountMaxCount
                && password.count >= passwordMixCount
                && password.count <= passwordMaxCount
            
        case .loginCode:
            isCodeEnabled =
                account.count >= accountMixCount
                && account.count <= accountMaxCount
            
            isSubmitEnabled =
                isCodeEnabled
                && verifyCode.count >= verifyCodeMixCount
                && verifyCode.count <= verifyCodeMaxCount
        case .register, .pwdForget:
            isCodeEnabled =
                account.count >= accountMixCount
                && account.count <= accountMaxCount
            
            isSubmitEnabled =
                isCodeEnabled
                && password.count >= passwordMixCount
                && password.count <= passwordMaxCount
                && verifyCode.count >= verifyCodeMixCount
                && verifyCode.count <= verifyCodeMaxCount
        case .pwdChange:
            isSubmitEnabled =
                account.count >= accountMixCount
                && account.count <= accountMaxCount
                && password.count >= passwordMixCount
                && password.count <= passwordMaxCount
                && passwordVerify.count >= passwordMixCount
                && passwordVerify.count <= passwordMaxCount
        }
    }
    
    init(_ style:M_Sign.Style) {
        self.style = style
    }
}



var m = M_Sign(.loginPwd)

m.blockCodeEnabled = {
    print("blockisCodeEnabled-->", m.isCodeEnabled)
}

m.blockSubmitEnabled = {
    print("blockisSubmitEnabled-->", m.isSubmitEnabled)
}


func changeAcc(_ t:String){
    m.account += t
    m.password += t
    print(m.account)
    sleep(1)
    if !m.isSubmitEnabled {
        changeAcc(t)
    }else{
        m.account = "22"
        m.password = "33"
    }
}

changeAcc("1")
m.account
