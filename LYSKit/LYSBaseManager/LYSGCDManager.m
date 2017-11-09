//
//  LYSGCDManager.m
//  LYSKitDemo
//
//  Created by HENAN on 2017/11/9.
//  Copyright © 2017年 HENAN. All rights reserved.
//

#import "LYSGCDManager.h"

@implementation LYSGCDManager
#pragma mark - 获取系统串行队列 -
+ (dispatch_queue_t)ly_systemSerialQueue
{
    return dispatch_get_main_queue();
}
#pragma mark - 获取系统并行队列 -
+ (dispatch_queue_t)ly_systemParallelQueue
{
    return dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
}
#pragma mark - 获取自定义的串行队列 -
+ (dispatch_queue_t)ly_customSerialQueue
{
    return dispatch_queue_create("GCD", DISPATCH_QUEUE_SERIAL);
}
#pragma mark - 获取自定义的并行队列 -
+ (dispatch_queue_t)ly_customParallelQueue
{
    return dispatch_queue_create("GCD", DISPATCH_QUEUE_CONCURRENT);
}
#pragma mark - 在系统串行队列添加异步任务 -
+ (void)ly_addAsync_InSystemSerialQueue:(void(^)(void))action
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (action){ action(); }
    });
}
#pragma mark - 在系统并行队列添加异步任务 -
+ (void)ly_addAsync_InSystemParallelQueue:(void(^)(void))action
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        if (action){ action(); }
    });
}
#pragma mark - 在系统并行队列添加同步任务 -
+ (void)ly_addSync_InSystemParallelQueue:(void(^)(void))action
{
    dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        if (action){ action(); }
    });
}
#pragma mark - 在自定义的串行队列添加异步任务 -
+ (void)ly_addAsync:(void(^)(void))action inCustomSerialQueue:(dispatch_queue_t)queue
{
    dispatch_async(queue, ^{
        if (action){ action(); }
    });
}
#pragma mark - 在自定义的串行队列添加同步任务 -
+ (void)ly_addSync:(void(^)(void))action inCustomSerialQueue:(dispatch_queue_t)queue
{
    dispatch_sync(queue, ^{
        if (action){ action(); }
    });
}
#pragma mark - 在自定义的并行队列添加异步任务 -
+ (void)ly_addAsync:(void(^)(void))action inCustomParallelQueue:(dispatch_queue_t)queue
{
    dispatch_async(queue, ^{
        if (action){ action(); }
    });
}
#pragma mark - 在自定义的并行队列添加同步任务 -
+ (void)ly_addSync:(void(^)(void))action inCustomParallelQueue:(dispatch_queue_t)queue
{
    dispatch_sync(queue, ^{
        if (action){ action(); }
    });
}
#pragma mark - 障碍任务 -
+ (void)ly_add_Barrier_Async:(void(^)(dispatch_queue_t queue))firstAction
               barrierAction:(void(^)(void))actionBarrier
                  lastAction:(void(^)(void))completeAction
{
    dispatch_queue_t queue = [self ly_customParallelQueue];
    if (firstAction){ firstAction(queue);}
    dispatch_barrier_async(queue, ^{
        if (actionBarrier){ actionBarrier();}
    });
    dispatch_async(queue, ^{
        if (completeAction){completeAction();}
    });
}
#pragma mark - 添加障碍任务 -
+ (void)ly_add_Barrier_AsyncAction:(void(^)(void))firstAction queue:(dispatch_queue_t)queue
{
    [self ly_addAsync:firstAction inCustomParallelQueue:queue];
}
#pragma mark - 延迟任务 -
+ (void)ly_addAfter:(NSTimeInterval)interval action:(void(^)(void))action
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(interval * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (action){ action(); }
    });
}
#pragma mark - 重复任务 -
+ (void)ly_addRepeat:(NSInteger)num action:(void(^)(void))action
{
    dispatch_apply(num, [self ly_systemParallelQueue], ^(size_t a) {
        if (action){ action(); }
    });
}
#pragma mark - 一次任务 -
+ (void)ly_addOnceAction:(void(^)(void))action{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (action){ action(); }
    });
}
#pragma mark - 等待任务 -
+ (void)ly_add_Group_AsyncAction:(void(^)(dispatch_group_t group,dispatch_queue_t queue))firstAction notifyAction:(void(^)(void))action
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
#pragma mark - 添加等待任务 -
+ (void)ly_add_Group_AsyncAction:(void(^)(void))firstAction group:(dispatch_group_t)group queue:(dispatch_queue_t)queue
{
    dispatch_group_async(group, queue, ^{
        if (firstAction) {
            firstAction();
        }
    });
}
@end
