/*
 * Copyright (c) 2016 Baidu.com, Inc. All Rights Reserved
 *
 * Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with
 * the License. You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on
 * an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the
 * specific language governing permissions and limitations under the License.
 */

#import <BaiduBCEBasic/BCEClient.h>
#import <BaiduBCEBOS/BOSClientConfiguration.h>

@class BCETask;
@class BOSListObjectsRequest;
@class BOSPutBucketAclRequest;
@class BOSPutObjectRequest;
@class BOSCopyObjectRequest;
@class BOSGetObjectRequest;
@class BOSAppendObjectRequest;
@class BOSInitiateMultipartUploadRequest;
@class BOSUploadPartRequest;
@class BOSListPartsRequest;
@class BOSCompleteMultipartUploadRequest;
@class BOSAbortMultipartUploadRequest;
@class BOSListMultipartUploadsRequest;
@class BOSDeleteMultipleObjectsRequest;
@class BOSPutBucketCorsRequest;
@class BOSOptionsObjectCorsRequest;
@class BCEOutput;

/**
 *  @brief Provides the client for accessing the Baidu Object Storage Service.
 *         usage:
 *               BOSClientConfiguration* configuration = [[BOSClientConfiguration alloc] init];
 *               configuration.credentials = [[BCECredentials alloc] init];
 *               configuration.credentials.accessKey = @"access key";
 *               configuration.credentials.secretKey = @"secret key";
 *
 *               BOSClient* client = [[BOSClient alloc] initWithConfiguration:configuration];
 *
 *               // do some request.
 *               // ...
 *
 *               [client shutdown];
 */
@interface BOSClient : BCEClient

/**
 *  @brief Constructs a new BOS client using the client configuration to access BOS.
 *  @param configuration The BOS client configuration.
 *  @return Client object.
 */
- (instancetype)initWithConfiguration:(BOSClientConfiguration*)configuration;

/**
 *  @brief Gets the Location for the specified BOS bucket.
 *  @param bucket Bucket name.
 *  @return Task.
 */
- (BCETask*)getBucketLocation:(NSString*)bucket;

/**
 *  @brief List BOS buckets that the authenticated sender of the request owns.
 *  @return Task.
 */
- (BCETask*)listBuckets;

/**
 *  @brief Creates a new BOS bucket with the specified name.
 *  @param bucket Bucket name.
 *  @return Task.
 */
- (BCETask*)putBucket:(NSString*)bucket;

/**
 *  @brief Get a list that contains all object summary information belongs to specified bucket.
 *  @param request Request.
 *  @return Task.
 */
- (BCETask*)listObjects:(BOSListObjectsRequest*)request;

/**
 *  @brief Checks if the specified bucket exists, and requester have permission to access the bucket.
 *  @param bucket Bucket name.
 *  @return Task.
 */
- (BCETask*)headBucket:(NSString*)bucket;

/**
 *  @brief Deletes the specified bucket. 
 *         All objects in the bucket must be deleted before the bucket itself.
 * can be deleted.
 *  @param bucket Bucket name.
 *  @return Task.
 */
- (BCETask*)deleteBucket:(NSString*)bucket;

/**
 *  @brief Sets the Acl for the specified BOS bucket.
 *  @param request Request.
 *  @return Task.
 */
- (BCETask*)putBucketACL:(BOSPutBucketAclRequest*)request;

/**
 *  @brief Gets the ACL for the specified BOS bucket.
 *  @param bucket Bucket name.
 *  @return Task.
 */
- (BCETask*)getBucketACL:(NSString*)bucket;

/**
 *  @brief Uploads a new object to the specified BOS bucket.
 *  @param request Request.
 *  @return Task.
 */
- (BCETask*)putObject:(BOSPutObjectRequest*)request;

/**
 *  @brief Copies a source object to a new destination in BOS.
 *  @param request Request.
 *  @return Task.
 */
- (BCETask*)copyObject:(BOSCopyObjectRequest*)request;

/**
 *  @brief Gets the object metadata for the object stored in BOS under the specified bucket and key.
 &         And saves the object contents to the specified file or memory.
 *  @param request Request.
 *  @return Task.
 */
- (BCETask*)getObject:(BOSGetObjectRequest*)request;

/**
 *  @brief Gets the metadata for the specified BOS object without actually fetching the object itself.
 *  @param bucket Bucket name.
 *  @param key    Object name.
 *  @return Task.
 */
