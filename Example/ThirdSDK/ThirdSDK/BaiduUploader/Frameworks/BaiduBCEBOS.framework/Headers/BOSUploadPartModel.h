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
 *  @brief BOS upload part request.
 */
@interface BOSUploadPartRequest : BOSMultipartRelatedRequest

/**
 *  @brief Required. The part number describing this part's position relative to the other
 *         parts in the multipart upload. Part number must be between 1 and 10,000 (inclusive).
 */
@property(nonatomic, assign) NSUInteger partNumber;

/**
 *  @brief Required. The content of the part.
 */
@property(nonatomic, strong) BOSObjectData* objectData;

@end

/**
 *  @brief BOS upload part response.
 */
@interface BOSUploadPartResponse : BOSResponse

/**
 *  @brief The entity tag generated from the content of the upload part.
 */
@property(nonatomic, copy) NSString* eTag;

@end

