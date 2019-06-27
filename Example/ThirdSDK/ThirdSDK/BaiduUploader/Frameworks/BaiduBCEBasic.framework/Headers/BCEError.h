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
 *  @brief Error class for Baidu BCE SDK.
 */
@interface BCEError : NSError

/**
 *  @brief Constructs a new error from the json dictionary.
 *  @param json The json dictionary.
 *  @return The constructed error.
 */
+ (instancetype)errorWithBCEJson:(NSDictionary*)json;

/**
 *  @brief Constructs a new error from a Cocoa error.
 *  @param error The Cocoa error.
 *  @return The constructed error.
 */
+ (instancetype)errorWithNSError:(NSError*)error;

/**
 *  @brief If the error is constructed from the HTTP response, the request ID will be valid.
 *         User can send this field to Baidu BCE technical support for quickly problem solving.
 */
@property(nonatomic, copy) NSString* requestId;

@end
