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

@class BCEResponse;

/**
 *  @brief The task's output. if more than one field have value, somewhere will have a black evil dragon.
 */
@interface BCEOutput : NSObject

/**
 *  @brief The response when the task is fullfilled.
 */
@property(nonatomic, strong) BCEResponse* response;

/**
 *  @brief The error when the task is rejected.
 */
@property(nonatomic, strong) NSError* error;

/**
 *  @brief The progress when the task is running.
 */
@property(nonatomic, strong) NSNumber* progress;

@end

/**
 *  @brief The callback block when the task products an output.
 *  @param output The task's output.
 */
typedef void (^BCEOutputBlock)(BCEOutput* output);

/**
 *  @brief The callback block used by task's then method.
 *  @param outputBlock The task's output callback block.
 */
typedef void (^BCETaskThenBlock)(BCEOutputBlock outputBlock);

/**
 *  @brief The specific execution of a HTTP request is a task.
 *         Can be called asynchronously, you can also wait for the task to complete.
 *         A simple promise/A+ implemention: https://promisesaplus.com/
 *         If the task is a long time operation，such as download or upload, will have progress output.
 */
@interface BCETask : NSObject

/**
 *  @brief If task is fullfilled, rejected, or report progress. the returned block will be called.
 *         If the task is a long time operation，such as download or upload, will have progress output.
 *  @return A callback block which will be called when the task have been fullfilled, rejected, or reporting progress.
 */
- (BCETaskThenBlock)then;

/**
 *  @brief Wait for the specific time.
 *  @param time timeout time.
 *  @return If the wait is success. return zero, otherwise nonzero.
 */
- (long)wait:(dispatch_time_t)time;

/**
 *  @brief Wait forever.
 */
- (void)waitUtilFinished;

/**
 *  @brief Cancel the task's executing.
 */
- (void)cancel;

@end
