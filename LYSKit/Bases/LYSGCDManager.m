//
//  LYSGCDManager.m
//  LYSKitDemo
//
//  Created by HENAN on 2017/12/5.
//  Copyright © 2017年 HENAN. All rights reserved.
//

#import "LYSGCDManager.h"

@implementation LYSGCDManager

// 获取系统串行队列
+ (dispatch_queue_t)systemSerialQueue
{
    return dispatch_get_main_queue();
}

// 获取系统并行队列
+ (dispatch_queue_t)systemParallelQueue
{
    return dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
}

// 获取自定义的串行队列
+ (dispatch_queue_t)createSerialQueue
{
    return dispatch_queue_create("GCD", DISPATCH_QUEUE_SERIAL);
}

// 获取自定义的并行队列
+ (dispatch_queue_t)createParallelQueue
{
    return dispatch_queue_create("GCD", DISPATCH_QUEUE_CONCURRENT);
}

// 在系统串行队列添加异步任务
+ (void)addAsync_InSystemSerialQueue:(LYSGCDAction)action
{
    dispatch_async([self systemSerialQueue], ^{if (action){ action(); }});
}

// 在系统并行队列添加异步任务
+ (void)addAsync_InSystemParallelQueue:(LYSGCDAction)action
{
    dispatch_async([self systemParallelQueue], ^{if (action){ action();}});
}

// 在系统并行队列添加同步任务
+ (void)addSync_InSystemParallelQueue:(LYSGCDAction)action
{
    dispatch_sync([self systemParallelQueue], ^{if (action){ action();}});
}

// 在自定义的串行队列添加异步任务
+ (void)addAsync:(LYSGCDAction)action queue:(dispatch_queue_t)queue
{
    dispatch_async(queue, ^{if (action){ action();}});
}

// 在自定义的串行队列添加同步任务
+ (void)addSync:(LYSGCDAction)action queue:(dispatch_queue_t)queue
{
    dispatch_sync(queue, ^{if (action){ action();}});
}

// 障碍任务
+ (void)add_Barrier_Async:(LYSGCDActionQueue)firstAction
               barrierAction:(LYSGCDAction)actionBarrier
                  lastAction:(LYSGCDAction)completeAction
{
    dispatch_queue_t queue = [self createParallelQueue];
    if (firstAction){ firstAction(queue);}
    dispatch_barrier_async(queue, ^{
        if (actionBarrier){ actionBarrier();}
    });
    dispatch_async(queue, ^{
        if (completeAction){completeAction();}
    });
}

// 添加障碍任务
+ (void)add_Barrier_AsyncAction:(LYSGCDAction)firstAction queue:(dispatch_queue_t)queue
{
    [self addAsync:firstAction queue:queue];
}

// 延迟任务
+ (void)addAfter:(NSTimeInterval)interval action:(LYSGCDAction)action
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(interval * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (action){ action(); }
    });
}

// 重复任务
+ (void)addRepeat:(NSInteger)num action:(LYSGCDAction)action
{
    dispatch_apply(num, [self systemParallelQueue], ^(size_t a) {if (action){ action(); }});
}

// 一次任务
+ (void)addOnceAction:(LYSGCDAction)action{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (action){ action(); }
    });
}

// 等待任务
+ (void)add_Group_AsyncAction:(void(^)(dispatch_group_t group,dispatch_queue_t queue))firstAction notifyAction:(LYSGCDAction)action
{
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_queue_create("GCD", DISPATCH_QUEUE_CONCURRENT);
    if (firstAction){ firstAction(group,queue);}
    dispatch_group_notify(group, queue, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            if (action){ action(); }
        });
    });
}

// 添加等待任务
+ (void)add_Group_AsyncAction:(LYSGCDAction)firstAction group:(dispatch_group_t)group queue:(dispatch_queue_t)queue
{
    dispatch_group_async(group, queue, ^{
        if (firstAction) {
            firstAction();
        }
    });
}

@end
