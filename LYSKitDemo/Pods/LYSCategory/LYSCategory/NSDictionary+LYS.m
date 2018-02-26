//
//  NSDictionary+LYS.m
//  LYSKit
//
//  Created by HENAN on 2018/2/26.
//  Copyright © 2018年 liyangshuai. All rights reserved.
//

#import "NSDictionary+LYS.h"

@implementation NSDictionary (LYS)

- (NSData *)ly_toData
{
    return [NSJSONSerialization dataWithJSONObject:self options:(NSJSONWritingPrettyPrinted) error:nil];
}

- (NSString *)ly_toString
{
    return [[NSString alloc] initWithData:[self ly_toData] encoding:NSUTF8StringEncoding];
}

@end
