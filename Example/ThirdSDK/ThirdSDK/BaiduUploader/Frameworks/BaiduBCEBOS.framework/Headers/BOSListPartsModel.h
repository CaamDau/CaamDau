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
 *  @brief BOS list parts request.
 */
@interface BOSListPartsRequest : BOSMultipartRelatedRequest

/**
 *  @brief Optional. The maximum number of parts to be returned in the part listing.
 */
@property(nonatomic, assign) NSUInteger maxParts;

/**
 *  @brief Optional. The part number marker indicating where in the results to being listing parts.
 */
@property(nonatomic, assign) NSUInteger partNumberMarker;

@end

/**
 *  @brief BOS list parts response.
 */
@interface BOSListPartsResponse : BOSResponse

/**
 *  @brief The name of the bucket containing the listed parts, as specified in the
 *         original request.
 */
@property(nonatomic, copy) NSString* bucket;

/**
 *  @brief The key value specified in the original request used to identify which
 *         multipart upload contains the parts to list.
 */
@property(nonatomic, copy) NSString* key;

/**
 *  @brief The upload ID value specified in the original request used to identify
 *         which multipart upload contains the parts to list.
 */
@property(nonatomic, copy) NSString* uploadId;

/**
 *  @brief The initiated time of the associated multipart upload.
 */
@property(nonatomic, copy) NSString* initiated;

/**
 *  @brief The user who owns the associated multipart upload.
 */
@property(nonatomic, strong) BOSBucketOwner* owner;

/**
 *  @brief The storage type of object, return STANDARD_IA 、COLD、STANDARD
 */
@property(nonatomic, copy) NSString* storageClass;

/**
 *  @brief The optional part number marker specified in the original request to
 *         specify where in the results to begin listing parts.
 */
@property(nonatomic, copy) NSString* partNumberMarker;

/**
 *  @brief If this listing is truncated, this is the part number marker that should
 *         be used in the next request to get the next page of results.
 */
@property(nonatomic, copy) NSString* nextPartNumberMarker;

/**
 *  @brief The optional max parts value specified in the original request to limit
 *         how many parts are listed.
 */
@property(nonatomic, copy) NSString* maxParts;

/**
 *  @brief Indicates if the listing is truncated, and additional requests need to be
 *         made to get more results.
 */
@property(nonatomic, copy) NSString* isTruncated;

/**
 *  @brief The list of parts described in this part listing.
 */
@property(nonatomic, strong) NSArray<BOSPart*>* parts;

@end
