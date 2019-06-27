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
#import <BaiduBCEBOS/BOSBucketRelatedModel.h>

/**
 *  @brief BOS list multipart uploads request.
 */
@interface BOSListMultipartUploadsRequest : BOSBucketRelatedRequest

/**
 *  @brief Optional. The parameter that causes multipart uploads for keys that contain
 *         the same string between the prefix and the first occurrence of the
 *         delimiter to be rolled up into a single result element. These rolled-up
 *         keys are not returned elsewhere in the response. The most commonly used
 *         delimiter is "/", which simulates a hierarchical organization similar to
 *         a file system directory structure.
 */
@property(nonatomic, copy) NSString* delimiter;

/**
 *  @brief Optional. The key marker indicating where in the results to begin listing.
 *
 *         Together with the upload ID marker, specifies the multipart upload after
 *         which listing should begin.
 *
 *         If the upload ID marker is not specified, only the keys lexicographically
 *         greater than the specified key-marker will be included in the list.
 *
 *         If the upload ID marker is specified, any multipart uploads for a key
 *         equal to the key-marker may also be included, provided those multipart
 *         uploads have upload IDs lexicographically greater than the specified
 *         marker.
 */
@property(nonatomic, copy) NSString* keyMarker;

/**
 *  @brief Optional. The parameter restricting the response to multipart uploads for keys
 *         which begin with the specified prefix. You can use prefixes to separate a
 *         bucket into different sets of keys in a way similar to how a file system
 *         uses folders.
 */
@property(nonatomic, copy) NSString* prefix;

/**
 *  @brief Optional. The maximum number of uploads to return.
 */
@property(nonatomic, assign) NSInteger maxUploads;

@end

/**
 *  @brief A multipart upload is an upload to Baidu BOS that is creating by uploading
 *         individual pieces of an object, then telling Baidu BOS to complete the
 *         multipart upload and concatenate all the individual pieces together into a
 *        single object.
 */
@interface BOSMultipartUpload : NSObject

/**
 *  @brief The key by which this upload is stored.
 */
@property(nonatomic, copy) NSString* key;

/**
 *  @brief The unique ID of this multipart upload.
 */
@property(nonatomic, copy) NSString* uploadId;

/**
 *  @brief The date at which this upload was initiated.
 */
@property(nonatomic, copy) NSString* initiated;

/**
 *  @brief The owner of this multipart upload.
 */
@property(nonatomic, strong) BOSBucketOwner* owner;

/**
 *  @brief The storage type of object, return STANDARD_IA 、COLD、STANDARD
 */
@property(nonatomic, copy) NSString* storageClass;

@end

/**
 *  @brief BOS list multipart uplaod response.
 */
@interface BOSListMultipartUploadsResponse : BOSResponse

/**
 *  @brief The name of the bucket containing the listed multipart uploads, as
 *         specified in the original request.
 */
@property(nonatomic, copy) NSString* bucket;

/**
 *  @brief Optional. The parameter that causes multipart uploads for keys that contain
 *         the same string between the prefix and the first occurrence of the
 *         delimiter to be rolled up into a single result element. These rolled-up
 *         keys are not returned elsewhere in the response. The most commonly used
 *         delimiter is "/", which simulates a hierarchical organization similar to
 *         a file system directory structure.
 */
@property(nonatomic, copy) NSString* delimiter;

/**
 *  @brief The optional prefix specified in the original request to limit the
 *         returned multipart uploads to those for keys that match this prefix.
 */
@property(nonatomic, copy) NSString* prefix;

/**
 *  @brief The optional key marker specified in the original request to specify
 *         where in the results to begin listing multipart uploads.
 */
@property(nonatomic, copy) NSString* keyMarker;

/**
 *  @brief If this listing is truncated, this is the next key marker that should be
 *         used in the next request to get the next page of results.
 */
@property(nonatomic, copy) NSString* nextKeyMarker;

/**
 *  @brief The optional maximum number of uploads to be listed, as specified in the
 *         original request.
 */
@property(nonatomic, assign) NSInteger maxUploads;

/**
 *  @brief Indicates if the listing is truncated, and additional requests need to be
 *         made to get more results.
 */
@property(nonatomic, assign) BOOL isTruncated;

/**
 *  @brief A list of the common prefixes included in this multipart upload listing - common
 *         prefixes will only be populated for requests that specified a delimiter, and indicate
 *         additional key prefixes that contain more multipart uploads that have not been included
 *         in this listing.
 */
@property(nonatomic, strong) NSArray<NSString*>* commonPrefixes;

/**
 *  @brief The list of multipart uploads.
 */
@property(nonatomic, strong) NSArray<BOSMultipartUpload*>* uploads;

@end
