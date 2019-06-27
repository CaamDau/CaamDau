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
 *  @brief BOS bucket summary information.
 */
@interface BOSBucketSummary : NSObject

/**
 *  @brief Bucket name.
 */
@property(nonatomic, copy) NSString* name;

/**
 *  @brief Bucket location.
 */
@property(nonatomic, copy) NSString* location;

/**
 *  @brief Bucket create date.
 */
@property(nonatomic, copy) NSString* createDate;

@end

/**
 *  @brief BOS bucket owner.
 */
@interface BOSBucketOwner : NSObject

/**
 *  @brief BOS Bucket owner ID.
 */
@property(nonatomic, copy) NSString* ownerID;

/**
 *  @brief BOS bucket owner display name.
 */
@property(nonatomic, copy) NSString* displayName;

@end

/**
 *  @brief BOS Bucket grantee's permission enum.
 */
typedef NS_ENUM(NSUInteger, BOSBucketGranteePermission) {
    /**
     *  The grantee have full control permission.
     */
    BOSBucketGranteePermissionFullControl,
    /**
     *  The grantee have read permission.
     */
    BOSBucketGranteePermissionRead,
    /**
     *  The grantee have write permission.
     */
    BOSBucketGranteePermissionWrite,
    /**
     *  The grantee have list permission.
     */
    BOSBucketGranteePermissionList,
    /**
     *  The grantee have get object permission.
     */
    BOSBucketGranteePermissionGetObject
};

/**
 *  @brief The ACL's condition
 */
@interface BOSACLCondition : NSObject

/**
 *  @brief The IP address can access the BOS service.
 */
@property(nonatomic, strong) NSArray<NSString*>* ipAddress;

/**
 *  @brief The referer contains in the array can access the BOS service.
 */
@property(nonatomic, copy) NSArray<NSString*>* refererEquals;

/**
 *  @brief The referer likes in the array can access the BOS service.
 */
@property(nonatomic, copy) NSArray<NSString*>* refererLikes;

@end

/**
 *  @brief The summary information of the grant.
 */
@interface BOSGrant : NSObject

/**
 *  @brief Required. The grantee array.
 */
@property(nonatomic, strong) NSArray<NSString*>* granteeIDArray;

/**
 *  @brief Required. The permission array.
 */
@property(nonatomic, strong) NSArray<NSString*>* permission;

/**
 *  @brief Optional. The resource array.
 */
@property(nonatomic, strong) NSArray<NSString*>* resource;

/**
 *  @brief Optional. The notResource array.
 */
@property(nonatomic, strong) NSArray<NSString*>* notResource;

/**
 *  @brief Optional. The condition.
 */
@property(nonatomic, strong) BOSACLCondition* condition;

/**
 *  @brief Convert from permission string to enum.
 *  @param permission Permission string.
 *  @return Permission enum.
 */
+ (BOSBucketGranteePermission)stringToPermission:(NSString*)permission;

/**
 *  @brief Convert from permission enum to string.
 *  @param permission Permission enum.
 *  @return Permission string.
 */
+ (NSString*)permissionToString:(BOSBucketGranteePermission)permission;

@end

/**
 *  @brief The bucket ACL
 */
@interface BOSACL : NSObject

/**
 *  @brief Optional. The bucket's owner.
 */
@property(nonatomic, strong) NSString* owner;

/**
 *  @brief Required. The bucket's grantee array.
 */
@property(nonatomic, strong) NSArray<BOSGrant*>* grantees;

@end

/**
 *  @brief The object metadata used for upload object.
 */
@interface BOSObjectMetadata : NSObject

/**
 *  @brief Required when upload object.
 */
@property(nonatomic, copy) NSString* contentLength;

/**
 *  @brief Required when upload object.
 */
@property(nonatomic, copy) NSString* contentType;


@property(nonatomic, copy) NSString* cacheControl;
@property(nonatomic, copy) NSString* contentDisposition;
@property(nonatomic, copy) NSString* contentMD5;
@property(nonatomic, copy) NSString* expires;
@property(nonatomic, copy) NSString* contentSHA256;

/**
 *  @brief User custom metadata, key will automatic have prefix 'x-bce-meta-'.
 */
@property(nonatomic, strong) NSDictionary<NSString*, NSString*>* userMetadata;

@end

/**
 *  @brief The object content store in a file or memory.
 */
@interface BOSObjectData : NSObject

/**
 *  @brief Store in file.
 */
@property(nonatomic, copy) NSString* file;

/**
 *  @brief Store in memory.
 */
@property(nonatomic, strong) NSData* data;

/**
 *  @brief Constructs from a file path.
 *  @param file File path.
 *  @return Object storage config.
 */
+ (BOSObjectData*)dataFromFile:(NSString*)file;

/**
 *  @brief Constructs from a data.
 *  @param data Data.
 *  @return Object storage config.
 */
+ (BOSObjectData*)dataFromData:(NSData*)data;

@end

/**
 *  @brief Object content for download/upload.
 */
@interface BOSObjectContent : NSObject

/**
 *  @brief Object data.
 */
@property(nonatomic, strong) BOSObjectData* objectData;

/**
 *  @brief Object metadata.
 */
@property(nonatomic, strong) BOSObjectMetadata* metadata;

/**
 *  @brief Prepare for upload.
 *         Calculate content-md5, content-sha256, and content-length.
 *  @return If prepare is succeed, return YES. Otherwise, return NO.
 */
- (BOOL)prepareForUpload;

/**
 *  @brief Prepare for download.
 *  @return If prepare is succeed, return YES. Otherwise, return NO.
 */
- (BOOL)prepareForDownload;

@end

/**
 *  @brief The summary information for a BOS object.
 */
@interface BOSObject : NSObject

/**
 *  @brief The name of the bucket that BOS object belongs to.
 */
@property(nonatomic, copy) NSString* bucket;

/**
 *  @brief The BOS object name.
 */
@property(nonatomic, copy) NSString* key;

/**
 *  @brief The BOS object's content information.
 */
@property(nonatomic, strong) BOSObjectContent* content;

/**
 *  @brief The BOS object's owner information.
 */
@property(nonatomic, strong) BOSBucketOwner* owner;

@end

/**
 *  @brief The summary information of one BOS multipart's part.
 */
@interface BOSPart : NSObject

/**
 *  @brief The part number of the part.
 */
@property(nonatomic, assign) NSInteger partNumber;

/**
 *  @brief The etag of the part.
 */
@property(nonatomic, copy) NSString* eTag;

/**
 *  @brief The last modified date of the part.
 */
@property(nonatomic, copy) NSString* lastModified;

/**
 *  @brief The size of the part.
 */
@property(nonatomic, copy) NSString* size;

/**
 *  @brief The storage type of object, return STANDARD_IA 、COLD、STANDARD
 */
@property(nonatomic, copy) NSString* storageClass;

@end

/**
 *  @brief The summary information of the BOS CORS configuration.
 */
@interface BOSCorsConfiguration : NSObject

/**
 *  @brief The allowed origins.
 */
@property(nonatomic, strong) NSArray<NSString*>* allowedOrigins;

/**
 *  @brief The allowed methods.
 */
@property(nonatomic, strong) NSArray<NSString*>* allowedMethods;

/**
 *  @brief The allowed headers.
 */
@property(nonatomic, strong) NSArray<NSString*>* allowedHeaders;

/**
 *  @brief The allowed expose headers.
 */
@property(nonatomic, strong) NSArray<NSString*>* allowedExposeHeaders;

/**
 *  @brief The max share time interval in seconds.
 */
@property(nonatomic, assign) int64_t maxAgeSeconds;

@end


