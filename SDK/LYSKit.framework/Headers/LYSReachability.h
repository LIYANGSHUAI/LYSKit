
#import <UIKit/UIKit.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import <netinet/in.h>

typedef NS_ENUM(NSUInteger, LYSNetworkStatus) {
    LYSNetworkStatusNotReachable = 0,                        // 无网络
    LYSNetworkStatusReachableVia2G,                          // 2G
    LYSNetworkStatusReachableVia3G,                          // 3G
    LYSNetworkStatusRaeachableVia4G,                         // 4G
    LYSNetworkStatusReachableViaWWAN,                        // WWAN
    LYSNetworkStatusReachableViaWiFi                         // WIFI
};

// 网络监听变化通知
extern NSString *LYSReachabilityChangedNotification;

@interface LYSReachability : NSObject

/**
 网络监听变化回调
 */
@property (nonatomic,copy)void(^notifitionCallBack)(LYSReachability *reachability);

/**
 创建

 @param hostName 地址
 @return 实例
 */
+ (instancetype)ly_reachabilityWithHostName:(NSString *)hostName;

/**
 创建

 @param hostAddress 地址
 @return 实例
 */
+ (instancetype)ly_reachabilityWithAddress:(const struct sockaddr *)hostAddress;

/**
 创建

 @return 实例
 */
+ (instancetype)ly_reachabilityForInternetConnection;

/**
 开启监听

 @return 返回是否开启成功
 */
- (BOOL)startNotifier;

/**
 关闭监听
 */
- (void)stopNotifier;

/**
 获取当前网络状态

 @return 返回状态
 */
- (LYSNetworkStatus)currentReachabilityStatus;

/**
 返回监听连接状态

 @return 返回状态
 */
- (BOOL)connectionRequired;

@end
