//
//  LYSCodeManager.m
//  LYSKitDemo
//
//  Created by HENAN on 2018/10/10.
//  Copyright © 2018年 liyangshuai. All rights reserved.
//

#import "LYSCodeManager.h"

@implementation LYSCodeManager
+ (NSMutableString *)ly_matchingPropertyWithDict:(NSDictionary *)dict
{
    NSMutableString *tempStr = [NSMutableString string];
    [tempStr appendString:@"\n"];
    [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSString *propertyCode = @"";
        if ([obj isKindOfClass:[NSString class]]) {
            propertyCode = [NSString stringWithFormat:@"@property (nonatomic, copy) NSString *%@;",key];
        }
        else if ([obj isKindOfClass:[NSNumber class]]) {
            propertyCode = [NSString stringWithFormat:@"@property (nonatomic, strong) NSNumber *%@;",key];
        }
        else if ([obj isKindOfClass:[NSArray class]]) {
            propertyCode = [NSString stringWithFormat:@"@property (nonatomic, strong) NSArray *%@;",key];
        }
        else if ([obj isKindOfClass:[NSDictionary class]]) {
            propertyCode = [NSString stringWithFormat:@"@property (nonatomic, strong) NSDictionary *%@;",key];
        } else {
            propertyCode = [NSString stringWithFormat:@"@property (nonatomic, <#type#>) <#type#> *%@;",key];
        }
        [tempStr appendFormat:@"%@\n",propertyCode];
    }];
    return tempStr;
}
@end
