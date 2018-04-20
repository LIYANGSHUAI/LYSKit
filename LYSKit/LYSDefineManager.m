//
//  LYSDefineManager.m
//  LYSKitDemo
//
//  Created by HENAN on 2018/4/20.
//  Copyright © 2018年 liyangshuai. All rights reserved.
//

#import "LYSDefineManager.h"
#import "sys/utsname.h"

#define DEVICEINFOINTEGRITY @{\
\
@"iPhone1,1":@"iPhone 1G",\
\
@"iPhone1,2":@"iPhone 3G",\
\
@"iPhone2,1":@"iPhone 3GS",\
\
@"iPhone3,1":@"iPhone 4",\
@"iPhone3,2":@"iPhone 4",\
\
@"iPhone4,1":@"iPhone 4S",\
\
@"iPhone5,1":@"iPhone 5",\
@"iPhone5,2":@"iPhone 5 (GSM+CDMA)",\
@"iPhone5,3":@"iPhone 5c (GSM)",\
@"iPhone5,4":@"iPhone 5c (GSM+CDMA)",\
\
@"iPhone6,1":@"iPhone 5s (GSM)",\
@"iPhone6,2":@"iPhone 5s (GSM+CDMA)",\
\
@"iPhone7,1":@"iPhone 6",\
@"iPhone7,2":@"iPhone 6 Plus",\
\
@"iPhone8,1":@"iPhone 6s",\
@"iPhone8,2":@"iPhone 6s Plus",\
@"iPhone8,4":@"iPhone SE",\
\
@"iPhone9,1":@"国行、日版、港行iPhone 7",\
@"iPhone9,2":@"港行、国行iPhone 7 Plus",\
@"iPhone9,3":@"美版、台版iPhone 7",\
@"iPhone9,4":@"美版、台版iPhone 7 Plus",\
\
@"Phone10,1":@"国行(A1863)、日行(A1906)iPhone 8",\
@"Phone10,2":@"国行(A1864)、日行(A1898)iPhone 8 Plus",\
@"Phone10,3":@"国行(A1865)、日行(A1902)iPhone X",\
@"Phone10,4":@"美版(Global/A1905)iPhone 8",\
@"Phone10,5":@"美版(Global/A1897)iPhone 8 Plus",\
@"Phone10,6":@"美版(Global/A1901)iPhone X",\
\
@"iPod1,1":@"iPod Touch 1G",\
\
@"iPod2,1":@"iPod Touch 2G",\
\
@"iPod3,1":@"iPod Touch 3G",\
\
@"iPod4,1":@"iPod Touch 4G",\
\
@"iPod5,1":@"iPod Touch (5 Gen)",\
\
@"iPad1,1":@"iPad",\
@"iPad1,2":@"iPad 3G",\
\
@"iPad2,1":@"iPad 2 (WiFi)",\
@"iPad2,2":@"iPad 2",\
@"iPad2,3":@"iPad 2 (CDMA)",\
@"iPad2,4":@"iPad 2",\
@"iPad2,5":@"iPad Mini (WiFi)",\
@"iPad2,6":@"iPad Mini",\
@"iPad2,7":@"iPad Mini (GSM+CDMA)",\
\
@"iPad3,1":@"iPad 3 (WiFi)",\
@"iPad3,2":@"iPad 3 (GSM+CDMA)",\
@"iPad3,3":@"iPad 3",\
@"iPad3,4":@"iPad 4 (WiFi)",\
@"iPad3,5":@"iPad 4",\
@"iPad3,6":@"iPad 4 (GSM+CDMA)",\
\
@"iPad4,1":@"iPad Air (WiFi)",\
@"iPad4,2":@"iPad Air (Cellular)",\
@"iPad4,4":@"iPad Mini 2 (WiFi)",\
@"iPad4,5":@"iPad Mini 2 (Cellular)",\
@"iPad4,6":@"iPad Mini 2",\
@"iPad4,7":@"iPad Mini 3",\
@"iPad4,8":@"iPad Mini 3",\
@"iPad4,9":@"iPad Mini 3",\
\
@"iPad5,1":@"iPad Mini 4 (WiFi)",\
@"iPad5,2":@"iPad Mini 4 (LTE)",\
@"iPad5,3":@"iPad Air 2",\
@"iPad5,4":@"iPad Air 2",\
\
@"iPad6,3":@"iPad Pro 9.7",\
@"iPad6,4":@"iPad Pro 9.7",\
@"iPad6,7":@"iPad Pro 12.9",\
@"iPad6,8":@"iPad Pro 12.9",\
@"iPad6,11":@"iPad 5 (WiFi)",\
@"iPad6,12":@"iPad 5 (Cellular)",\
\
@"iPad7,1": @"iPad Pro 12.9 inch 2nd gen (WiFi)",\
@"iPad7,2": @"iPad Pro 12.9 inch 2nd gen (Cellular)",\
@"iPad7,3": @"iPad Pro 10.5 inch (WiFi)",\
@"iPad7,4": @"iPad Pro 10.5 inch (Cellular)",\
\
@"AppleTV2,1":@"Apple TV 2",\
@"AppleTV3,1":@"Apple TV 3",\
@"AppleTV3,2":@"Apple TV 3",\
@"AppleTV5,3":@"Apple TV 4",\
\
@"i386":@"Simulator",\
@"x86_64":@"Simulator",\
\
}\

