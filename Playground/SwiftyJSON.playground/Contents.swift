import UIKit
import RxSwift
import RxCocoa
import Alamofire
import RxAlamofire
import SwiftyJSON
import CaamDau


/// 一般来说，在开发中 都是 model先行的，并不一定先有明确的 json
/// 同时，通用model需要达到 多模块的契合
public protocol SwiftyJSONProtocol {
    /// model 遵循 此协议，使用SwiftyJSON 进行转模型
    /// 多模块通用可根据 tag，实现不同 json <key> 转同一模型
    init(_ json:JSON, tag:Int?)
}

public extension Net {
    func mapModels<T:SwiftyJSONProtocol>(withSwiftyJSON t:T.Type, tag:Int? = nil, succeed:(([T]) ->Void)?) -> Self {
        success = { res in
            let jsons = JSON(res).arrayValue
            let model = jsons.compactMap{T($0, tag: tag)}
            succeed?(model)
        }
        return self
    }
    @discardableResult
    func mapModel<T:SwiftyJSONProtocol>(withSwiftyJSON t:T.Type, tag:Int? = nil, succeed:((T) ->Void)?) -> Self {
        success = { res in
            let json = JSON(res)
            let model = T(json, tag: tag)
            succeed?(model)
        }
        return self
    }
}

extension Net {
    public enum RequestStyle {
        case data
        case json
        case string
    }
    
    public struct Error: Swift.Error {
        let code:Int
        let massage:String
    }
    
    public struct Manager {
        /// 超时时间 默认 15 秒
        public var timeoutInterval:TimeInterval = 10
        /// 默认 header
        public var headers:[String:String] = [:]
        /// 默认w网址
        public var baseURL:String = ""
        /// 开启控制台 print
        public var log:Bool = true
        /// 返回数据样式 默认 json
        public var responseStyle:Net.RequestStyle = .json
        /// method 默认 get
        public var method:Alamofire.HTTPMethod = .get
    }
    
    public struct UploadParam {
        ///Data数据流
        var fileData = Data()
        ///文件的FileURL
        var fileURL:URL?
        ///服务器对应的参数名称
        var serverName = ""
        ///文件的名称(上传到服务器后，服务器保存的文件名)
        var filename = ""
        ///文件的MIME类型
        ///(image/png,image/jpg,application/octet-stream/video/mp4等)
        var mimeType = "image/png"
        ///文件类型
        var type:Style = .data
        
        enum Style {
            case data
            case file
        }
    }
}
extension Net.Error: LocalizedError {
    /// 错误的本地化消息
    public var errorDescription: String? {
        return massage
    }
    /// 失败原因的本地化消息。
    public var failureReason: String? {
        return nil
    }
    /// 如何从失败中恢复的本地化消息
    public var recoverySuggestion: String? {
        return nil
    }
    /// “帮助”文本的本地化消息
    public var helpAnchor: String? {
        return nil
    }
}
public class Net {
    open var method:Alamofire.HTTPMethod = .get
    open var baseURL:String  = ""
    open var path:String  = ""
    open var parameters:[String:Any]?
    open var uploadParameters:[UploadParam] = []
    open var encoding:ParameterEncoding = URLEncoding.default
    open var headers:[String:String]?
    open var timeoutInterval:TimeInterval = 10
    open var log:Bool = false
    open var responseStyle:Net.RequestStyle = .json
    
    open var statusCodes:[Int] = [200]
    open var success:((Any) ->Void)?
    open var failure:((Net.Error) ->Void)?
    open var uploadProgress:Request.ProgressHandler?
    open var onCache:((Any) ->Void)?
    open var cache:(() ->Void)?
    
    
    fileprivate var request:Alamofire.DataRequest?
    fileprivate var uploadRequest:Alamofire.UploadRequest?
    
