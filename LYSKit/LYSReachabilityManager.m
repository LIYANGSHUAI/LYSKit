//
//  LYSReachabilityManager.m
//  LYSKitDemo
//
//  Created by HENAN on 2017/11/9.
//  Copyright © 2017年 HENAN. All rights reserved.
//

#import "LYSReachabilityManager.h"
@interface LYSReachabilityManager ()
@property (nonatomic,strong)NSMutableArray *reachabilityAry;
@end
@implementation LYSReachabilityManager
- (NSMutableArray *)reachabilityAry{
    if (!_reachabilityAry) {
        _reachabilityAry = [NSMutableArray array];
    }
    return _reachabilityAry;
}
+ (instancetype)shareInstance{
    static LYSReachabilityManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[LYSReachabilityManager alloc] init];
    });
    return manager;
}
+ (void)ly_notifitionReachability:(void(^)(LYSReachability *reachability))action reachability:(LYSReachability *)reachability promptly:(BOOL)promptly
{
    if (promptly == YES) {if (action) {action(reachability);}}
    [[[self shareInstance] reachabilityAry] addObject:reachability];
    [reachability startNotifier];
    reachability.notifitionCallBack = ^(LYSReachability *reachability) {
        if (action) {action(reachability);}
    };
}

+ (void)ly_stopNotifitionReachability:(LYSReachability *)reachability{
    [reachability stopNotifier];
    [[[self shareInstance] reachabilityAry] removeObject:reachability];
}
@end
