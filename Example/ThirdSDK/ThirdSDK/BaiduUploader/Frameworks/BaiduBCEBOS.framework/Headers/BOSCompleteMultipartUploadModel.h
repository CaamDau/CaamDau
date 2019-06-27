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
#import <BaiduBCEBOS/BOSMultipartRelatedModel.h>

/**
 *  @brief BOS complete multipart upload request.
 */
@interface BOSCompleteMultipartUploadRequest : BOSMultipartRelatedRequest

/**
 *  @brief Required. The list of part numbers and ETags to use when completing the multipart upload.
 */
@property(nonatomic, strong) NSArray<BOSPart*>* parts;

/**
 *  @brief Optional. Additional information about the new object being created, such as content type,
 *         content encoding, user metadata, etc.
 *
 */
@property(nonatomic, strong) NSDictionary<NSString*, NSString*>* userMetadata;

@end

/**
 *  @brief BOS complete multipart upload response.
 */
@interface BOSCompleteMultipartUploadResponse : BOSResponse

/**
 *  @brief The name of the bucket in which the new multipart upload was initiated.
 */
@property(nonatomic, copy) NSString* bucket;

/**
 *  @brief The object key for which the multipart upload was initiated.
 */
@property(nonatomic, copy) NSString* key;

/**
 *  @brief The object url.
 */
@property(nonatomic, copy) NSString* location;

/**
 *  @brief The unique ID of the new multipart upload.
 */
@property(nonatomic, copy) NSString* eTag;

@end
