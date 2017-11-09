//
//  LYSDefineManager.h
//  LYSKitDemo
//
//  Created by HENAN on 2017/11/9.
//  Copyright © 2017年 HENAN. All rights reserved.
//

#ifndef LYSDefineManager_h
#define LYSDefineManager_h

#import "LYSystemManager.h"

#pragma mark - 获取当前设备型号 -
#define LYSDeviceString [LYSystemManager ly_deviceString]

#pragma mark - 获取当前设备别名 -
#define LYSUserPhoneName [[UIDevice currentDevice] name]

#pragma mark - 获取当前设备名称 -
#define LYSDeviceName [[UIDevice currentDevice] systemName]

#pragma mark - 获取当前设备型号 -
#define LYSDeviceModel [[UIDevice currentDevice] model]

#pragma mark - 获取当前设备国际化区域名称 -
#define LYSDeviceLocalModel [[UIDevice currentDevice] localizedModel]

#pragma mark - 获取当前APP名称 -
#define LYSProjectName [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"]

#pragma mark - 获取当前APP对外版本号 -
#define LYSAppCurVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

#pragma mark - 获取当前APP的build -
#define LYSAppCurVersionBuild [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]

#pragma mark - 获取当前设备系统版本 -
#define LYSystemVersion [[UIDevice currentDevice] systemVersion]

#pragma mark - 版本的判断 -
#define LYSLaterIOS(A) ([[[UIDevice currentDevice] systemVersion] floatValue] >= A)
#define LYSBeforeIOS(A) ([[[UIDevice currentDevice] systemVersion] floatValue] < A)
#define LYSISIPhone_X ([[NSMutableString stringWithString:LYSDeviceString.one] containsString:@"iPhone X"])

#pragma mark - 获取当前运行的应用程序 -
#define LYSApplication ([UIApplication sharedApplication])

#pragma mark - 获取当前运行的应用程序的代理类 -
#define LYSAppDelegate ((AppDelegate *)[UIApplication sharedApplication].delegate)

#pragma mark - 获取当前手机显示的主Window -
#define LYSKeyWindow ([UIApplication sharedApplication].keyWindow)

#pragma mark - 获取当前手机的屏幕 -
#define LYSMainScreen ([UIScreen mainScreen])

#pragma mark - 获取当前手机屏幕尺寸 -
#define LYScreenSize ([UIScreen mainScreen].bounds.size)

#pragma mark - 屏幕适配,以6s屏幕大小为基准 -
#define LYSAdaptation_H (LYScreenSize.height / 667.0)
#define LYSAdaptation_W (LYScreenSize.width / 375.0)
#define LYSLayoutWith(A) (A * LYSAdaptation_W)
#define LYSLayoutHeight(A) (A * LYSAdaptation_H)

#pragma mark - 本地存储对象 -
#define LYSUserDefaults [NSUserDefaults standardUserDefaults]

#pragma mark - 本地存储键值对 -
#define LYSetObjectUserDefaults(Key,Value) [[NSUserDefaults standardUserDefaults] setObject:Value forKey:Key]
#define LYSetBoolUserDefaults(Key,Value) [[NSUserDefaults standardUserDefaults] setBool:Value forKey:Key]

#pragma mark - 本地获取键值对 -
#define LYSGetObjectUserDefaults(Key) [[NSUserDefaults standardUserDefaults] objectForKey:Key]
#define LYSGetBoolUserDefaults(Key) [[NSUserDefaults standardUserDefaults] boolForKey:Key]

#pragma mark - 移除某键值对 -
#define LYSRemoveKeyUserDefaults(Key) [[NSUserDefaults standardUserDefaults] removeObjectForKey:Key]

#pragma mark - 同步数据 -
#define LYSynchronizeUserDefaults [[NSUserDefaults standardUserDefaults] synchronize];

#pragma mark - 对循环引用的解决办法 -
#define LYSWeakSelf(type)  __weak typeof(type) weak##type = type;
#define LYStrongSelf(type)  __strong typeof(type) type = weak##type;

#pragma mark - 角度转换 -
#define LYSDegreesToRadians(degrees)  ((3.14159265359 * degrees)/ 180)

#pragma mark - 随机数 -
#define LYSRandom(A,B)         (arc4random() % (B - A) + A)
#define LYSRandom_uniform(A,B) (arc4random_uniform(B) + A)

#pragma mark - Runtime给一个对象添加关联属性 -
#define LYSetAssociatedObject(OBJECT,KEY,VALUE,OBJC_ASSOCIATION) objc_setAssociatedObject(OBJECT, KEY, VALUE, OBJC_ASSOCIATION);

#pragma mark - Runtime获取一个对象的关联属性 -
#define LYSGetAssociatedObject(OBJECT,KEY) objc_getAssociatedObject(OBJECT, KEY)

#pragma mark - Runtime移除一个对象的所有关联属性 -
#define LYSRemoveAssociatedObjects(OBJECT) objc_removeAssociatedObjects(OBJECT)

#pragma mark - 字体大小 -
#define LYSFONT(A) [UIFont systemFontOfSize:A]

#pragma mark - 带有透明度的RGB格式和颜色转换 -
#define LYSRGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]

#pragma mark - 透明度默认是1.0的RGB格式和颜色转换 -
#define LYSRGB(r,g,b) LYSRGBA(r,g,b,1.0f)

#pragma mark - 颜色字符串转换为对应的颜色 -
#define LYSHEX(str)  [UIColor ly_hex:str]

#pragma mark - 改写打印函数,使其在特定的条件下执行 -
#ifdef DEBUG
#define LYSNSLog(...) NSLog(@"%s 第%d行 \n %@\n\n",__func__,__LINE__,[NSString stringWithFormat:__VA_ARGS__])
#else
#define LYSNSLog(...)
#endif

#pragma mark - 元组 -
#define LYSTuple(ONE,TWO) [LYSTupleManager ly_create:ONE two:TWO]

#import <objc/runtime.h>
#pragma mark - 屏幕旋转选择项 -
typedef NS_ENUM(NSInteger,LYSupportedOrientation) {
    LYSupportedOrientationMaskPortrait,      // 只允许home在下,即不支持旋转
    LYSupportedOrientationMaskLandscapeLeft, // 支持home在右旋转
    LYSupportedOrientationMaskLandscapeRight,// 支持home在左旋转
    LYSupportedOrientationMaskAll,           // 支持以上三种方式旋转
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


#endif /* LYSDefineManager_h */
