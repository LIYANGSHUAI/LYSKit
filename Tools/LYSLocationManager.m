//
//  LYSLocationManager.m
//  LYSKitDemo
//
//  Created by HENAN on 2017/12/5.
//  Copyright © 2017年 HENAN. All rights reserved.
//

#import "LYSLocationManager.h"

#import <CoreLocation/CoreLocation.h>

#define LAZYLOAD(TYPE,NAME) \
- (TYPE *)NAME{\
    if (!_##NAME) {\
        _##NAME = [[TYPE alloc] init];\
    }\
    return _##NAME;\
}

#define DELEGATE_ENABLE(DELEGATE,SELECTOR) (DELEGATE && [DELEGATE respondsToSelector:SELECTOR])

NSString *LYSLocationDidUpdateNotifition = @"LYSLocationDidUpdateNotifition";
NSString *LYSLocationUserInfoKey = @"LYSLocationUserInfoKey";

@interface LYSLocationManager ()<CLLocationManagerDelegate>

@property (nonatomic,strong)CLLocationManager *locationManager;
@property (nonatomic,strong)CLGeocoder *geocoderManager;

@end

@implementation LYSLocationManager

LAZYLOAD(CLLocationManager, locationManager)
LAZYLOAD(CLGeocoder, geocoderManager)

- (instancetype)initWithDelegate:(id<LYSLocationManagerDelegate>)delegate
{
    if (self = [super init]) {
        self.delegate = delegate;
        self.locationManager.delegate = self;
    }
    return self;
}

+ (instancetype)loactionWithDelegate:(id<LYSLocationManagerDelegate>)delegate
{
    return [[self alloc] initWithDelegate:delegate];
}


- (void)startLocation
{
    if ([CLLocationManager locationServicesEnabled])
    {
        [self.locationManager startUpdatingLocation];
        [self.locationManager requestWhenInUseAuthorization];
        self.locationManager.distanceFilter = kCLDistanceFilterNone;
        //设置定位的精准度，一般精准度越高，越耗电（这里设置为精准度最高的，适用于导航应用）
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
    }else {
        if (DELEGATE_ENABLE(self.delegate,@selector(manager:didFailLocationWithError:)))
        {
            NSDictionary *userInfo = @{NSLocalizedDescriptionKey:@"It may be because the device does not support the positioning function or the device does not open the positioning function"};
            NSError *error = [[NSError alloc] initWithDomain:NSCocoaErrorDomain code:0 userInfo:userInfo];
            [self.delegate manager:self didFailLocationWithError:error];
        }
    }
}

- (void)stopLocation
{
    if (self.locationManager)
    {
        [self.locationManager stopUpdatingLocation];
    }
}

#pragma mark - CLLocationManagerDelegate -
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    CLLocation *location = [locations firstObject];
    if (DELEGATE_ENABLE(self.delegate, @selector(manager:didUpdateLocation:)))
    {
        [self.delegate manager:self didUpdateLocation:location];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:LYSLocationDidUpdateNotifition object:nil userInfo:@{LYSLocationUserInfoKey:location}];
    if (self.updateLocationCallback) {self.updateLocationCallback(location);}
}
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    if (DELEGATE_ENABLE(self.delegate,@selector(manager:didFailLocationWithError:)))
    {
        NSDictionary *userInfo = @{NSLocalizedDescriptionKey:@"Unknowns cause location interruption"};
        NSError *error = [[NSError alloc] initWithDomain:NSCocoaErrorDomain code:0 userInfo:userInfo];
        [self.delegate manager:self didFailLocationWithError:error];
    }
}
#pragma mark - 地理反编码 -
- (void)geocoder:(CLLocation *)location success:(void(^)(CLPlacemark *placemark))success
{
    [self.geocoderManager reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error)
    {
        if (success)
        {
            success([placemarks firstObject]);
        }
    }];
}
@end
