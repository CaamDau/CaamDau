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
 *  @brief BOS get bcket cors request.
 */
@interface BOSGetBucketCorsRequest : BOSBucketRelatedRequest
@end

/**
 *  @brief BOS get bucket cors response.
 */
@interface BOSGetBucketCorsResponse : BOSResponse

/**
 *  @brief The configuration rules of the cors on the bucket.
 */
@property(nonatomic, strong) NSArray<BOSCorsConfiguration*>* configurations;

@end