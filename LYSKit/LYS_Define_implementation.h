//
//  LYS_Define_implementation.h
//  LYSKit
//
//  Created by HENAN on 2017/9/22.
//  Copyright © 2017年 个人开发实用框架. All rights reserved.
//


#import <objc/runtime.h>
#import "LYS_BaseObjc.h"

#pragma mark - 获取当前设备系统版本 -
#define LYS_Implementation_SystemVersion [[UIDevice currentDevice] systemVersion]

#pragma mark - 版本的判断 -
#define LYS_Implementation_LaterIOS(A) ([[[UIDevice currentDevice] systemVersion] floatValue] >= A)
#define LYS_Implementation_BeforeIOS(A) ([[[UIDevice currentDevice] systemVersion] floatValue] < A)
#define LYS_Implementation_iPhone_X ([[NSMutableString stringWithString:[LYSystemManager deviceString].one] containsString:@"iPhone X"])

#pragma mark - 获取当前运行的应用程序 -
#define LYS_Implementation_Application ([UIApplication sharedApplication])

#pragma mark - 获取当前运行的应用程序的代理类 -
#define LYS_Implementation_AppDelegate ((AppDelegate *)[UIApplication sharedApplication].delegate)

#pragma mark - 获取当前手机显示的主Window -
#define LYS_Implementation_KeyWindow ([UIApplication sharedApplication].keyWindow)

#pragma mark - 获取当前手机的屏幕 -
#define LYS_Implementation_MainScreen ([UIScreen mainScreen])

#pragma mark - 获取当前手机屏幕尺寸 -
#define LYS_Implementation_ScreenSize ([UIScreen mainScreen].bounds.size)

//*********************************************************************
//*********************************************************************

#pragma mark - 屏幕适配,以6s屏幕大小为基准 -
#define LYS_Implementation_Adaptation_H (LY_KScreenSize.height / 667.0)
#define LYS_Implementation_Adaptation_W (LY_KScreenSize.width / 375.0)
#define LYS_Implementation_LayoutWith(A) (A * LYS_Implementation_Adaptation_W)
#define LYS_Implementation_LayoutHeight(A) (A * LYS_Implementation_Adaptation_H)

//*********************************************************************
//*********************************************************************

#pragma mark - 本地存储对象 -
#define LYS_Implementation_UserDefaults [NSUserDefaults standardUserDefaults]

#pragma mark - 本地存储键值对 -
#define LYS_Implementation_SetObjectUserDefaults(Key,Value) [[NSUserDefaults standardUserDefaults] setObject:Value forKey:Key]
#define LYS_Implementation_SetBoolUserDefaults(Key,Value) [[NSUserDefaults standardUserDefaults] setBool:Value forKey:Key]

#pragma mark - 本地获取键值对 -
#define LYS_Implementation_GetObjectUserDefaults(Key) [[NSUserDefaults standardUserDefaults] objectForKey:Key]
#define LYS_Implementation_GetBoolUserDefaults(Key) [[NSUserDefaults standardUserDefaults] boolForKey:Key]

#pragma mark - 移除某键值对 -
#define LYS_Implementation_RemoveKeyUserDefaults(Key) [[NSUserDefaults standardUserDefaults] removeObjectForKey:Key]

#pragma mark - 同步数据 -
#define LYS_Implementation_SynchronizeUserDefaults [[NSUserDefaults standardUserDefaults] synchronize];

//*********************************************************************
//*********************************************************************

#pragma mark - 对循环引用的解决办法 -
#define LYS_Implementation_WeakSelf(type)  __weak typeof(type) weak##type = type;
#define LYS_Implementation_StrongSelf(type)  __strong typeof(type) type = weak##type;

//*********************************************************************
//*********************************************************************

#pragma mark - 角度转换 -
#define LYS_Implementation_DegreesToRadians(degrees)  ((3.14159265359 * degrees)/ 180)

//*********************************************************************
//*********************************************************************

#pragma mark - 随机数 -
#define LYS_Implementation_Random(A,B)         (arc4random() % (B - A) + A)
#define LYS_Implementation_Random_uniform(A,B) (arc4random_uniform(B) + A)

//*********************************************************************
//*********************************************************************

#pragma mark - Runtime给一个对象添加关联属性 -
#define LYS_Implementation_SetAssociatedObject(OBJECT,KEY,VALUE,OBJC_ASSOCIATION) objc_setAssociatedObject(OBJECT, KEY, VALUE, OBJC_ASSOCIATION);

