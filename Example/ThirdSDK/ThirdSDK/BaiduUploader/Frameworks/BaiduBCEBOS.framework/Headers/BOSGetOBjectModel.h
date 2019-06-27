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

#import <BaiduBCEBOS/BOSResponse.h>
#import <BaiduBCEBOS/BOSCommonModel.h>
#import <BaiduBCEBOS/BOSObjectRelatedModel.h>

/**
 *  @brief BOS get object request.
 */
@interface BOSGetObjectRequest : BOSObjectRelatedRequest

/**
 *  @brief Optional. The file path that object's content will store in.
 *         If this filed not set, the object's content will store in memory.
 */
@property(nonatomic, copy) NSString* file;

/**
 *  @brief Optional. Indicating the byte range's start offset.
 *         If this field not set, download start from the object beginning.
 *         The expected download lenth is (rangeEnd - rangeStart + 1).
 */
@property(nonatomic, copy) NSString* rangeStart;

/**
 *  @brief Optional. Indicating the byte range's end offset.
 *         If this field not set, download to the end of the object.
 *         The expected download lenth is (rangeEnd - rangeStart + 1).
 */
@property(nonatomic, copy) NSString* rangeEnd;

@end


/**
 *  @brief BOS get object response.
 */
@interface BOSGetObjectResponse : BOSResponse

/**
 *  @brief The object content.
 */
@property(nonatomic, strong) BOSObjectData* objectData;

/**
 *  @brief HTTP Headers
 */
@property(nonatomic, copy) NSString* cacheControl;
@property(nonatomic, copy) NSString* contentDisposition;
@property(nonatomic, copy) NSString* contentRange;
@property(nonatomic, copy) NSString* contentLength;
@property(nonatomic, copy) NSString* contentType;
@property(nonatomic, copy) NSString* contentMD5;
@property(nonatomic, copy) NSString* contentSha256;
@property(nonatomic, copy) NSString* contentCrc32;
@property(nonatomic, copy) NSString* eTag;
@property(nonatomic, copy) NSString* expires;
@property(nonatomic, copy) NSString* lastModified;
@property(nonatomic, copy) NSString* objectType;
@property(nonatomic, copy) NSString* storageClass;
@property(nonatomic, copy) NSString* offset;


/**
 *  @brief User metadata
 */
@property(nonatomic, strong) NSDictionary<NSString*, NSString*>* userMetadata;

@end
