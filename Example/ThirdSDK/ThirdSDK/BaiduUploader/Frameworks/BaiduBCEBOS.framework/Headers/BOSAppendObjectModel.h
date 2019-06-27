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
 *  @brief BOS append object request.
 *         if the object not exist on the BOS, will create an appendable object.
 *         else the object will be override.
 *         
 *         Create a empty appendable object is allowed.
 */
@interface BOSAppendObjectRequest : BOSObjectRelatedRequest

/**
 *  @brief The storage type of object, return STANDARD_IA 、COLD、STANDARD
 */
@property(nonatomic, copy) NSString* storageClass;

/**
 *  @brief The append offset to the object that already stored on the BOS.
 */
@property(nonatomic, copy) NSString* offset;

/**
 *  @brief The upload object content.
 */
@property(nonatomic, strong) BOSObjectContent* objectContent;

@end

/**
 *  @brief BOS append object response.
 */
@interface BOSAppendObjectResponse : BOSResponse

/**
 *  @brief Next append offset.
 */
@property(nonatomic, copy) NSString* offset;

@end
