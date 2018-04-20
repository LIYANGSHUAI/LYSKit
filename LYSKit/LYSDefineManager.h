//
//  LYSDefineManager.h
//  LYSKitDemo
//
//  Created by HENAN on 2018/4/20.
//  Copyright © 2018年 liyangshuai. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark - 获取完整设备型号 -
#define LYSDeviceStringIntegrity               [LYSDefineManager ly_deviceStringIntegrity]

#pragma mark - 获取简单设备型号 -
#define LYSDeviceStringSimpleness              [LYSDefineManager ly_deviceStringSimpleness]

#pragma mark - 获取当前设备别名 -
#define LYSUserPhoneName                       [LYSDefineManager ly_userPhoneName]

#pragma mark - 获取当前设备名称 -
#define LYSDeviceName                          [LYSDefineManager ly_deviceName]

#pragma mark - 获取当前设备型号 -
#define LYSDeviceModel                         [LYSDefineManager ly_deviceModel]

#pragma mark - 获取当前设备国际化区域名称 -
#define LYSDeviceLocalModel                    [LYSDefineManager ly_deviceLocalModel]

#pragma mark - 获取当前APP名称 -
#define LYSProjectName                         [LYSDefineManager ly_projectName]

#pragma mark - 获取当前APP对外版本号 -
#define LYSAppCurVersion                       [LYSDefineManager ly_appCurVersion]

#pragma mark - 获取当前APP的build -
#define LYSAppCurVersionBuild                  [LYSDefineManager ly_appCurVersionBuild]

#pragma mark - 获取当前设备系统版本 -
#define LYSystemVersion                        [LYSDefineManager ly_systemVersion]

#pragma mark - 版本的判断 -
#define LYSLaterIOS(A)                         [LYSDefineManager ly_laterIOS:A]
#define LYSBeforeIOS(A)                        [LYSDefineManager ly_beforeIOS:A]
#define LYSISIPhone_X                          [LYSDefineManager ly_systemVersion]


#pragma mark - 获取当前运行的应用程序 -
#define LYSApplication                         [LYSDefineManager ly_application]

#pragma mark - 获取当前手机显示的主Window -
#define LYSKeyWindow                           [LYSDefineManager ly_keyWindow]

#pragma mark - 获取当前手机的屏幕 -
#define LYSMainScreen                          [LYSDefineManager ly_mainScreen]

#pragma mark - 获取当前手机屏幕尺寸 -
#define LYScreenSize                           [LYSDefineManager ly_screenSize]

#pragma mark - 屏幕适配,以6s屏幕大小为基准 -
#define LYSAdaptation_H                        [LYSDefineManager ly_adaptation_H]
#define LYSAdaptation_W                        [LYSDefineManager ly_adaptation_W]
#define LYSLayoutWith(A)                       [LYSDefineManager ly_layoutWidth:A]
#define LYSLayoutHeight(A)                     [LYSDefineManager ly_layoutHeight:A]

#pragma mark - 角度转换 -
#define LYSDegreesToRadians(degrees)           [LYSDefineManager ly_degreesToRadians:degrees]

#pragma mark - 随机数 -
#define LYSRandom(start,end)                   [LYSDefineManager ly_randomA:start B:end]
#define LYSRandom_uniform(start,end)           [LYSDefineManager ly_random_uniformA:start B:end]

#pragma mark - 字体大小 -
#define LYSFONT(A,B)                           [LYSDefineManager ly_font:A auto:B]

#pragma mark - 带有透明度的RGB格式和颜色转换 -
#define LYSRGBA(r,g,b,a)                       [LYSDefineManager ly_rgbaR:r g:g b:b a:a]

#pragma mark - 透明度默认是1.0的RGB格式和颜色转换 -
#define LYSRGB(r,g,b)                          LYSRGBA(r,g,b,1.0f)

#pragma mark - 颜色字符串转换为对应的颜色 -
#define LYSHEX(str)                            [LYSDefineManager ly_hex:str]

#pragma mark - 默认背景颜色 -
#define LYSCommonBackgroundColor               LYSRGB(238,238,238)
#define LYSPartingLineColor                    LYSRGB(221,221,221)

#pragma mark - 默认主标题字体颜色 -
#define LYStrikingFontColor                    LYSRGB(85,85,85)

#pragma mark - 默认副标题字体颜色 -
#define LYSExplainFontColor                    LYSRGB(170,170,170)

#pragma mark - 默认导航背景颜色 -
#define LYSNavigationColor                     LYSRGB(51,51,51)

#pragma mark - 默认点击链接颜色 -
#define LYSOnlineFontColor                     LYSRGB(0,153,204)

#pragma mark - 默认边框颜色 -
#define LYSBorderColor                         LYSRGB(187,187,187)

#pragma mark - 对循环引用的解决办法 -
#define LYSWeakSelf(type)  __weak typeof(type) weak##type = type;
#define LYStrongSelf(type)  __strong typeof(type) type = weak##type;