#define DEVICEINFOSIMPLENESS @{\
\
@"iPhone1,1":@"iPhone 1G",\
\
@"iPhone1,2":@"iPhone 3G",\
\
@"iPhone2,1":@"iPhone 3GS",\
\
@"iPhone3,1":@"iPhone 4",\
@"iPhone3,2":@"iPhone 4",\
\
@"iPhone4,1":@"iPhone 4S",\
\
@"iPhone5,1":@"iPhone 5",\
@"iPhone5,2":@"iPhone 5",\
@"iPhone5,3":@"iPhone 5c",\
@"iPhone5,4":@"iPhone 5c",\
\
@"iPhone6,1":@"iPhone 5s",\
@"iPhone6,2":@"iPhone 5s",\
\
@"iPhone7,1":@"iPhone 6",\
@"iPhone7,2":@"iPhone 6 Plus",\
\
@"iPhone8,1":@"iPhone 6s",\
@"iPhone8,2":@"iPhone 6s Plus",\
@"iPhone8,4":@"iPhone SE",\
\
@"iPhone9,1":@"iPhone 7",\
@"iPhone9,2":@"iPhone 7 Plus",\
@"iPhone9,3":@"iPhone 7",\
@"iPhone9,4":@"Phone 7 Plus",\
\
@"Phone10,1":@"iPhone 8",\
@"Phone10,2":@"iPhone 8 Plus",\
@"Phone10,3":@"iPhone X",\
@"Phone10,4":@"iPhone 8",\
@"Phone10,5":@"iPhone 8 Plus",\
@"Phone10,6":@"iPhone X",\
\
@"iPod1,1":@"iPod Touch 1G",\
\
@"iPod2,1":@"iPod Touch 2G",\
\
@"iPod3,1":@"iPod Touch 3G",\
\
@"iPod4,1":@"iPod Touch 4G",\
\
@"iPod5,1":@"iPod Touch (5 Gen)",\
\
@"iPad1,1":@"iPad",\
@"iPad1,2":@"iPad 3G",\
\
@"iPad2,1":@"iPad 2",\
@"iPad2,2":@"iPad 2",\
@"iPad2,3":@"iPad 2",\
@"iPad2,4":@"iPad 2",\
@"iPad2,5":@"iPad Mini",\
@"iPad2,6":@"iPad Mini",\
@"iPad2,7":@"iPad Mini",\
\
@"iPad3,1":@"iPad 3",\
@"iPad3,2":@"iPad 3",\
@"iPad3,3":@"iPad 3",\
@"iPad3,4":@"iPad 4",\
@"iPad3,5":@"iPad 4",\
@"iPad3,6":@"iPad 4",\
\
@"iPad4,1":@"iPad Air",\
@"iPad4,2":@"iPad Air",\
@"iPad4,4":@"iPad Mini 2",\
@"iPad4,5":@"iPad Mini 2",\
@"iPad4,6":@"iPad Mini 2",\
@"iPad4,7":@"iPad Mini 3",\
@"iPad4,8":@"iPad Mini 3",\
@"iPad4,9":@"iPad Mini 3",\
\
@"iPad5,1":@"iPad Mini 4",\
@"iPad5,2":@"iPad Mini 4",\
@"iPad5,3":@"iPad Air 2",\
@"iPad5,4":@"iPad Air 2",\
\
@"iPad6,3":@"iPad Pro 9.7",\
@"iPad6,4":@"iPad Pro 9.7",\
@"iPad6,7":@"iPad Pro 12.9",\
@"iPad6,8":@"iPad Pro 12.9",\
@"iPad6,11":@"iPad 5",\
@"iPad6,12":@"iPad 5",\
\
@"iPad7,1": @"iPad Pro 12.9",\
@"iPad7,2": @"iPad Pro 12.9",\
@"iPad7,3": @"iPad Pro 10.5",\
@"iPad7,4": @"iPad Pro 10.5",\
\
@"AppleTV2,1":@"Apple TV 2",\
@"AppleTV3,1":@"Apple TV 3",\
@"AppleTV3,2":@"Apple TV 3",\
@"AppleTV5,3":@"Apple TV 4",\
\
@"i386":@"Simulator",\
@"x86_64":@"Simulator",\
\
}\

