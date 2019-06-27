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

#import <Foundation/Foundation.h>

/**
 *  @brief The common metadata contain in the HTTP response.
 */
@interface BCEResponseMetadata : NSObject

/**
 *  @brief Identification of the HTTP request.
 */
@property(nonatomic, copy) NSString* requestID;

/**
 *  @brief Identification of the HTTP request and response pair.
 */
@property(nonatomic, copy) NSString* debugID;

/**
 *  @brief Which service.
 */
@property(nonatomic, copy) NSString* server;

// The values of HTTP header.
@property(nonatomic, copy) NSString* contentLength;
@property(nonatomic, copy) NSString* contentType;
@property(nonatomic, copy) NSString* connection;
@property(nonatomic, copy) NSString* contentMD5;
@property(nonatomic, copy) NSString* contentSha256;
@property(nonatomic, copy) NSString* contentCrc32;
@property(nonatomic, copy) NSString* date;
@property(nonatomic, copy) NSString* eTag;

@end
