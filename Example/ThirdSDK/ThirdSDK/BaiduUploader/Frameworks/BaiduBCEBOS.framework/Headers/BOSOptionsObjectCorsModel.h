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
 *  @brief BOS option object cors request.
 */
@interface BOSOptionsObjectCorsRequest : BOSObjectRelatedRequest

/**
 *  @brief Required. The cors request origin.
 */
@property(nonatomic, copy) NSString* origin;

/**
 *  @brief Required. The cors request method.
 */
@property(nonatomic, copy) NSString* method;

/**
 *  @brief Optional. The custom headers in the cors request.
 */
@property(nonatomic, copy) NSString* headers;

@end

/**
 *  @brief BOS option object cors response.
 */
@interface BOSOptionsObjectCorsResponse : BOSResponse

/**
 *  @brief Whether allow cors request with cookie. If allow. the value is 'true'.
 */
@property(nonatomic, copy) NSString* allowCredentials;

/**
 *  @brief The origin of the cors request. this field may not be present.
 */
@property(nonatomic, copy) NSString* allowedOrigin;

/**
 *  @brief The allowed methods of the cors request. this field may not be present.
 */
@property(nonatomic, copy) NSString* allowedMethods;

/**
 *  @brief The allowed headers of the cors request. this field may not be present.
 */
@property(nonatomic, copy) NSString* allowedHeaders;

/**
 *  @brief The allowed expose headers of the cors request. this field may not be present.
 */
@property(nonatomic, copy) NSString* allowedExposeHeaders;

/**
 *  @brief The max age that the brower to cache the preflight result.
 */
@property(nonatomic, assign) int64_t maxAgeSeconds;

@end
