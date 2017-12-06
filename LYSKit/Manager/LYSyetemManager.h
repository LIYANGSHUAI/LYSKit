//
//  LYSyetemManager.h
//  LYSKitDemo
//
//  Created by HENAN on 2017/12/5.
//  Copyright © 2017年 HENAN. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "LYSTupleManager.h"

@interface LYSystemManager : NSObject

/**
 Get the current device model information
 
 @return the LYSTuple class
 */
+ (LYSTuple)deviceString;

@end
