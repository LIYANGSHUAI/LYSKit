//
//  LYSReachabilityManager.h
//  LYSKitDemo
//
//  Created by HENAN on 2017/11/9.
//  Copyright © 2017年 HENAN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LYSReachability.h"
@interface LYSReachabilityManager : NSObject
/**
 注册网络监听
 
 @param action 监听回调事件
 @param reachability 网络监听对象
 */
+ (void)ly_notifitionReachability:(void(^)(LYSReachability *reachability))action reachability:(LYSReachability *)reachability promptly:(BOOL)promptly;

/**
 移除网络监听
 
 @param reachability 网络监听对象
 */
+ (void)ly_stopNotifitionReachability:(LYSReachability *)reachability;
@end
