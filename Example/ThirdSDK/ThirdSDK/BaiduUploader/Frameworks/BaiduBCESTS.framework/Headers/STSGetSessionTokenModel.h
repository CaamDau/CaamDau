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

#import <BaiduBCEBasic/BCERequest.h>
#import <BaiduBCEBasic/BCEResponse.h>
#import <BaiduBCEBasic/BCESTSCredentials.h>

/**
 *  @brief Effect Allow. Could assign to STSACLElement's effect field.
 */
extern NSString* const kSTSEffectAllow;

/**
 *  @brief Effect Deny. Could assign to STSACLElement's effect field.
 */
extern NSString* const kSTSEffectDeny;

/**
 *  @brief Permission Read. Could add to STSACLElement's permission array.
 */
extern NSString* const kSTSPermissionRead;

/**
 *  @brief Permission Write. Could add to STSACLElement's permission array.
 */
extern NSString* const kSTSPermissionWrite;

/**
 *  @brief Permission List. Could add to STSACLElement's permission array.
 */
extern NSString* const kSTSPermissionList;

/**
 *  @brief Permission GetObject. Could add to STSACLElement's permission array.
 */
extern NSString* const kSTSPermissionGetObject;

/**
 *  @brief Access Control List Element for Baidu Security Token Service.
 */
@interface STSACLElement : NSObject

/**
 *  @brief Access Control List Element ID.
 *         Optional.
 */
@property(nonatomic, copy) NSString* eid;

/**
 *  @brief The name of the BCE service will be effect.
 *         Required.
 */
@property(nonatomic, copy) NSString* service;

/**
 *  @brief The region of the BCE service will be effect.
 *         Required.
 */
@property(nonatomic, copy) NSString* region;

/**
 *  @brief Effect. could be kSTSEffectAllow or kSTSEffectDeny.
 *         Required.
 */
@property(nonatomic, copy) NSString* effect;

/**
 *  @brief The resources. Support wildcards.
 *         Required.
 */
@property(nonatomic, strong) NSArray<NSString*>* resources;

/**
 *  @brief The permissions. BCE servcies may support different permissions.
 *         Required.
 */
@property(nonatomic, strong) NSArray<NSString*>* permission;

@end

/**
 *  @brief Access Control List class for Baidu Security Token Service.
 */
@interface STSACL : NSObject

/**
 *  @brief Access Control List ID.
 *         Optional.
 */
@property(nonatomic, copy) NSString* aclID;

/**
 *  @brief Access Control List Elements.
 */
@property(nonatomic, strong) NSArray<STSACLElement*>* aclElements;

@end

/**
 *  @brief Security Token Request.
 */
@interface STSGetSessionTokenRequest : BCERequest
/**
 *  @brief Expire time interval in seconds. max value is 129600(32 hours).
 */
@property(nonatomic, assign) NSUInteger durationSeconds;

/**
 *  @brief Access Control List.
 */
@property(nonatomic, strong) STSACL* acl;

@end

/**
 *  @brief Security Token Response.
 */
@interface STSGetSessionTokenResponse : BCEResponse

/**
 *  @brief Security Token credentials. Used to access other BCE services.
 */
@property(nonatomic, strong) BCESTSCredentials* credentials;

@end
