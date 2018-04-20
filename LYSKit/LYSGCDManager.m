//
//  LYSGCDManager.m
//  LYSKitDemo
//
//  Created by HENAN on 2018/4/20.
//  Copyright © 2018年 liyangshuai. All rights reserved.
//

#import "LYSGCDManager.h"

@implementation LYSGCDManager

+ (dispatch_queue_t)ly_systemSerialQueue
{
    return dispatch_get_main_queue();
}

+ (dispatch_queue_t)ly_systemParallelQueue
{
    return dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
}

+ (dispatch_queue_t)ly_createSerialQueue
{
    return dispatch_queue_create("GCD", DISPATCH_QUEUE_SERIAL);
}

+ (dispatch_queue_t)ly_createParallelQueue
{
    return dispatch_queue_create("GCD", DISPATCH_QUEUE_CONCURRENT);
}

+ (void)ly_addAsync_InSystemSerialQueue:(LYSGCDAction)action
{
    dispatch_async([self ly_systemSerialQueue], ^{if (action){ action(); }});
}

+ (void)ly_addAsync_InSystemParallelQueue:(LYSGCDAction)action
{
    dispatch_async([self ly_systemParallelQueue], ^{if (action){ action();}});
}

+ (void)ly_addSync_InSystemParallelQueue:(LYSGCDAction)action
{
    dispatch_sync([self ly_systemParallelQueue], ^{if (action){ action();}});
}

+ (void)ly_addAsync:(LYSGCDAction)action queue:(dispatch_queue_t)queue
{
    dispatch_async(queue, ^{if (action){ action();}});
}

+ (void)ly_addSync:(LYSGCDAction)action queue:(dispatch_queue_t)queue
{
    dispatch_sync(queue, ^{if (action){ action();}});
}

+ (void)ly_add_Barrier_Async:(LYSGCDActionQueue)firstAction
               barrierAction:(LYSGCDAction)actionBarrier
                  lastAction:(LYSGCDAction)completeAction
{
    dispatch_queue_t queue = [self ly_createParallelQueue];
    if (firstAction){ firstAction(queue);}
    dispatch_barrier_async(queue, ^{
        if (actionBarrier){ actionBarrier();}
    });
    dispatch_async(queue, ^{
        if (completeAction){completeAction();}
    });
}

+ (void)ly_add_Barrier_AsyncAction:(LYSGCDAction)firstAction queue:(dispatch_queue_t)queue
{
    [self ly_addAsync:firstAction queue:queue];
}

+ (void)ly_addAfter:(NSTimeInterval)interval action:(LYSGCDAction)action
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(interval * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (action){ action(); }
    });
}

+ (void)ly_addRepeat:(NSInteger)num action:(LYSGCDAction)action
{
    dispatch_apply(num, [self ly_systemParallelQueue], ^(size_t a) {if (action){ action(); }});
}

+ (void)ly_addOnceAction:(LYSGCDAction)action{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (action){ action(); }
    });
}

+ (void)ly_add_Group_AsyncAction:(void(^)(dispatch_group_t group,dispatch_queue_t queue))firstAction notifyAction:(LYSGCDAction)action
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

+ (void)ly_add_Group_AsyncAction:(LYSGCDAction)firstAction group:(dispatch_group_t)group queue:(dispatch_queue_t)queue
{
    dispatch_group_async(group, queue, ^{
        if (firstAction) {
            firstAction();
        }
    });
}
@end
