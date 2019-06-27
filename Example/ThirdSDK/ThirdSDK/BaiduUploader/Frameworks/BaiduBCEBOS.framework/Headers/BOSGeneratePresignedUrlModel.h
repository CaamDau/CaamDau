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

@interface BOSGeneratePresignedUrlRequest : BOSObjectRelatedRequest

/**
 * @brief Optional.Expiration after which point the generated pre-signed URL
 *          will no longer be accepted by BOS. If not specified, a default
 *          value will be supplied.
 */
@property(nonatomic, assign) NSInteger expirationInSeconds;

@end

/**
 *  @brief BOS generated pre-signed URL response.
 */
@interface BOSGeneratePresignedUrlResponse : BOSResponse

@property(nonatomic, copy) NSURL* objectUrl;

@end
