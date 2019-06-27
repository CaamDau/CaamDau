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

#import <BaiduBCEBOS/BOSBucketRelatedModel.h>
#import <BaiduBCEBOS/BOSCommonModel.h>
#import <BaiduBCEBOS/BOSResponse.h>

/**
 *  @brief BOS list objects request.
 */
@interface BOSListObjectsRequest : BOSBucketRelatedRequest

/**
 * @brief Optional parameter that causes keys that contain the same string between
 *        the prefix and the first occurrence of the delimiter to be rolled up into
 *        a single result element. These rolled-up keys are not returned elsewhere 
 *        in the response. The most commonly used delimiter is "/", which simulates
 *        a hierarchical organization similar to a file system directory structure.
 */
@property(nonatomic, copy) NSString* delimiter;

/**
 * @brief Optional parameter indicating where in the bucket to begin listing. The
 *        list will only include keys that occur lexicographically after the marker.
 */
@property(nonatomic, copy) NSString* marker;

/**
 * @brief Optional parameter indicating the maximum number of keys to include in
 *        the response. Baidu BOS might return fewer than this, but will not return
 *        more. Even if maxKeys is not specified, Baidu BOS will limit the number
 *        of results in the response.
 */
@property(nonatomic, assign) NSUInteger maxKeys;

/**
 * @brief Optional parameter restricting the response to keys which begin with the
 *        specified prefix. You can use prefixes to separate a bucket into different 
 *        sets of keys in a way similar to how a file system uses folders.
 */
@property(nonatomic, copy) NSString* prefix;

@end

/**
 *  @brief BOS object infomation.
 */
@interface BOSObjectInfo : NSObject

/**
 *  @brief BOS object name.
 */
@property(nonatomic, copy) NSString* key;

/**
 *  @brief Last modified date of the object.
 */
@property(nonatomic, copy) NSString* lastModified;

/**
 *  @brief Etag of the object.
 */
@property(nonatomic, copy) NSString* eTag;

/**
 *  @brief Size of the object.
 */
@property(nonatomic, assign) uint64_t size;

/**
 *  @brief Owner of the object.
 */
@property(nonatomic, strong) BOSBucketOwner* owner;

/**
  *  @brief The storage type of object, return STANDARD_IA 、COLD、STANDARD
*/
@property(nonatomic, copy) NSString* storageClass;

@end

/**
 *  @brief BOS list objects response.
 */
@interface BOSListObjectsResponse : BOSResponse

/**
 *  @brief The name of the Baidu BOS bucket containing the listed objects.
 */
@property(nonatomic, copy) NSString* name;

/**
 *  @brief The prefix parameter originally specified by the caller when this object listing was returned.
 */
@property(nonatomic, copy) NSString* prefix;

/**
 *  @brief The delimiter parameter originally specified by the caller when this object listing was returned.
 */
@property(nonatomic, copy) NSString* delimiter;

/**
 *  @brief The marker parameter originally specified by the caller when this object listing was returned.
 */
@property(nonatomic, copy) NSString* marker;

/**
 *  @brief The maxKeys parameter originally specified by the caller when this object listing was returned.
 */
@property(nonatomic, assign) NSUInteger maxKeys;

/**
 * @brief Indicates if this is a complete listing, or if the caller needs to make
 *        additional requests to Baidu BOS to see the full object listing for an BOS bucket.
 */
@property(nonatomic, assign) BOOL isTruncated;

/**
 * @brief The marker to use in order to request the next page of results - only populated 
 *        if the isTruncated member indicates that this object listing is truncated.
 */
@property(nonatomic, copy) NSString* nextMarker;

/**
 *  @brief A list of summary information describing the objects stored in the bucket.
 */
@property(nonatomic, strong) NSArray<BOSObjectInfo*>* contents;

/**
 * @brief A list of the common prefixes included in this object listing - common
 *        prefixes will only be populated for requests that specified a delimiter.
 */
@property(nonatomic, strong) NSArray<NSString*>* commonPrefixes;

@end
