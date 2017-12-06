//
//  LYSLocationManager.h
//  LYSKitDemo
//
//  Created by HENAN on 2017/12/5.
//  Copyright © 2017年 HENAN. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CLLocation;

@class CLPlacemark;

@class LYSLocationManager;

// location success notifition callback
extern NSString *LYSLocationDidUpdateNotifition;

// notifition userInfo message
extern NSString *LYSLocationUserInfoKey;

typedef void(^LYSDidUpdateLocationCallback)(CLLocation *location);

@protocol LYSLocationManagerDelegate <NSObject>

@optional
- (void)manager:(LYSLocationManager *)manager didFailLocationWithError:(NSError *)error;
- (void)manager:(LYSLocationManager *)manager didUpdateLocation:(CLLocation *)location;

@end

@interface LYSLocationManager : NSObject

// Positioning agent
@property (nonatomic,assign)id<LYSLocationManagerDelegate> delegate;
@property (nonatomic,copy)LYSDidUpdateLocationCallback updateLocationCallback;

// Creation method
- (instancetype)initWithDelegate:(id<LYSLocationManagerDelegate>)delegate;
+ (instancetype)loactionWithDelegate:(id<LYSLocationManagerDelegate>)delegate;

- (void)startLocation;
- (void)stopLocation;

// Anti coding for acquired location information
- (void)geocoder:(CLLocation *)location success:(void(^)(CLPlacemark *placemark))success;
@end
