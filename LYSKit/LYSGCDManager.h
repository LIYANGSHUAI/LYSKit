//
//  LYSGCDManager.h
//  LYSKitDemo
//
//  Created by HENAN on 2018/4/20.
//  Copyright © 2018年 liyangshuai. All rights reserved.
//

#import <Foundation/Foundation.h>

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

typedef void(^LYSGCDAction)(void);
typedef void(^LYSGCDActionQueue)(dispatch_queue_t queue);

@interface LYSGCDManager : NSObject

/**
 获取系统串行队列
 
 @return                                    返回系统串行队列
 */
+ (dispatch_queue_t)ly_systemSerialQueue;

/**
 获取系统并行队列
 
 @return                                    返回系统并行队列
 */
+ (dispatch_queue_t)ly_systemParallelQueue;

/**
 创建自定义的串行队列
 
 @return                                    返回自定义创建的串行对类
 */
+ (dispatch_queue_t)ly_createSerialQueue;

/**
 创建自定义的并行队列
 
 @return                                    返回自定义创建的并行对类
 */
+ (dispatch_queue_t)ly_createParallelQueue;

/**
 向系统串行队列添加异步任务
 
 @param action                              异步任务
 */
+ (void)ly_addAsync_InSystemSerialQueue:(LYSGCDAction)action;

/**
 向系统并行队列添加异步任务
 
 @param action                              异步任务
 */
+ (void)ly_addAsync_InSystemParallelQueue:(LYSGCDAction)action;

/**
 向系统并行队列添加同步任务,(从上面表中可以看出,在系统串行队列中添加同步任务,会造成死锁,因此这里不在提供在系统串行队列中添加同步任务)
 
 @param action                              同步任务
 */
+ (void)ly_addSync_InSystemParallelQueue:(LYSGCDAction)action;

/**
 在自定义的队列添加异步任务
 
 @param action                              异步任务
 @param queue                               自定义的队列
 */
+ (void)ly_addAsync:(LYSGCDAction)action queue:(dispatch_queue_t)queue;

/**
 在自定义的队列添加同步任务
 
 @param action                              同步任务
 @param queue                               自定义的队列
 */
+ (void)ly_addSync:(LYSGCDAction)action queue:(dispatch_queue_t)queue;

/**
 障碍任务
 
 @param firstAction                         先完成的任务,ly_add_Barrier_AsyncAction: queue:调用此方法进行添加
 @param actionBarrier                       障碍任务
 @param completeAction                      最后完成的任务
 */
+ (void)ly_add_Barrier_Async:(LYSGCDActionQueue)firstAction barrierAction:(LYSGCDAction)actionBarrier lastAction:(LYSGCDAction)completeAction;

/**
 添加障碍任务,配合上面的方法
 
 @param firstAction                         任务
 @param queue                               队列
 */
+ (void)ly_add_Barrier_AsyncAction:(LYSGCDAction)firstAction queue:(dispatch_queue_t)queue;

/**
 延迟任务
 
 @param interval                            延迟的时间
 @param action                              延迟事件
 */
+ (void)ly_addAfter:(NSTimeInterval)interval action:(LYSGCDAction)action;

/**
 重复任务
 
 @param num                                 重复的次数
 @param action                              重复的事件
 */
+ (void)ly_addRepeat:(NSInteger)num action:(LYSGCDAction)action;

/**
 一次任务
 
 @param action                              执行的任务
 */
+ (void)ly_addOnceAction:(LYSGCDAction)action;

/**
 等待任务ly_add_Group_AsyncAction: group: queue:调用此方法进行添加
 
 @param firstAction                         先执行的任务
 @param action                              其他任务完成后执行的任务
 */
+ (void)ly_add_Group_AsyncAction:(void(^)(dispatch_group_t group,dispatch_queue_t queue))firstAction notifyAction:(LYSGCDAction)action;

/**
 添加等待任务,配合上面方法
 
 @param firstAction                         任务体
 */
+ (void)ly_add_Group_AsyncAction:(LYSGCDAction)firstAction group:(dispatch_group_t)group queue:(dispatch_queue_t)queue;

@end
