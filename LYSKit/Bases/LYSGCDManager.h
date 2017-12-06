//
//  LYSGCDManager.h
//  LYSKitDemo
//
//  Created by HENAN on 2017/12/5.
//  Copyright © 2017年 HENAN. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^LYSGCDAction)(void);
typedef void(^LYSGCDActionQueue)(dispatch_queue_t queue);

@interface LYSGCDManager : NSObject
/*
 *-------------------------------------------------------------------------|
 *         |              串行队列             |         并行队列             |
 *-------------------------------------------------------------------------|
 *         | 主队列         | 自定义串行队列     |  全局队列 | 自定义全局队列      |
 *-------------------------------------------------------------------------|
 * 同步任务 | 线程死锁       | 在主线程顺序完成    | 在主线程顺序完成|在主线程顺序完成 |
 *-------------------------------------------------------------------------|
 * 异步任务 |主线程中顺序完成 | 在子线程顺序完成    | 在子线程乱序完成|在子线程乱序完成  |
 *-------------------------------------------------------------------------|
 */

// Getting the system serial queue
+ (dispatch_queue_t)systemSerialQueue;

// Obtaining system parallel queues
+ (dispatch_queue_t)systemParallelQueue;

// Creating a custom serial queue
+ (dispatch_queue_t)createSerialQueue;

// Creating a custom parallel queue
+ (dispatch_queue_t)createParallelQueue;

// Adding asynchronous tasks to the system serial queue
+ (void)addAsync_InSystemSerialQueue:(LYSGCDAction)action;

// Adding asynchronous tasks to a system parallel queue
+ (void)addAsync_InSystemParallelQueue:(LYSGCDAction)action;

// Add synchronization tasks to the system parallel queue. (from the above table, we can see that adding synchronous tasks in the system serial queue will cause deadlock, so here is not providing synchronous tasks in the system's serial queue).
+ (void)addSync_InSystemParallelQueue:(LYSGCDAction)action;

// Adding asynchronous tasks to a custom queue
+ (void)addAsync:(LYSGCDAction)action queue:(dispatch_queue_t)queue;

// Add synchronization tasks in custom queues
+ (void)addSync:(LYSGCDAction)action queue:(dispatch_queue_t)queue;

// Obstacle task
+ (void)add_Barrier_Async:(LYSGCDActionQueue)firstAction barrierAction:(LYSGCDAction)actionBarrier lastAction:(LYSGCDAction)completeAction;

// Add an obstacle task, with the above method
+ (void)add_Barrier_AsyncAction:(LYSGCDAction)firstAction queue:(dispatch_queue_t)queue;

// Delay task
+ (void)addAfter:(NSTimeInterval)interval action:(LYSGCDAction)action;

// Duplication of tasks
+ (void)addRepeat:(NSInteger)num
              action:(LYSGCDAction)action;
// A task
+ (void)addOnceAction:(LYSGCDAction)action;

// Waiting for the task add_Group_AsyncAction: group: queue: to call this method to add
+ (void)add_Group_AsyncAction:(void(^)(dispatch_group_t group,dispatch_queue_t queue))firstAction notifyAction:(LYSGCDAction)action;

// Add the waiting task and cooperate with the above method
+ (void)add_Group_AsyncAction:(LYSGCDAction)firstAction group:(dispatch_group_t)group queue:(dispatch_queue_t)queue;
@end
