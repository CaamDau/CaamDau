//
//  BosUploadConfiguration.swift
//  FittiMeExample
//
//  Created by guowei on 2019/4/24.
//  Copyright © 2019 Huami Inc. All rights reserved.
//

import BaiduBCEBasic
import BaiduBCEBOS
import BaiduBCESTS


public class BceConfigs: NSObject {
    public let accessKey: String!
    public let secretKey: String!
    public let sessionToken: String!
    public let endPoint: String!
    public let sourceBucket: String!
    public let mediaId: String?
    public let sourceKey: String!
    
    let expiration: NSInteger!
    
    public init(accessKey: String,
         secretKey: String,
         sessionToken: String,
         endPoint: String,
         sourceBucket: String,
         mediaId: String,
         sourceKey: String,
         expiration: NSInteger) {
        self.accessKey = accessKey
        self.secretKey = secretKey
        self.sessionToken = sessionToken
        self.endPoint = endPoint
        self.sourceBucket = sourceBucket
        self.mediaId = mediaId
        self.sourceKey = BosUploadConfiguration.replaceSourceKey(sourceKey: sourceKey)
        self.expiration = expiration
    }
    
}

 class BosUploadConfiguration: NSObject {
    
    public let bceConfigs: BceConfigs!
    private let filePath: String!
    
    // MARK: - BOSClient
    private lazy var credentials: BCESTSCredentials = {
        let credentials: BCESTSCredentials = BCESTSCredentials()
        credentials.accessKey = self.bceConfigs.accessKey
        credentials.secretKey = self.bceConfigs.secretKey
        credentials.sessionToken = self.bceConfigs.sessionToken
        return credentials
    }()
    
    private lazy var configuration: BOSClientConfiguration = {
        let configuration: BOSClientConfiguration = BOSClientConfiguration()
        configuration.endpoint = self.bceConfigs.endPoint
        configuration.credentials = self.credentials
        // TODO 是否需要配置https?
        configuration.scheme = "https"
        // 设置HTTP最大连接数为5
        configuration.maxConurrentConnection = 5
        // 设置TCP连接超时未5秒
        configuration.connectionTimeout = 5
        //设置请求c最长传输数据时间为60秒
        configuration.totalTransferTimeout = 60
        //设置是否使用蜂窝网络
        configuration.allowsCellularAccess = true
        return configuration
    }()
    
     public lazy var client: BOSClient = {
        let client: BOSClient = BOSClient(configuration: self.configuration)
        return client
    }()
    
    
    // MARK: - object上传
     public lazy var content: BOSObjectContent = {
        let content: BOSObjectContent = BOSObjectContent()
        content.objectData.file = self.filePath
        return content
    }()
    
    // 最简单的上传 文件 or data
     public lazy var putObjectRequest: BOSPutObjectRequest = {
        let request: BOSPutObjectRequest = BOSPutObjectRequest()
        request.bucket = self.bceConfigs.sourceBucket
        request.key = self.bceConfigs.sourceKey
        request.objectContent = self.content
        return request
    }()
    
     public lazy var multipartRequest: BOSInitiateMultipartUploadRequest = {
        let initMPRequest: BOSInitiateMultipartUploadRequest = BOSInitiateMultipartUploadRequest()
        initMPRequest.bucket = self.bceConfigs.sourceBucket
        initMPRequest.key = self.bceConfigs.sourceKey
        
        // TODO: 需要contentType
        //        initMPRequest.contentType = self.bceConfigs.
        return initMPRequest
    }()
    
    
    static func replaceSourceKey(sourceKey: String) -> String {
        let sourceUUid = UUID().uuidString
        let timeStamp = Date().milliStamp
        return sourceKey.replacingOccurrences(of: "*", with: timeStamp + sourceUUid)
    }
    
    public init(bceConfigs: BceConfigs,
               filePath: String) {
        self.bceConfigs = bceConfigs
        self.filePath = filePath
    }
}

extension Date {
    
    /// 获取当前 秒级 时间戳 - 10位
    var timeStamp : String {
        let timeInterval: TimeInterval = self.timeIntervalSince1970
        let timeStamp = Int(timeInterval)
        return "\(timeStamp)"
    }
    
    /// 获取当前 毫秒级 时间戳 - 13位
    var milliStamp : String {
        let timeInterval: TimeInterval = self.timeIntervalSince1970
        let millisecond = CLongLong(round(timeInterval * 1000))
        return "\(millisecond)"
    }
}
