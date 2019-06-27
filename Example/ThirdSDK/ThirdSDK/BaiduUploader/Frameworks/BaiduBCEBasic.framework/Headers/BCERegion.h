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
 *  @brief The region enum define.
 */
typedef NS_ENUM(NSUInteger, BCERegionType) {
    /**
     *  North Region. bj.
     */
    BCERegionBJ,
    /**
     *  South Region. gz.
     */
    BCERegionGZ
};

/**
 *  @brief Service region.
 */
@interface BCERegion : NSObject

/**
 *  @brief Constructs region from a region enum.
 *  @param type region enum.
 *  @return Constructed region.
 */
+ (instancetype)region:(BCERegionType)type;

/**
 *  @brief Region enum.
 */
@property(nonatomic) BCERegionType region;

@end
