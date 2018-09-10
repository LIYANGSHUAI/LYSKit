//
//  NSArray+LYSCategory.m
//  LYSKitDemo
//
//  Created by HENAN on 2018/9/4.
//  Copyright © 2018年 liyangshuai. All rights reserved.
//

#import "NSArray+LYSCategory.h"

@implementation NSArray (LYSCategory)
- (NSData *)ly_toData
{
    return [NSJSONSerialization dataWithJSONObject:self
                                           options:(NSJSONWritingPrettyPrinted)
                                             error:nil];
}

- (NSString *)ly_toString
{
    return [[NSString alloc] initWithData:[self ly_toData]
                                 encoding:NSUTF8StringEncoding];
}
@end