@implementation LYSDefineManager
#pragma mark - 系统信息获取 -
// 获取完整设备型号
+ (NSString *)ly_deviceStringIntegrity
{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    return [[DEVICEINFOINTEGRITY allKeys] containsObject:platform] ? DEVICEINFOSIMPLENESS[platform] : @"未知";
}
// 获取简单设备型号
+ (NSString *)ly_deviceStringSimpleness
{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    return [[DEVICEINFOSIMPLENESS allKeys] containsObject:platform] ? DEVICEINFOSIMPLENESS[platform] : @"未知";
}
// 获取当前设备别名
+ (NSString *)ly_userPhoneName
{
    return [[UIDevice currentDevice] name];
}
// 获取当前设备名称
+ (NSString *)ly_deviceName
{
    return [[UIDevice currentDevice] systemName];
}
// 获取当前设备型号
+ (NSString *)ly_deviceModel
{
    return [[UIDevice currentDevice] model];
}
// 获取当前设备国际化区域名称
+ (NSString *)ly_deviceLocalModel
{
    return [[UIDevice currentDevice] localizedModel];
}
// 获取当前App名称
+ (NSString *)ly_projectName
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"];
}
// 获取App对外版本号
+ (NSString *)ly_appCurVersion
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}
// 获取当前APP的build
+ (NSString *)ly_appCurVersionBuild
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
}
// 获取当前设备系统版本
+ (NSString *)ly_systemVersion
{
    return [[UIDevice currentDevice] systemVersion];
}

#pragma mark - 版本信息判断 -

// 版本之后
+ (BOOL)ly_laterIOS:(CGFloat)index
{
    return [[[UIDevice currentDevice] systemVersion] floatValue] >= index;
}
// 版本之前
+ (BOOL)ly_beforeIOS:(CGFloat)index
{
    return [[[UIDevice currentDevice] systemVersion] floatValue] < index;
}
// 是否是IPhoneX
+ (BOOL)ly_isIPhoneX
{
    return [[self ly_deviceStringSimpleness] containsString:@"iPhone X"];
}

#pragma mark - 获取UI -
// 获取application
+ (UIApplication *)ly_application
{
    return [UIApplication sharedApplication];
}
// 获取window
+ (UIWindow *)ly_keyWindow
{
    return [UIApplication sharedApplication].keyWindow;
}
// 获取屏幕
+ (UIScreen *)ly_mainScreen
{
    return [UIScreen mainScreen];
}
// 获取屏幕尺寸
+ (CGSize)ly_screenSize
{
    return [UIScreen mainScreen].bounds.size;
}
// 屏幕适配
+ (CGFloat)ly_adaptation_H
{
    return [UIScreen mainScreen].bounds.size.height / 667.0;
}
+ (CGFloat)ly_adaptation_W
{
    return [UIScreen mainScreen].bounds.size.width / 375.0;
}
+ (CGFloat)ly_layoutWidth:(CGFloat)w
{
    return [self ly_adaptation_W] * w;
}
+ (CGFloat)ly_layoutHeight:(CGFloat)h
{
    return [self ly_adaptation_H] * h;
}
+ (CGFloat)ly_degreesToRadians:(CGFloat)degrees
{
    return (3.14159265359 * degrees)/ 180;
}
+ (uint32_t)ly_randomA:(uint32_t)A B:(uint32_t)B
{
    return arc4random() % (B - A) + A;
}
+ (uint32_t)ly_random_uniformA:(uint32_t)A B:(uint32_t)B
{
    return arc4random_uniform(B - A) + A;
}
// 字体
+ (UIFont *)ly_font:(CGFloat)font auto:(BOOL)adaptation
{
    if (adaptation) {
        return [UIFont systemFontOfSize:[self ly_layoutWidth:font]];
    } else {
        return [UIFont systemFontOfSize:font];
    }
}
// 颜色
+ (UIColor *)ly_rgbaR:(CGFloat)r g:(CGFloat)g b:(CGFloat)b a:(CGFloat)a
{
    return [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a];
}
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
