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
#import <BaiduBCEBOS/BOSObjectRelatedModel.h>

/**
 *  @brief Copy object's metadata. can set to BOSCopyObjectRequest's metadataDirective field.
 */
extern NSString* const kObjectMetadataCopy;

/**
 *  @brief Replace object's metadata. can set to BOSCopyObjectRequest's metadataDirective field.
 */
extern NSString* const kObjectMetadataReplace;

/**
 *  @brief BOS copy object request.
 */
@interface BOSCopyObjectRequest : BOSObjectRelatedRequest

/**
 *  @brief Required. The souce object name. Format: /bucket/object.
 */
@property(nonatomic, copy) NSString* source;

/**
 *  @brief Optional. If the source object's eTag match this field. Do copy action.
 */
@property(nonatomic, copy) NSString* ifMatchEtag;

/**
 *  @brief Optional. If the source object's eTag do not match this field. Do copy action.
 */
@property(nonatomic, copy) NSString* ifNotMatchEtag;

/**
 *  @brief Optional. If the source object is modified sine this field. Do copy action.
 *         Must be a RFC822 date string.
 */
@property(nonatomic, copy) NSString* ifModifiedSince;

/**
 *  @brief Optional. If the source object is not modified sine this field. Do copy action.
 *         Must be a RFC822 date string.
 */
@property(nonatomic, copy) NSString* ifUnmodifiedSince;

/**
 *  @brief Optional. How to set the copied object's metadata.
 *         Could be kObjectMetadataCopy or kObjectMetadataReplace.
 */
@property(nonatomic, copy) NSString* metadataDirective;

/**
 *  @brief The storage type of object, return STANDARD_IA 、COLD、STANDARD
 */
@property(nonatomic, copy) NSString* storageClass;

/**
 *  @brief Optional. When metadataDirective set to kObjectMetadataReplace.
 */
@property(nonatomic, strong) NSDictionary<NSString*, NSString*>* metadata;

@end

/**
 *  @brief BOS copy object response.
 */
@interface BOSCopyObjectResponse : BOSResponse

/**
 *  @brief The copied object's eTag.
 */
@property(nonatomic, copy) NSString* eTag;

/**
 *  @brief The copied object's last modified date.
 */
@property(nonatomic, copy) NSString* lastModified;

@end