    static var config:Manager = Manager()
    init() {
        self.timeoutInterval = Net.config.timeoutInterval
        self.headers = Net.config.headers
        self.baseURL = Net.config.baseURL
        self.log = Net.config.log
        self.responseStyle = Net.config.responseStyle
        self.method = Net.config.method
    }
}

extension Net {
    func logPrint<T>(_ res:DataResponse<T>) {
        guard log else { return }
        debugPrint("---👉👉👉", res.request?.url ?? "")
        debugPrint("Headers：", headers ?? "")
        debugPrint("Parameters：", parameters ?? "")
        debugPrint(res.result)
        debugPrint("----------  👻")
    }
    func disposeResponse<T>(_ response:DataResponse<T>) {
        logPrint(response)
        switch response.result {
        case .success(let res):
            let statusCode = response.response?.statusCode
            if let code = statusCode, self.statusCodes.contains(code) {
                self.cache?()
                self.success?(res)
            }else{
                let err = Net.Error(code: statusCode ?? -88888, massage: "")
                self.failure?(Net.Error(code: err.code, massage: err.localizedDescription))
            }
        case .failure(let error):
            let err = error as NSError
            self.failure?(Net.Error(code: err.code, massage: err.localizedDescription))
        }
    }
    func request(_ style:Net.RequestStyle = .json) -> Self {
        responseStyle = style
        let urlPath = (self.baseURL + self.path)
        request = SessionManager.default.request(urlPath, method: self.method, parameters: self.parameters, encoding: self.encoding, headers: self.headers)
        request?.session.configuration.timeoutIntervalForRequest = timeoutInterval
        switch responseStyle {
        case .json:
            request?.responseJSON { (response) in
                self.disposeResponse(response)
            }
        case .string:
            request?.responseString { (response) in
                self.disposeResponse(response)
            }
        case .data:
            request?.responseData { (response) in
                self.disposeResponse(response)
            }
        }
        return self
    }
    
    func disposeUpload(_ encodingResult:SessionManager.MultipartFormDataEncodingResult) {
        switch encodingResult {
        case .success(let uploads, _, _):
            uploadRequest = uploads
            uploadRequest?.uploadProgress(closure: { (progress) in
                self.uploadProgress?(progress)
            })
            switch responseStyle {
            case .json:
                uploadRequest?.responseJSON { (response) in
                    self.disposeResponse(response)
                }
            case .string:
                uploadRequest?.responseString { (response) in
                    self.disposeResponse(response)
                }
            case .data:
                uploadRequest?.responseData { (response) in
                    self.disposeResponse(response)
                }
            }
            
        case .failure(let error):
            let err = error as NSError
            self.failure?(Net.Error(code: err.code, massage: err.localizedDescription))
        }
    }
    
    /// 上传 MultipartFormData 类型的文件数据，
    func uploadFormData(_ style:Net.RequestStyle = .json) {
        responseStyle = style
        let url = (self.baseURL + self.path)
        SessionManager.default.upload(multipartFormData: { (formData) in
            for item in self.uploadParameters {
                switch (item.type) {
                case .data:
                    formData.append(item.fileData, withName: item.serverName, fileName: item.filename, mimeType: item.mimeType)
                case .file:
                    if let fileUrl = item.fileURL {
                        formData.append(fileUrl, withName: item.serverName, fileName: item.filename, mimeType: item.mimeType)
                    }
                }
            }
            for item in self.parameters ?? [:] {
                let dat:Data = (item.value as? String)?.data(using: String.Encoding.utf8) ?? Data()
                formData.append(dat, withName: item.key)
            }
        }, to: url,
           headers:headers,
           encodingCompletion: { (encodingResult) in
            self.disposeUpload(encodingResult)
        })
    }
    /// 下载，断线续传能力
}

public extension Net {
    @discardableResult
    func onCache(_ t:((Any) ->Void)?) -> Self {
        
        return self
    }
    
    @discardableResult
    func cache(_ t:() -> Bool) -> Self {
        guard t() else { return self}
        print("cache")
        return self
    }
}