#pragma mark - 改写打印函数,使其在特定的条件下执行 -
#ifdef DEBUG
#define LYSNSLog(...) NSLog(@"%s 第%d行 \n %@\n\n",__func__,__LINE__,[NSString stringWithFormat:__VA_ARGS__])
#else
#define LYSNSLog(...)
#endif

#pragma mark - 屏幕旋转选择项 -
typedef NS_ENUM(NSInteger,LYSupportedOrientation) {
    LYSupportedOrientationMaskPortrait,                       // 只允许home在下,即不支持旋转
    LYSupportedOrientationMaskLandscapeLeft,                  // 支持home在右旋转
    LYSupportedOrientationMaskLandscapeRight,                 // 支持home在左旋转
    LYSupportedOrientationMaskAll,                            // 支持以上三种方式旋转
};

#pragma mark - 控制屏幕旋转 -
#define LYSOrientationAndDefaultOrientation(A) \
-(UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window{\
static dispatch_once_t onceToken;\
dispatch_once(&onceToken, ^{\
objc_setAssociatedObject(application.delegate, @"orientation", @(A), OBJC_ASSOCIATION_RETAIN_NONATOMIC);\
});\
NSInteger supportedOrientation = [objc_getAssociatedObject(application.delegate, @"orientation") integerValue];\
switch (supportedOrientation) {\
case 0:\
return UIInterfaceOrientationMaskPortrait;\
break;\
case 1:\
{\
switch ([UIDevice currentDevice].orientation) {\
case UIDeviceOrientationLandscapeLeft:\
return UIInterfaceOrientationMaskLandscapeRight;\
break;\
default:\
return UIInterfaceOrientationMaskPortrait;\
break;\
}\
}\
break;\
case 2:\
{\
switch ([UIDevice currentDevice].orientation) {\
case UIDeviceOrientationLandscapeRight:\
return UIInterfaceOrientationMaskLandscapeLeft;\
break;\
default:\
return UIInterfaceOrientationMaskPortrait;\
break;\
}\
}\
break;\
case 3:\
{\
switch ([UIDevice currentDevice].orientation) {\
case UIDeviceOrientationLandscapeRight:\
return UIInterfaceOrientationMaskLandscapeLeft;\
break;\
case UIDeviceOrientationLandscapeLeft:\
return UIInterfaceOrientationMaskLandscapeRight;\
break;\
default:\
return UIInterfaceOrientationMaskPortrait;\
break;\
}\
}\
break;\
default:\
return UIInterfaceOrientationMaskPortrait;\
break;\
}\
}

#pragma mark - 设置屏幕旋转 -
#define LYSOrientation(A) objc_setAssociatedObject(([UIApplication sharedApplication].delegate), @"orientation", @(A), OBJC_ASSOCIATION_RETAIN_NONATOMIC)

@interface LYSDefineManager : NSObject

#pragma mark - 系统信息获取 -

// 获取完整设备型号
+ (NSString *)ly_deviceStringIntegrity;
// 获取简单设备型号
+ (NSString *)ly_deviceStringSimpleness;
// 获取当前设备别名
+ (NSString *)ly_userPhoneName;
// 获取当前设备名称
+ (NSString *)ly_deviceName;
// 获取当前设备型号
+ (NSString *)ly_deviceModel;
// 获取当前设备国际化区域名称
+ (NSString *)ly_deviceLocalModel;
// 获取当前App名称
+ (NSString *)ly_projectName;
// 获取App对外版本号
+ (NSString *)ly_appCurVersion;
// 获取当前APP的build
+ (NSString *)ly_appCurVersionBuild;
// 获取当前设备系统版本
+ (NSString *)ly_systemVersion;

#pragma mark - 版本信息判断 -

// 版本之后
+ (BOOL)ly_laterIOS:(CGFloat)index;
// 版本之前
+ (BOOL)ly_beforeIOS:(CGFloat)index;
// 是否是IPhoneX
+ (BOOL)ly_isIPhoneX;

#pragma mark - 获取UI -

// 获取application
+ (UIApplication *)ly_application;
// 获取window
+ (UIWindow *)ly_keyWindow;
// 获取屏幕
+ (UIScreen *)ly_mainScreen;
// 获取屏幕尺寸
+ (CGSize)ly_screenSize;
// 屏幕适配
+ (CGFloat)ly_adaptation_H;
+ (CGFloat)ly_adaptation_W;
+ (CGFloat)ly_layoutWidth:(CGFloat)w;
+ (CGFloat)ly_layoutHeight:(CGFloat)h;

// 角度转换
+ (CGFloat)ly_degreesToRadians:(CGFloat)degrees;

// 随机数
+ (uint32_t)ly_randomA:(uint32_t)A B:(uint32_t)B;
+ (uint32_t)ly_random_uniformA:(uint32_t)A B:(uint32_t)B;

// 字体
+ (UIFont *)ly_font:(CGFloat)font auto:(BOOL)adaptation;
// 颜色
+ (UIColor *)ly_rgbaR:(CGFloat)r g:(CGFloat)g b:(CGFloat)b a:(CGFloat)a;
+ (UIColor *)ly_hex:(NSString *)hexStr;
@end
