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

#import <BaiduBCEBasic/BCEClient.h>

@class STSClientConfiguration;
@class BCETask;
@class STSGetSessionTokenRequest;


/**
 *  @brief Provides the client for accessing the Baidu Security Token Service.
 */
@interface STSClient : BCEClient

/**
 *  @brief Constructs a new client using the client configuration.
 *  @param configuration The client configuration.
 *  @return Client object.
 */
- (instancetype)initWithConfiguration:(STSClientConfiguration*)configuration;

/**
 *  @brief Get a set of temporary security credentials representing your account.
 *  @param request The request.
 *  @return Task of the get session token request.
 */
- (BCETask*)getSessionToken:(STSGetSessionTokenRequest*)request;

@end
