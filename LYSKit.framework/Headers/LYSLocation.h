
#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

typedef NS_ENUM(NSUInteger, LYSLocationRequestType) {
    LYSLocationRequestTypeWhenInUse,
    LYSLocationRequestTypeAlways
};

@class LYSLocation;

extern NSString *const LYSLocationDidUpdateNotifition;


@protocol LYSLocationDelegate <NSObject>

/**
 位置信息发生改变时代理方法

 @param mlocation 实例
 @param location 新的位置信息
 */
- (void)location:(LYSLocation *)mlocation didUpdateLocation:(CLLocation *)location;

/**
 定位失败时代理方法

 @param mlocation 实例
 @param error 错误类
 */
- (void)location:(LYSLocation *)mlocation didFaileLocation:(NSError *)error;

@end

@interface LYSLocation : NSObject

@property(assign, nonatomic) CLLocationDistance distanceFilter;
@property(assign, nonatomic) CLLocationAccuracy desiredAccuracy;

// 请求类型
@property (nonatomic,assign)LYSLocationRequestType requestType;

// 代理
@property (nonatomic,assign)id<LYSLocationDelegate> delegate;

/**
 开启定位
 */
- (void)startLocation;

/**
 关闭定位
 */
- (void)stopLocation;
@end
