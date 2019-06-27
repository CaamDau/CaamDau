//
//  BosUpload.swift
//  FittiMeExample
//
//  Created by guowei on 2019/4/24.
//  Copyright © 2019 Huami Inc. All rights reserved.
//

import BaiduBCEBasic
import BaiduBCEBOS
import BaiduBCESTS

public enum UploadType: String {
    case image = "IMAGE"
    case video = "VIDEO"
}

public typealias InnerClouse = (BCEOutput?) -> Void
public typealias RequestCallback = (_ error: Error?) -> Void

public class BosUpload: NSObject {
    
    ///上传
    public static func upload(with type: UploadType, bceConfigs: BceConfigs, filePath: String, callback: @escaping RequestCallback) {
        switch type {
        case .image:
            self.simpleUpload(with: bceConfigs, filePath: filePath, callback: callback)
        case .video:
            self.multipartUpload(with: bceConfigs, filePath: filePath, callback: callback)
        }
    }
    
    ///简单的文件上传
    public static func simpleUpload(with bceConfigs: BceConfigs, filePath: String, callback: @escaping RequestCallback) {
        let bosConfig = BosUploadConfiguration(bceConfigs: bceConfigs,
                                               filePath: filePath)
        let client = bosConfig.client
        let simpleRequest = bosConfig.putObjectRequest
        let task: BCETask = client.putObject(simpleRequest)
        var initResponse: BOSPutObjectResponse?
        let inner: InnerClouse = { (output: BCEOutput?) in
            guard let out = output else {
                return
            }
            if let response = out.response as? BOSPutObjectResponse {
                initResponse = response
                print("put object success!\(String(describing: initResponse))")
                callback(nil)
            }
            if let progress = out.progress {
                print("progress \(progress)")
            }
            if let error = out.error {
                print("put object error \(error)")
                callback(error)
            }
        }
        task.then()?(inner)
        task.waitUtilFinished()
    }
    
    ///分块上传
    public static func multipartUpload(with bceConfigs: BceConfigs, filePath: String, callback: @escaping RequestCallback) {
        let bosConfig = BosUploadConfiguration(bceConfigs: bceConfigs,
                                               filePath: filePath)
        var task: BCETask = bosConfig.client.initiateMultipartUpload(bosConfig.multipartRequest)
        var initResponse: BOSInitiateMultipartUploadResponse?
        let inner: InnerClouse = { (output: BCEOutput?) in
            guard let out = output else {
                return
            }
            if let response = out.response as? BOSInitiateMultipartUploadResponse {
                initResponse = response
                print("initiate multipart upload success!\(String(describing: initResponse))")
            }
            if let error = out.error {
                print("initiate multipart upload error \(error)")
                callback(error)
            }
        }
        task.then()?(inner)
        task.waitUtilFinished()
        
        guard let response = initResponse else {
            return
        }
        ///初始化分块
        let uploadID: String = response.uploadId
        var fileSize: UInt64
        //分块的大小
        let partSize: UInt64 = 1024 * 1204 * 5
        var partCount: UInt64
        //计算分块个数
        do {
            let attr = try FileManager.default.attributesOfItem(atPath: filePath)
            fileSize = attr[FileAttributeKey.size] as? UInt64 ?? 0
            partCount = fileSize / partSize
            if fileSize % partSize != 0 {
                partCount += 1
            }
        } catch let error {
            print("获取文件路径错误, \(error)")
            callback(error)
            return
        }
        var parts: [BOSPart] = []
        
        let handle: FileHandle? = FileHandle.init(forReadingAtPath: filePath)
        guard let handleFile = handle else {
            print("fileHandle nil")
            callback(NSError(domain: "fileHandle nil", code: 1000, userInfo: nil))
            return
        }
        for i: UInt64 in 0..<partCount {
            //seek
            let skip: UInt64 = partSize * i
            handleFile.seek(toFileOffset: skip)
            let size: UInt64 = (partSize < fileSize - skip) ? partSize : fileSize - skip
            
            //data
            let data: Data = handleFile.readData(ofLength: Int(size))
            
            //request
            let uploadPartRequest: BOSUploadPartRequest = BOSUploadPartRequest()
            uploadPartRequest.bucket = bosConfig.bceConfigs.sourceBucket
            uploadPartRequest.key = bosConfig.bceConfigs.sourceKey
            uploadPartRequest.objectData.data = data
            uploadPartRequest.partNumber = UInt(i + 1)
            uploadPartRequest.uploadId = uploadID
            task = bosConfig.client.uploadPart(uploadPartRequest)
            var uploadPartResponse: BOSUploadPartResponse?
            let innerPart: InnerClouse = { (output: BCEOutput?) in
                guard let out = output else {
                    return
                }
                if let response = out.response as? BOSUploadPartResponse {
                    uploadPartResponse = response
                    let part: BOSPart = BOSPart()
                    part.partNumber = Int(i + 1)
                    part.eTag = uploadPartResponse?.eTag
                    parts.append(part)
                    print("uploadPart upload success!\(String(describing: uploadPartResponse))")
                }
            }
            task.then()?(innerPart)
            task.waitUtilFinished()
        }
        
        //完成
        let compMultipartRequest: BOSCompleteMultipartUploadRequest = BOSCompleteMultipartUploadRequest()
        compMultipartRequest.bucket = bosConfig.bceConfigs.sourceBucket
        compMultipartRequest.key = bosConfig.bceConfigs.sourceKey
        compMultipartRequest.uploadId = uploadID
        compMultipartRequest.parts = parts
        task = bosConfig.client.completeMultipartUpload(compMultipartRequest)
        var complResponse: BOSCompleteMultipartUploadResponse?
        let innerC: InnerClouse = { (output: BCEOutput?) in
            guard let out = output else {
                return
            }
            if let response = out.response as? BOSCompleteMultipartUploadResponse {
                complResponse = response
                print("complte multiparts success!\(String(describing: complResponse))")
                callback(nil)
            }
            if let error = out.error {
                print("complte multiparts error \(error)")
                callback(error)
            }
        }
        task.then()?(innerC)
        task.waitUtilFinished()
    }
}
