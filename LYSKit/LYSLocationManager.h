//
//  LYSLocationManager.h
//  LYSKitDemo
//
//  Created by HENAN on 2017/11/9.
//  Copyright © 2017年 HENAN. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CLLocation;

@class CLPlacemark;

@interface LYSLocationManager : NSObject
/**
 获取位置信息(如果此方法调用多次,那么下次的回调函数会覆盖上次的回调,前提时此时还没有定位成功)
 
 @param success 成功定位回调
 @param fail 失败定位回调
 */
+ (void)ly_location:(void(^)(CLLocation *location))success
               fail:(void(^)(NSString *state))fail;

/**
 对定位信息进行反编码
 
 @param location 定位信息
 @param success 反编码成功回调
 */
+ (void)ly_geocoder:(CLLocation *)location
            success:(void(^)(CLPlacemark *placemark))success;
@end
