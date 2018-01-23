
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

extern NSString *LYSReachabilityChangedNotification;

@interface LYSReachability : NSObject

@property (nonatomic,copy)void(^notifitionCallBack)(LYSReachability *reachability);

+ (instancetype)ly_reachabilityWithHostName:(NSString *)hostName;
+ (instancetype)ly_reachabilityWithAddress:(const struct sockaddr *)hostAddress;
+ (instancetype)ly_reachabilityForInternetConnection;

- (BOOL)startNotifier;
- (void)stopNotifier;

- (LYSNetworkStatus)currentReachabilityStatus;

- (BOOL)connectionRequired;

@end
