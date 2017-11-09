//
//  LYSLocationManager.m
//  LYSKitDemo
//
//  Created by HENAN on 2017/11/9.
//  Copyright © 2017年 HENAN. All rights reserved.
//

#import "LYSLocationManager.h"
#import <CoreLocation/CoreLocation.h>

@interface LYSLocationManager ()<CLLocationManagerDelegate>

@property (nonatomic,strong)CLLocationManager *locationManager;

@property (nonatomic,strong)CLGeocoder *geocoderManager;

@property (nonatomic,copy)void(^success)(CLLocation *location);

@property (nonatomic,copy)void(^fail)(NSString *state);

@property (nonatomic,assign)BOOL isSuccess;

@end

@implementation LYSLocationManager
// 单例创建
+ (instancetype)shareInstance{
    static LYSLocationManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[LYSLocationManager alloc] init];
    });
    return manager;
}
- (CLLocationManager *)locationManager{
    if (!_locationManager) {
        self.locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
    }
    return _locationManager;
}
- (CLGeocoder *)geocoderManager{
    if (!_geocoderManager) {
        self.geocoderManager = [[CLGeocoder alloc] init];
    }
    return _geocoderManager;
}
// 监测定位
+ (void)ly_location:(void(^)(CLLocation *location))success fail:(void(^)(NSString *state))fail{
    LYSLocationManager *manager = [self shareInstance];
    CLLocationManager *lCManager = manager.locationManager;
    manager.isSuccess = NO;
    if ([CLLocationManager locationServicesEnabled]) {
        if (success) {
            manager.success = success;
        }
        if (fail) {
            manager.fail = fail;
        }
        [lCManager startUpdatingLocation];
        [lCManager requestWhenInUseAuthorization];
        lCManager.distanceFilter=kCLDistanceFilterNone;
        //设置定位的精准度，一般精准度越高，越耗电（这里设置为精准度最高的，适用于导航应用）
        lCManager.desiredAccuracy=kCLLocationAccuracyBestForNavigation;
    }else {
        if (fail) {
            fail(@"用户没有打开定位或者网络不好");
        }
    }
}
#pragma mark - CLLocationManagerDelegate -
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    if (!self.isSuccess) {
        [manager stopUpdatingLocation];
        CLLocation *loc = [locations firstObject];
        if (self.success) {
            self.success(loc);
            self.isSuccess = YES;
        }
    }
}
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    if (self.fail) {
        self.fail(error.localizedDescription);
    }
}
#pragma mark - 地理反编码 -
+ (void)ly_geocoder:(CLLocation *)location success:(void(^)(CLPlacemark *placemark))success{
    LYSLocationManager *manager = [self shareInstance];
    [manager.geocoderManager reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (success) {
            success([placemarks firstObject]);
        }
    }];
}
@end
