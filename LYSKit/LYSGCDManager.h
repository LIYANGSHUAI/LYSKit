//
//  LYSGCDManager.h
//  LYSKitDemo
//
//  Created by HENAN on 2017/11/9.
//  Copyright © 2017年 HENAN. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LYSGCDManager : NSObject
/*
 *-------------------------------------------------------------------------|
 *         |              串行队列             |         并行队列             |
 *-------------------------------------------------------------------------|
 *         | 主队列         | 自定义串行队列     |  全局队列 | 自定义全局队列     |
 *-------------------------------------------------------------------------|
 * 同步任务 | 线程死锁       | 在主线程顺序完成    | 在主线程顺序完成|在主线程顺序完成|
 *-------------------------------------------------------------------------|
 * 异步任务 |主线程中顺序完成 | 在子线程顺序完成    | 在子线程乱序完成|在子线程乱序完成|
 *-------------------------------------------------------------------------|
 */

/**
 获取系统串行队列
 
 @return 返回系统串行队列
 */
+ (dispatch_queue_t)ly_systemSerialQueue;

/**
 获取系统并行队列
 
 @return 返回系统并行队列
 */
+ (dispatch_queue_t)ly_systemParallelQueue;

/**
 获取自定义的串行队列
 
 @return 返回自定义的串行队列
 */
+ (dispatch_queue_t)ly_customSerialQueue;

/**
 获取自定义的并行队列
 
 @return 返回自定义的并行队列
 */
+ (dispatch_queue_t)ly_customParallelQueue;

/**
 在系统串行队列添加异步任务
 
 @param action 异步任务
 */
+ (void)ly_addAsync_InSystemSerialQueue:(void(^)(void))action;

/**
 在系统并行队列添加异步任务
 
 @param action 添加的异步任务
 */
+ (void)ly_addAsync_InSystemParallelQueue:(void(^)(void))action;

/**
 在系统并行队列添加同步任务
 
 @param action 添加的同步任务
 */
+ (void)ly_addSync_InSystemParallelQueue:(void(^)(void))action;

/**
 在自定义的并行队列添加异步任务
 
 @param action 添加的异步任务
 @param queue 自定义的串行队列
 */
+ (void)ly_addAsync:(void(^)(void))action inCustomSerialQueue:(dispatch_queue_t)queue;

/**
 在自定义的并行队列添加同步任务
 
 @param action 添加的同步任务
 @param queue 自定义的串行队列
 */
+ (void)ly_addSync:(void(^)(void))action inCustomSerialQueue:(dispatch_queue_t)queue;

/**
 在自定义的并行队列添加异步任务
 
 @param action 添加的异步任务
 @param queue 自定义的全局队列
 */
+ (void)ly_addAsync:(void(^)(void))action inCustomParallelQueue:(dispatch_queue_t)queue;

/**
 在自定义的并行队列添加同步任务
 
 @param action 添加的同步任务
 @param queue 自定义的全局队列
 */
+ (void)ly_addSync:(void(^)(void))action inCustomParallelQueue:(dispatch_queue_t)queue;

/**
 障碍任务
 
 @param firstAction 先完成的任务,ly_add_Barrier_AsyncAction: queue:调用此方法进行添加
 @param actionBarrier 障碍任务
 @param completeAction 最后完成的任务
 */
+ (void)ly_add_Barrier_Async:(void(^)(dispatch_queue_t queue))firstAction barrierAction:(void(^)(void))actionBarrier lastAction:(void(^)(void))completeAction;

/**
 添加障碍任务,配合上面的方法
 
 @param firstAction 任务
 @param queue 队列
 */
+ (void)ly_add_Barrier_AsyncAction:(void(^)(void))firstAction queue:(dispatch_queue_t)queue;

/**
 延迟任务
 
 @param interval 延迟的时间
 @param action 延迟事件
 */
+ (void)ly_addAfter:(NSTimeInterval)interval action:(void(^)(void))action;

/**
 重复任务
 
 @param num 重复的次数
 @param action 重复的事件
 */
+ (void)ly_addRepeat:(NSInteger)num action:(void(^)(void))action;

/**
 一次任务
 
 @param action 执行的任务
 */
+ (void)ly_addOnceAction:(void(^)(void))action;

/**
 等待任务ly_add_Group_AsyncAction: group: queue:调用此方法进行添加
 
 @param firstAction 先执行的任务
 @param action 其他任务完成后执行的任务
 */
+ (void)ly_add_Group_AsyncAction:(void(^)(dispatch_group_t group,dispatch_queue_t queue))firstAction notifyAction:(void(^)(void))action;

/**
 添加等待任务,配合上面方法
 
 @param firstAction 任务体
 */
+ (void)ly_add_Group_AsyncAction:(void(^)(void))firstAction group:(dispatch_group_t)group queue:(dispatch_queue_t)queue;
@end
