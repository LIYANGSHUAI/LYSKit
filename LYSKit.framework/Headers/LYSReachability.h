/*
 Copyright (C) 2016 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
 
 Abstract:
 Basic demonstration of how to use the SystemConfiguration Reachablity APIs.
 */

#import <UIKit/UIKit.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import <netinet/in.h>

typedef NS_ENUM(NSUInteger, LYSNetworkStatus) {
    LYSNetworkStatusNotReachable = 0,
    LYSNetworkStatusReachableVia2G,
    LYSNetworkStatusReachableVia3G,
    LYSNetworkStatusRaeachableVia4G,
    LYSNetworkStatusReachableViaWWAN,
    LYSNetworkStatusReachableViaWiFi
};

#pragma mark IPv6 Support
//Reachability fully support IPv6.  For full details, see ReadMe.md.


extern NSString *LYSReachabilityChangedNotification;


@interface LYSReachability : NSObject

@property (nonatomic,copy)void(^notifitionCallBack)(LYSReachability *reachability);

/*!
 * Use to check the reachability of a given host name.
 */
+ (instancetype)ly_reachabilityWithHostName:(NSString *)hostName;

/*!
 * Use to check the reachability of a given IP address.
 */
+ (instancetype)ly_reachabilityWithAddress:(const struct sockaddr *)hostAddress;

/*!
 * Checks whether the default route is available. Should be used by applications that do not connect to a particular host.
 */
+ (instancetype)ly_reachabilityForInternetConnection;


#pragma mark reachabilityForLocalWiFi
//reachabilityForLocalWiFi has been removed from the sample.  See ReadMe.md for more information.
//+ (instancetype)reachabilityForLocalWiFi;

/*!
 * Start listening for reachability notifications on the current run loop.
 */
- (BOOL)startNotifier;
- (void)stopNotifier;

- (LYSNetworkStatus)currentReachabilityStatus;

/*!
 * WWAN may be available, but not active until a connection has been established. WiFi may require a connection for VPN on Demand.
 */
- (BOOL)connectionRequired;

@end


