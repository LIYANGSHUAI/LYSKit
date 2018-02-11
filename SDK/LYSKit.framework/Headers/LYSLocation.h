
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
- (void)location:(LYSLocation *)mlocation didFailLocation:(NSError *)error;

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

/**
 对地理位置进行反编译

 @param location 地理对象
 @param success 反编译成功回调
 */
- (void)geocoder:(CLLocation *)location success:(void(^)(CLPlacemark *placemark))success;
@end
