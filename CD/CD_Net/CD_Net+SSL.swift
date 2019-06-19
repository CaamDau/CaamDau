//Created  on 2019/6/19 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 *
 */




import Foundation
import Alamofire

public extension CD_Net {
    struct IdentityAndTrust {
        var identityRef:SecIdentity
        var trust:SecTrust
        var certArray:AnyObject
    }

    //MARK:--- SSL认证 -----------------------------
    static func sslCertification(_ hosts:[String], p12:(name:String, pwd:String)) {
        let selfSignedHosts = hosts//["192.168.1.112", "www.hangge.com"]
        SessionManager.default.delegate.sessionDidReceiveChallenge = { session, challenge in
            //认证服务器（这里不使用服务器证书认证，只需地址是我们定义的几个地址即可信任）
            if challenge.protectionSpace.authenticationMethod
                == NSURLAuthenticationMethodServerTrust
                && selfSignedHosts.contains(challenge.protectionSpace.host)
            {
                debugPrint("服务器认证！")
                let credential = URLCredential(trust: challenge.protectionSpace.serverTrust!)
                return (.useCredential, credential)
            }
                //认证客户端证书
            else if challenge.protectionSpace.authenticationMethod
                == NSURLAuthenticationMethodClientCertificate
            {
                debugPrint("客户端证书认证！")
                //获取客户端证书相关信息
                let identityAndTrust:CD_Net.IdentityAndTrust = CD_Net.extractIdentity(p12);
                let urlCredential:URLCredential = URLCredential(
                    identity: identityAndTrust.identityRef,
                    certificates: identityAndTrust.certArray as? [AnyObject],
                    persistence: URLCredential.Persistence.forSession);
                
                return (.useCredential, urlCredential);
            }
                // 其它情况（不接受认证）
            else
            {
                debugPrint("其它情况（不接受认证）")
                return (.cancelAuthenticationChallenge, nil)
            }
        }
    }
    
    //MARK:--- 双向认证 -----------------------------
    static func sslCertificationTwoWay(_ cerName:String ,p12:(name:String, pwd:String)) {
        
        SessionManager.default.delegate.sessionDidReceiveChallenge = { (session, challenge) in
            //认证服务器
            if challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust
            {
                debugPrint("服务端证书认证！")
                let serverTrust:SecTrust = challenge.protectionSpace.serverTrust!
                let certificate = SecTrustGetCertificateAtIndex(serverTrust, 0)!
                let remoteCertificateData
                    = CFBridgingRetain(SecCertificateCopyData(certificate))!
                //证书目录
                let cerPath = Bundle.main.path(forResource: cerName, ofType: "cer")!
                let cerUrl = URL(fileURLWithPath:cerPath)
                let localCertificateData = try! Data(contentsOf: cerUrl)
                if (remoteCertificateData.isEqual(localCertificateData) == true) {
                    let credential = URLCredential(trust: serverTrust)
                    challenge.sender?.use(credential, for: challenge)
                    return (URLSession.AuthChallengeDisposition.useCredential,
                            URLCredential(trust: challenge.protectionSpace.serverTrust!))
                }else {
                    return (.cancelAuthenticationChallenge, nil)
                }
            }
                //认证客户端证书
            else if challenge.protectionSpace.authenticationMethod
                == NSURLAuthenticationMethodClientCertificate
            {
                debugPrint("客户端证书认证！")
                //获取客户端证书相关信息
                let identityAndTrust:CD_Net.IdentityAndTrust = CD_Net.extractIdentity(p12);
                
                let urlCredential:URLCredential = URLCredential(
                    identity: identityAndTrust.identityRef,
                    certificates: identityAndTrust.certArray as? [AnyObject],
                    persistence: URLCredential.Persistence.forSession);
                
                return (.useCredential, urlCredential);
            }
                // 其它情况（不接受认证）
            else
            {
                debugPrint("其它情况（不接受认证）")
                return (.cancelAuthenticationChallenge, nil)
            }
        }
    }
    
    //MARK:--- 获取客户端证书相关信息 -----------------------------
    static fileprivate func extractIdentity(_ p12:(name:String, pwd:String)) -> CD_Net.IdentityAndTrust {
        
        var identityAndTrust:CD_Net.IdentityAndTrust!
        var securityError:OSStatus = errSecSuccess
        //客户端证书 p12 文件目录
        let path: String = Bundle.main.path(forResource: p12.name, ofType: "p12")!
        let PKCS12Data = NSData(contentsOfFile:path)!
        let key : NSString = kSecImportExportPassphrase as NSString
        let options : NSDictionary = [key : p12.pwd] //客户端证书密码
        //create variable for holding security information
        //var privateKeyRef: SecKeyRef? = nil
        var items : CFArray?
        securityError = SecPKCS12Import(PKCS12Data, options, &items)
        if securityError == errSecSuccess {
            let certItems:CFArray = items as CFArray!
            let certItemsArray:Array = certItems as Array
            let dict:AnyObject? = certItemsArray.first;
            if let certEntry:Dictionary = dict as? Dictionary<String, AnyObject> {
                // grab the identity
                let identityPointer:AnyObject? = certEntry["identity"];
                let secIdentityRef:SecIdentity = identityPointer as! SecIdentity
                //debugPrint("\(identityPointer)  :::: \(secIdentityRef)")
                // grab the trust
                let trustPointer:AnyObject? = certEntry["trust"]
                let trustRef:SecTrust = trustPointer as! SecTrust
                //debugPrint("\(trustPointer)  :::: \(trustRef)")
                // grab the cert
                let chainPointer:AnyObject? = certEntry["chain"]
                identityAndTrust = CD_Net.IdentityAndTrust(identityRef: secIdentityRef,
                                                           trust: trustRef, certArray:  chainPointer!)
            }
        }
        return identityAndTrust;
    }
}