#pragma mark - Runtime获取一个对象的关联属性 -
#define LYS_Implementation_GetAssociatedObject(OBJECT,KEY) objc_getAssociatedObject(OBJECT, KEY)

#pragma mark - Runtime移除一个对象的所有关联属性 -
#define LYS_Implementation_RemoveAssociatedObjects(OBJECT) objc_removeAssociatedObjects(OBJECT)

//*********************************************************************
//*********************************************************************

#pragma mark - 字体大小 -
#define LYS_Implementation_FONT(A) [UIFont systemFontOfSize:A]

#pragma mark - 带有透明度的RGB格式和颜色转换 -
#define LYS_Implementation_RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]

#pragma mark - 透明度默认是1.0的RGB格式和颜色转换 -
#define LYS_Implementation_RGB(r,g,b) LY_RGBA(r,g,b,1.0f)

#pragma mark - 颜色字符串转换为对应的颜色 -
#define LYS_Implementation_HEX(str)\
({\
UIColor *color = nil;\
NSString *hexColor = str;\
hexColor = [hexColor stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];\
if ([hexColor length] < 6) {color = nil;}else{\
if ([hexColor hasPrefix:@"#"]) {hexColor = [hexColor substringFromIndex:1];}\
NSString *red = [hexColor substringWithRange:NSMakeRange(0, 2)];\
NSString *green = [hexColor substringWithRange:NSMakeRange(2, 2)];\
NSString *blue = [hexColor substringWithRange:NSMakeRange(4, 2)];\
unsigned int r, g ,b , a;\
[[NSScanner scannerWithString:red] scanHexInt:&r];\
[[NSScanner scannerWithString:green] scanHexInt:&g];\
[[NSScanner scannerWithString:blue] scanHexInt:&b];\
if ([hexColor length] == 8) {\
NSString *as = [hexColor substringWithRange:NSMakeRange(4, 2)];\
[[NSScanner scannerWithString:as] scanHexInt:&a];\
}else {\
a = 255;\
}\
color = [UIColor colorWithRed:(float)r / 255.0 green:(float)g / 255.0 blue:(float)b / 255.0 alpha:(float)a / 255.0];\
}\
(color);\
})

//*********************************************************************
//*********************************************************************

#pragma mark - 改写打印函数,使其在特定的条件下执行 -
#ifdef DEBUG
#define LYS_Implementation_NSLog(...) NSLog(@"%s 第%d行 \n %@\n\n",__func__,__LINE__,[NSString stringWithFormat:__VA_ARGS__])
#else
#define LYS_Implementation_NSLog(...)
#endif

//*********************************************************************
//*********************************************************************

#pragma mark - 屏幕旋转选择项 -
typedef NS_ENUM(NSInteger,LYSupportedOrientation) {
    LYSupportedOrientationMaskPortrait,      // 只允许home在下,即不支持旋转
    LYSupportedOrientationMaskLandscapeLeft, // 支持home在右旋转
    LYSupportedOrientationMaskLandscapeRight,// 支持home在左旋转
    LYSupportedOrientationMaskAll,           // 支持以上三种方式旋转
};

#pragma mark - 控制屏幕旋转 -
#define LYS_Implementation_OrientationAndDefaultOrientation(A) \
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
#define LYS_Implementation_Orientation(A) objc_setAssociatedObject(([UIApplication sharedApplication].delegate), @"orientation", @(A), OBJC_ASSOCIATION_RETAIN_NONATOMIC)


#pragma mark - 约束 -
#define LYS_Implementation_Equal   NSLayoutRelationEqual
#define LYS_Implementation_Top     NSLayoutAttributeTop
#define LYS_Implementation_Left    NSLayoutAttributeLeft
#define LYS_Implementation_Right   NSLayoutAttributeRight
#define LYS_Implementation_Bottom  NSLayoutAttributeBottom
#define LYS_Implementation_Width   NSLayoutAttributeWidth
#define LYS_Implementation_Height  NSLayoutAttributeHeight
#define LYS_Implementation_CenterX NSLayoutAttributeCenterX
#define LYS_Implementation_CenterY NSLayoutAttributeCenterY
#define LYS_Implementation_Not NSLayoutAttributeNotAnAttribute
#define LYS_Implementation_Layout(A,AttributeOne,RelatedBy,B,AttributeTwo,M,C) [NSLayoutConstraint constraintWithItem:A attribute:AttributeOne relatedBy:RelatedBy toItem:B attribute:AttributeTwo multiplier:M constant:C]

#define LYS_Implementation_Tuple(ONE,TWO) [LYSTupleManager create:ONE two:TWO]



