//
//  UIColor+LYSCategory.m
//  LYSKitDemo
//
//  Created by HENAN on 2017/11/9.
//  Copyright © 2017年 HENAN. All rights reserved.
//

#import "UIColor+LYSCategory.h"
//#pragma mark - 颜色字符串转换为对应的颜色 -
//#define LYS_Implementation_HEX(str)\
//({\
//UIColor *color = nil;\
//NSString *hexColor = str;\
//hexColor = [hexColor stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];\
//if ([hexColor length] < 6) {color = nil;}else{\
//if ([hexColor hasPrefix:@"#"]) {hexColor = [hexColor substringFromIndex:1];}\
//NSString *red = [hexColor substringWithRange:NSMakeRange(0, 2)];\
//NSString *green = [hexColor substringWithRange:NSMakeRange(2, 2)];\
//NSString *blue = [hexColor substringWithRange:NSMakeRange(4, 2)];\
//unsigned int r, g ,b , a;\
//[[NSScanner scannerWithString:red] scanHexInt:&r];\
//[[NSScanner scannerWithString:green] scanHexInt:&g];\
//[[NSScanner scannerWithString:blue] scanHexInt:&b];\
//if ([hexColor length] == 8) {\
//NSString *as = [hexColor substringWithRange:NSMakeRange(4, 2)];\
//[[NSScanner scannerWithString:as] scanHexInt:&a];\
//}else {\
//a = 255;\
//}\
//color = [UIColor colorWithRed:(float)r / 255.0 green:(float)g / 255.0 blue:(float)b / 255.0 alpha:(float)a / 255.0];\
//}\
//(color);\
//})
@implementation UIColor (LYSCategory)
+ (UIColor *)ly_hex:(NSString *)hexStr
{
    UIColor *color = nil;
    NSString *hexColor = hexStr;
    hexColor = [hexColor stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if ([hexColor length] < 6) {color = nil;}else
    {
        if ([hexColor hasPrefix:@"#"]) {hexColor = [hexColor substringFromIndex:1];}
        NSString *red = [hexColor substringWithRange:NSMakeRange(0, 2)];
        NSString *green = [hexColor substringWithRange:NSMakeRange(2, 2)];
        NSString *blue = [hexColor substringWithRange:NSMakeRange(4, 2)];
        unsigned int r, g ,b , a;
        [[NSScanner scannerWithString:red] scanHexInt:&r];
        [[NSScanner scannerWithString:green] scanHexInt:&g];
        [[NSScanner scannerWithString:blue] scanHexInt:&b];
        if ([hexColor length] == 8)
        {
            NSString *as = [hexColor substringWithRange:NSMakeRange(4, 2)];
            [[NSScanner scannerWithString:as] scanHexInt:&a];
        }else
        {
            a = 255;
        }
        color = [UIColor colorWithRed:(float)r / 255.0 green:(float)g / 255.0 blue:(float)b / 255.0 alpha:(float)a / 255.0];
    }
    return color;
}
@end
