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

#import <BaiduBCEBasic/BCECredentials.h>

/**
 *  @brief Provides access to the BCE credentials used for accessing BCE services: BCE access key ID,  
 *         secret access key and session token. 
 *         These credentials are used to securely sign requests to BCE services.
 */
@interface BCESTSCredentials : BCECredentials

/**
 *  @brief The session token for this credentials object.
 */
@property(nonatomic, copy) NSString* sessionToken;

/**
 *  @brief The expiration time for this credentials object.
 */
@property(nonatomic, copy) NSString* expiration;

/**
 *  @brief The user ID for this credentials object.
 */
@property(nonatomic, copy) NSString* userId;

@end
