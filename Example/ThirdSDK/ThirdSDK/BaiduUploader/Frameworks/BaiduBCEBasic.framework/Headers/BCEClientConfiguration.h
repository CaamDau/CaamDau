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

@class BCERegion, BCECredentials, BCERetryPolicy;

/**
 *  @brief Basic client configurations for BCE clients.
 */
@interface BCEClientConfiguration : NSObject

/**
 *  @brief The Authentication protocol version, default value is 1.
 */
@property(nonatomic, assign) NSInteger authVersion;

/**
 *  @brief The BCE credentials used by the client to sign HTTP requests.
 */
@property(nonatomic, strong) BCECredentials* credentials;

/**
 *  @brief The service endpoint URL to which the client will connect.
 */
@property(nonatomic, strong) NSString* endpoint;

/**
 *  @brief The service API version. Default value is 1.
 */
@property(nonatomic, assign) NSInteger APIVersion;

/**
 *  @brief The schema which the HTTP requests use. Could be 'http' or 'https'. Affect the calculation of endpoint.
 */
@property(nonatomic, copy) NSString* scheme;

/**
 *  @brief The service name in lower case. Affect the calculation of endpoint.
 */
@property(nonatomic, copy) NSString* service;

/**
 *  @brief Set to YES if the service support region. Default valus is NO. Affect the calculation of endpoint.
 */
@property(nonatomic, assign) BOOL supportRegion;

/**
 *  @brief The region which the sevice will connnect to. If supportRegion is YES，affect the calculation of endpoint.
 */
@property(nonatomic, strong) BCERegion* region;

/**
 *  @brief Whether to use HTTP proxy server. Default value is NO.
 */
@property(nonatomic, assign) BOOL useProxy;

/**
 *  @brief The Http proxy host.
 */
@property(nonatomic, copy) NSString* proxyHost;

/**
 *  @brief The Http proxy port.
 */
@property(nonatomic, copy) NSString* proxyPort;

/**
 *  @brief The usernmae which used to authentication the HTTP proxy.
 */
@property(nonatomic, copy) NSString* proxyUsername;

/**
 *  @brief The password which used to authentication the HTTP proxy.
 */
@property(nonatomic, copy) NSString* proxyPassword;

/**
 *  @brief Whether to use device's cellular network. Default value is NO.
 */
@property(nonatomic, assign) BOOL allowsCellularAccess;

/**
 *  @brief The connect timeout of the HTTP request. Default value is 60s.
 */
@property(nonatomic) NSTimeInterval connectionTimeout;

/**
 *  @brief The transfer timeout of the HTTP request. Default value is 7days = (3600 * 24 * 7)s.
 */
@property(nonatomic) NSTimeInterval totalTransferTimeout;

/**
 *  @brief The max HTTP request concurrent number. Default valus is 4.
 */
@property(nonatomic) NSUInteger maxConurrentConnection;

/**
 *  @brief The user agent of the HTTP request.
 */
@property(nonatomic, copy, readonly) NSString* userAgent;

/**
 *  @brief The retry policy of the HTTP request.
 */
@property(nonatomic, strong) BCERetryPolicy* retryPolicy;

/**
 *  @brief The sdk version of this client.
 */
@property(nonatomic, strong, readonly) NSString* SDKVersion;


@end