public extension Net {
    @discardableResult
    func method(_ t:Alamofire.HTTPMethod) -> Self {
        method = t
        return self
    }
    @discardableResult
    func baseURL(_ t:String) -> Self {
        baseURL = t
        return self
    }
    @discardableResult
    func path(_ t:String) -> Self {
        path = t
        return self
    }
    @discardableResult
    func parameters(_ t:[String:Any]?) -> Self {
        parameters = t
        return self
    }
    @discardableResult
    func uploadParameters(_ t:[Net.UploadParam]) -> Self {
        uploadParameters = t
        return self
    }
    
    @discardableResult
    func encoding(_ t:ParameterEncoding) -> Self {
        encoding = t
        return self
    }
    @discardableResult
    func headers(_ t:[String:String]?) -> Self {
        headers = t ?? Net.config.headers
        return self
    }
    @discardableResult
    func timeoutInterval(_ t:TimeInterval) -> Self {
        timeoutInterval = t
        return self
    }
    @discardableResult
    func log(_ t:Bool) -> Self {
        log = t
        return self
    }
    @discardableResult
    func responseStyle(_ t:Net.RequestStyle) -> Self {
        responseStyle = t
        return self
    }
    @discardableResult
    func statusCodes(_ t:[Int]) -> Self {
        statusCodes = t
        return self
    }
    @discardableResult
    func success(_ t:((Any) ->Void)?) -> Self {
        success = t
        return self
    }
    @discardableResult
    func failure(_ t:((Net.Error) ->Void)?) -> Self {
        failure = t
        return self
    }
    @discardableResult
    func uploadProgress(_ t:Request.ProgressHandler?) -> Self {
        uploadProgress = t
        return self
    }
    
    @discardableResult
    func cancel() -> Self {
        request?.cancel()
        uploadRequest?.cancel()
        return self
    }
    
    @discardableResult
    func filter(_ t:() -> Bool) -> Self {
        guard t() else { return self}
        
        return self
    }
    
    @discardableResult
    func upload(_ style:Net.RequestStyle = .json) -> Self {
        uploadFormData(style)
        return self
    }
}



//Alamofire.request("http://httpbin.org/get", parameters: ["foo": "bar"])
//    .responseJSON(completionHandler: { (response) in
//        switch response.result {
//        case .success(let json):
//            print("JSON:",json)
//        case .failure(let error):
//            let err = error as NSError
//        }
//    })


struct M_Test<T:SwiftyJSONProtocol>:SwiftyJSONProtocol {
    init(_ json: JSON, tag: Int?) {
        code = json["origin"].stringValue
        data = T(json["headers"], tag: tag)
    }
    let code:String
    let data:T
}

struct M_T:SwiftyJSONProtocol {
    init(_ json: JSON, tag: Int?) {
        host = json["Host"].stringValue
    }
    let host:String
    
}

class Test {
    func test() {
        
        var page = 0
        
        _ = Net()
            .baseURL("http://httpbin.org/")
            .path("get")
            .method(.get)
            .parameters(["foo": "bar"])
            .request(.json)
            .onCache({ (_) in
                
            })
            .cache{page == 1}
            .mapModel(withSwiftyJSON: M_Test<M_T>.self)
            { (m) in
                print(m.code)
                print(m.data.host)
            }
            .failure({ (error) in
                print(error.code)
                print(error.massage)
            })
        
    }
}

//let tt = Test()
//tt.test()


struct MMM: Codable {
    let id:Int
    let name:String
    let img:String
}
let arr = [["code":"1"],["code":"2"]]

let str = #"[{"id":0,"name":"name","img":"img"},{"id":0,"name":"name","img":"img"}]"#

let data = str.data(using: String.Encoding.utf8)!
let decoder = JSONDecoder()
let model = try? decoder.decode([MMM].self, from: data)


