//Created  on 2018/02/27  by LCD :https://github.com/liucaide .

import Foundation
import UIKit

public class M_Sign {
    public enum Style {
        case loginPwd
        case loginCode
        case register
        case pwdChange
        case pwdForget
    }
    
    public var style:Style?
    
    public var account:String = "" {
        didSet{
            verification()
        }
    }
    public var accountMaxCount:Int = 11
    public var accountMixCount:Int = 1
    
    
    public var password:String = "" {
        didSet{
            verification()
        }
    }
    public var passwordVerify:String = "" {
        didSet{
            verification()
        }
    }
    public var passwordMaxCount:Int = 20
    public var passwordMixCount:Int = 6
    
    
    public var verifyCode:String = "" {
        didSet{
            verification()
        }
    }
    /// 是否同意用户协议
    public var isAgreement:Bool = true {
        didSet{
            verification()
        }
    }
    
    
    public var verifyCodeMaxCount:Int = 6
    public var verifyCodeMixCount:Int = 4
    public var blockCodeEnabled:((Bool) -> (Void))?
    public var isCodeEnabled:Bool = false {
        didSet{
            guard isCodeEnabled != oldValue else {
                return
            }
            blockCodeEnabled?(isCodeEnabled)
        }
    }
    
    
    public var blockSubmitEnabled:((Bool) -> (Void))?
    public var isSubmitEnabled:Bool = false {
        didSet{
            guard isSubmitEnabled != oldValue else {
                return
            }
            blockSubmitEnabled?(isSubmitEnabled)
        }
    }
    
    
    func verification() {
        switch style {
        case .loginPwd?:
            isSubmitEnabled =
                account.count >= accountMixCount
                && account.count <= accountMaxCount
                && password.count >= passwordMixCount
                && password.count <= passwordMaxCount
                && isAgreement
            
        case .loginCode?:
            isCodeEnabled =
                account.count >= accountMixCount
                && account.count <= accountMaxCount
            
            isSubmitEnabled =
                isCodeEnabled
                && verifyCode.count >= verifyCodeMixCount
                && verifyCode.count <= verifyCodeMaxCount
                && isAgreement
        case .register?, .pwdForget?:
            isCodeEnabled =
                account.count >= accountMixCount
                && account.count <= accountMaxCount
            
            isSubmitEnabled =
                isCodeEnabled
                && password.count >= passwordMixCount
                && password.count <= passwordMaxCount
                && verifyCode.count >= verifyCodeMixCount
                && verifyCode.count <= verifyCodeMaxCount
                && isAgreement
        case .pwdChange?:
            isSubmitEnabled =
                account.count >= accountMixCount
                && account.count <= accountMaxCount
                && password.count >= passwordMixCount
                && password.count <= passwordMaxCount
                && passwordVerify.count >= passwordMixCount
                && passwordVerify.count <= passwordMaxCount
                && isAgreement
        case .none:
            break
        }
    }
    private init(){}
    public init(_ style:M_Sign.Style) {
        self.style = style
    }
}
