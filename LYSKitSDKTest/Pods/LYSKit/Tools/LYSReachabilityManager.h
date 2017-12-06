//
//  LYSReachabilityManager.h
//  LYSKitDemo
//
//  Created by HENAN on 2017/12/5.
//  Copyright © 2017年 HENAN. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, LYSNetworkStatus) {
    LYSNetworkStatusNotReachable = 0,
    LYSNetworkStatusReachableVia2G,
    LYSNetworkStatusReachableVia3G,
    LYSNetworkStatusRaeachableVia4G,
    LYSNetworkStatusReachableViaWWAN,
    LYSNetworkStatusReachableViaWiFi
};

extern NSString *LYSReachabilityChangedNotification;

@class LYSReachabilityManager;

typedef void(^NotifitionCallBack)(LYSReachabilityManager *reachability);

@protocol LYSReachabilityManagerDelegate <NSObject>

- (void)reachabilityNetworkDidChange:(LYSReachabilityManager *)manager;

@end

@interface LYSReachabilityManager : NSObject

// the network did change callback
@property (nonatomic,copy)NotifitionCallBack notifitionCallBack;
@property (nonatomic,assign)id<LYSReachabilityManagerDelegate> delegate;

+ (instancetype)reachabilityWithHostName:(NSString *)hostName
                                delegate:(id<LYSReachabilityManagerDelegate>)delegate;
+ (instancetype)reachabilityWithAddress:(const struct sockaddr *)hostAddress
                               delegate:(id<LYSReachabilityManagerDelegate>)delegate;
+ (instancetype)reachabilityForInternetConnectionWithDelegate:(id<LYSReachabilityManagerDelegate>)delegate;

- (BOOL)startNotifier;
- (void)stopNotifier;

- (LYSNetworkStatus)currentReachabilityStatus;

- (BOOL)connectionRequired;
@end
