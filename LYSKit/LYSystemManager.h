//
//  LYSystemManager.h
//  LYSKitDemo
//
//  Created by HENAN on 2017/11/9.
//  Copyright © 2017年 HENAN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LYSTupleManager.h"

@interface LYSystemManager : NSObject
/**
 获取设备型号信息
 
 @return 返回型号
 */
+ (LYSTuple)ly_deviceString;


@end
