//
//  NSDictionary+LYSCategory.h
//  LYSKitDemo
//
//  Created by HENAN on 2017/12/6.
//  Copyright © 2017年 HENAN. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (LYSCategory)

// Convert into a string
- (NSString *)toString;

// Fast print model attribute information
+ (void)printPropertyCodeWithDict:(NSDictionary *)dict;

@end