- (BCETask*)getObjectMetadata:(NSString*)bucket objectKey:(NSString*)key;

/**
 *  @brief Append contents to the specified object in the specified bucket.
 *  @param request Request.
 *  @return Task.
 */
- (BCETask*)appendObject:(BOSAppendObjectRequest*)request;

/**
 *  @brief Deletes the specified object in the specified bucket.
 *  @param bucket Bucket name.
 *  @param key    Object name.
 *  @return Task.
 */
- (BCETask*)deleteObject:(NSString*)bucket objectKey:(NSString*)key;

/**
 *  @brief Delete multi objects one time.
 *  @param request Request.
 *  @return Task.
 */
- (BCETask*)deleteMultipleObjects:(BOSDeleteMultipleObjectsRequest*)request;

/**
 *  @brief Initiates a multipart upload.
 *         If the task is fullfilled. An upload ID will be found in the response.
 *         You can use the upload ID to upload part, list part, complete, abort multipart upload.
 *  @param request Request.
 *  @return Task.
 */
- (BCETask*)initiateMultipartUpload:(BOSInitiateMultipartUploadRequest*)request;

/**
 *  @brief Uploads a part in a multipart upload.
 *         You must initiate a multipart upload before you can upload any part.
 *  @param request Request.
 *  @return Task.
 */
- (BCETask*)uploadPart:(BOSUploadPartRequest*)request;

/**
 *  @brief Lists the parts that have been uploaded for a specific multipart upload.
 *  @param request Request.
 *  @return Task.
 */
- (BCETask*)listParts:(BOSListPartsRequest*)request;

/**
 *  @brief Completes a multipart upload by assembling previously uploaded parts.
 *  @param request Request.
 *  @return Task.
 */
- (BCETask*)completeMultipartUpload:(BOSCompleteMultipartUploadRequest*)request;

/**
 *  @brief Aborts a multipart upload. After a multipart upload is aborted, no
 *         additional parts can be uploaded using that upload ID. The storage
 *         consumed by any previously uploaded parts will be freed. However, if any
 *         part uploads are currently in progress, those part uploads may or may not
 *         succeed. As a result, it may be necessary to abort a given multipart
 *         upload multiple times in order to completely free all storage consumed by
 *         all parts.
 *  @param request Request.
 *  @return Task.
 */
- (BCETask*)abortMultipartUpload:(BOSAbortMultipartUploadRequest*)request;

/**
 *  @brief Lists in-progress multipart uploads. An in-progress multipart upload is a 
 *         multipart upload that has been initiated, using the InitiateMultipartUpload 
 *         request, but has not yet been completed or aborted.
 *  @param request Request.
 *  @return Task.
 */
- (BCETask*)listMultipartUploads:(BOSListMultipartUploadsRequest*)request;

/**
 *  @brief Set a new CORS rule to the specific bucket.
 *         If the bucket already have a CORS rule, it will be override.
 *  @param request Request.
 *  @return Task.
 */
- (BCETask*)putBucketCors:(BOSPutBucketCorsRequest*)request;

/**
 *  @brief Get the CORS rule of the specific bucket.
 *  @param bucket Bucket name.
 *  @return Task.
 */
- (BCETask*)getBucketCors:(NSString*)bucket;

/**
 *  @brief Delete the specific bucket's CORS rule.
 *  @param bucket Bucket name.
 *  @return Task.
 */
- (BCETask*)deleteBucketCors:(NSString*)bucket;

/**
 *  @brief Get object cors options.
 *  @param request Request.
 *  @return Task.
 */
- (BCETask*)optionsObjectCors:(BOSOptionsObjectCorsRequest*)request;

/**
 *  @brief Generate pre-signed URL.
 *  @param bucket Bucket name.
 *  @param key    Object name.
 *  @return Output.
 */
- (BCEOutput*)generatePresignedUrl:(NSString*)bucket objectKey:(NSString*)key;

/**
 *  @brief Generate pre-signed URL.
 *  @param bucket Bucket name.
 *  @param key    Object name.
 *  @param expirationInSecond expire time.
 *  @return Output.
 */
- (BCEOutput*)generatePresignedUrl:(NSString*)bucket objectKey:(NSString*)key expirationInSeconds:(NSInteger )expirationInSeconds;

@end
