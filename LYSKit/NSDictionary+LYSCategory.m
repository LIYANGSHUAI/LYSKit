//
//  NSDictionary+LYSCategory.m
//  LYSKitDemo
//
//  Created by HENAN on 2018/4/20.
//  Copyright © 2018年 liyangshuai. All rights reserved.
//

#import "NSDictionary+LYSCategory.h"

@implementation NSDictionary (LYSCategory)
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
