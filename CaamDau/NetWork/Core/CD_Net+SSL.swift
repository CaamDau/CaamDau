//Created  on 2019/6/19 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 *
 */




import Foundation
import Alamofire

public extension CD_Net {
    static func ssl(withHosts hosts:[String], p12:(name:String, pwd:String), bundleForm:String = "") {
        SessionManager.default.delegate.sessionDidReceiveChallenge = { (session, challenge) -> (URLSession.AuthChallengeDisposition, URLCredential?) in
            switch challenge.protectionSpace.authenticationMethod {
            case NSURLAuthenticationMethodServerTrust where hosts.contains(challenge.protectionSpace.host):
                return serverAuthentication(session, challenge)
            case NSURLAuthenticationMethodClientCertificate:
                return clientAuthentication(p12, bundleForm: bundleForm)
            default:
                debugPrint("其它情况（不接受认证）")
                return (.cancelAuthenticationChallenge, nil)
            }
        }
    }
    
    static func ssl(withCer name:String , p12:(name:String, pwd:String) = ("",""), bundleForm:String = "") {
        SessionManager.default.delegate.sessionDidReceiveChallenge = { (session, challenge) -> (URLSession.AuthChallengeDisposition, URLCredential?) in
            switch challenge.protectionSpace.authenticationMethod {
            case NSURLAuthenticationMethodServerTrust:
                var bundle:Bundle?
                if !bundleForm.isEmpty, let bu
                    = Bundle.cd_bundle(CD_Net.self, bundleForm)  {
                    bundle = bu
                }else{
                    bundle = Bundle.main
                }
                guard let path = bundle?.path(forResource: name, ofType: "cer"),
                    let secTrust:SecTrust = challenge.protectionSpace.serverTrust,
                    let certificate = SecTrustGetCertificateAtIndex(secTrust, 0),
                    let secData
                    = CFBridgingRetain(SecCertificateCopyData(certificate)) else {
                        debugPrint("（不接受认证）")
                        return (.cancelAuthenticationChallenge, nil)
                }
                let cerUrl = URL(fileURLWithPath: path)
                guard let data = try? Data(contentsOf: cerUrl) else {
                    return (.cancelAuthenticationChallenge, nil)
                }
                if secData.isEqual(data) {
                    return serverAuthentication(session, challenge)
                }else {
                    debugPrint("（不接受认证）")
                    return (.cancelAuthenticationChallenge, nil)
                }
            case NSURLAuthenticationMethodClientCertificate:
                return clientAuthentication(p12, bundleForm: bundleForm)
            default:
                debugPrint("其它情况（不接受认证）")
                return (.cancelAuthenticationChallenge, nil)
            }
        }
    }
    
    static private func serverAuthentication(_ session:URLSession, _ challenge:URLAuthenticationChallenge) -> (URLSession.AuthChallengeDisposition, URLCredential?) {
        guard let secTrust:SecTrust = challenge.protectionSpace.serverTrust else {
            debugPrint("（不接受认证）")
            return (.cancelAuthenticationChallenge, nil)
        }
        debugPrint("服务端认证！")
        let credential = URLCredential(trust: secTrust)
        challenge.sender?.use(credential, for: challenge)
        return (.useCredential, URLCredential(trust: secTrust))
    }
    
    static private func clientAuthentication(_ p12:(name:String, pwd:String), bundleForm:String = "") -> (URLSession.AuthChallengeDisposition, URLCredential?) {
        debugPrint("客户端证书认证！")
        //获取客户端证书相关信息
        guard let identityAndTrust = CD_Net.extractIdentity(p12, bundleForm:bundleForm) else {
            debugPrint("（不接受认证）")
            return (.cancelAuthenticationChallenge, nil)
        }
        
        let urlCredential:URLCredential = URLCredential(identity: identityAndTrust.identityRef,
                                                        certificates: identityAndTrust.certArray as? [Any] ?? [],
                                                        persistence: .forSession)
        debugPrint("认证通过")
        return (.useCredential, urlCredential)
    }
    
    //MARK:--- 获取客户端证书相关信息 -----------------------------
    static fileprivate func extractIdentity(_ p12:(name:String, pwd:String), bundleForm:String = "") -> IdentityAndTrust? {
        
        var identity:IdentityAndTrust
        var errSec:OSStatus
        //客户端证书 p12 文件目录
        var bundle:Bundle?
        if !bundleForm.isEmpty, let bu
            = Bundle.cd_bundle(CD_Net.self, bundleForm)  {
            bundle = bu
        }else{
            bundle = Bundle.main
        }
        guard let path: String = bundle?.path(forResource: p12.name, ofType: "p12"),
            let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else {
            return nil
        }
        let key : String = kSecImportExportPassphrase as String
        //客户端证书密码
        guard let options:CFDictionary = [key : p12.pwd] as? CFDictionary else {
            return nil
        }
        var items : CFArray?
        errSec = SecPKCS12Import(data as CFData, options as CFDictionary, &items)
        guard errSec == errSecSuccess,
            let itemss = items as? Array<Any>,
            let dict:Dictionary<AnyHashable, Any> = itemss.first as? Dictionary<AnyHashable, Any>,
            let identityRef = dict["identity"],
            let trustRef = dict["trust"],
            let chainPointer = dict["chain"] else {
            return nil
        }
        identity = IdentityAndTrust(identityRef: identityRef as! SecIdentity,
                                    trust: trustRef as! SecTrust,
                                    certArray:  chainPointer as AnyObject)
        return identity
    }
    
    fileprivate struct IdentityAndTrust {
        var identityRef:SecIdentity
        var trust:SecTrust
        var certArray:AnyObject
    }
}
