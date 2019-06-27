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
 *  @brief Private permission. Can assign to BOSPutBucketAclRequest's cannedAcl field.
 */
extern NSString* const BOS_ACL_PRIVATE;

/**
 *  @brief Public read permission. Can assign to BOSPutBucketAclRequest's cannedAcl field.
 */
extern NSString* const BOS_ACL_PUBLIC_READ;

/**
 *  @brief Public read write permission. Can assign to BOSPutBucketAclRequest's cannedAcl field.
 */
extern NSString* const BOS_ACL_PUBLIC_READ_WRITE;

/**
 *  @brief BOS put bucket acl request.
 *
 */
@interface BOSPutBucketAclRequest : BOSBucketRelatedRequest

/**
 *  @brief canned acl string. can be BOS_ACL_PRIVATE, BOS_ACL_PUBLIC_READ, or BOS_ACL_PUBLIC_READ_WRITE.
 */
@property(nonatomic, copy) NSString* cannedAcl;


/**
 *  @brief The access control list.
 */
@property(nonatomic, strong) BOSACL* acl;

@end

/**
 *  @brief BOS put bucket acl response.
 */
@interface BOSPutBucketAclResponse : BOSResponse
@end
