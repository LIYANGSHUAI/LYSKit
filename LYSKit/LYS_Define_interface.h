//
//  LYS_Define_interface.h
//  LYSKit
//
//  Created by HENAN on 2017/9/22.
//  Copyright © 2017年 个人开发实用框架. All rights reserved.
//

#import "LYS_Define_implementation.h"

/**
 获取系统版本号

 @return 返回的是一个NSString类型,因此需要调用floatValue方法进行转换
 */
#define LYS_SystemVersion LYS_Implementation_SystemVersion
#define LYS_LaterIOS(A) LYS_Implementation_LaterIOS(A)
#define LYS_BeforeIOS(A) LYS_Implementation_BeforeIOS(A)
#define LYS_iPhone_X LYS_Implementation_iPhone_X
#define LYS_Application LYS_Implementation_Application
#define LYS_AppDelegate LYS_Implementation_AppDelegate
#define LYS_KeyWindow LYS_Implementation_KeyWindow
#define LYS_MainScreen LYS_Implementation_MainScreen
#define LYS_ScreenSize LYS_Implementation_ScreenSize

/**
 以6s为基准,对组件的宽和高进行动态的适配

 @param A 需要动态适配的数值
 @return 返回适配后的数据
 */
#define LYS_Adaptation_H LYS_Implementation_Adaptation_H
#define LYS_Adaptation_W LYS_Implementation_Adaptation_W
#define LYS_LayoutWith(A) LYS_Implementation_LayoutWith(A)
#define LYS_LayoutHeight(A) LYS_Implementation_LayoutHeight(A)


/**
 系统自带数据库的一些简单操作

 @param Key 存储数据的key
 @param Value 存储数据的Value
 */
#define LYS_UserDefaults LYS_Implementation_UserDefaults
#define LYS_SetObjectUserDefaults(Key,Value) LYS_Implementation_SetObjectUserDefaults(Key,Value)
#define LYS_SetBoolUserDefaults(Key,Value) LYS_Implementation_SetBoolUserDefaults(Key,Value)
#define LYS_GetObjectUserDefaults(Key) LYS_Implementation_GetObjectUserDefaults(Key)
#define LYS_GetBoolUserDefaults(Key) LYS_Implementation_GetBoolUserDefaults(Key)
#define LYS_RemoveKeyUserDefaults(Key) LYS_Implementation_RemoveKeyUserDefaults(Key)
#define LYS_SynchronizeUserDefaults LYS_Implementation_SynchronizeUserDefaults


/**
 弱引用和强引用

 @param type 需要做特殊处理的对象
 @return 无返回
 */
#define LYS_WeakSelf(type) LYS_Implementation_WeakSelf(type)
#define LYS_StrongSelf(type) LYS_Implementation_StrongSelf(type)


/**
 在使用UIView的transform时,可能会用到角度转换

 @param degrees 生活中常说的角度
 @return 返回计算过的角度
 */
#define LYS_DegreesToRadians(degrees) LYS_Implementation_DegreesToRadians(degrees)


/**
 获取随机数

 @param A 代表随机数的最小范围
 @param B 代表随机数的最大范围
 @return 返回随机数
 */
#define LYS_Random(A,B) LYS_Implementation_Random(A,B)
#define LYS_Random_uniform(A,B) LYS_Implementation_Random_uniform(A,B)


/**
 利用Runtime实现,给一个对象添加关联属性

 @param OBJECT 关联对象
 @param KEY 关联属性
 @param VALUE 关联属性值
 @param OBJC_ASSOCIATION 参数特性
 @return 无返回
 */
#define LYS_SetAssociatedObject(OBJECT,KEY,VALUE,OBJC_ASSOCIATION) LYS_Implementation_SetAssociatedObject(OBJECT,KEY,VALUE,OBJC_ASSOCIATION)

/**
 配合上面方法,获取一个对象关联属性值,前提必须是这个对象已经被关联此属性

 @param OBJECT 关联对象
 @param KEY 关联属性
 @return 返回关联属性值
 */
#define LYS_GetAssociatedObject(OBJECT,KEY) LYS_Implementation_GetAssociatedObject(OBJECT,KEY)

/**
 配合上面方法,在不再使用一个对象的关联属性或者可能会影响你接下来的操作时,你可以使用下面方法移除这个对象的关联属性

 @param OBJECT 关联对象
 @return 无返回
 */
#define LYS_RemoveAssociatedObjects(OBJECT) LYS_Implementation_RemoveAssociatedObjects(OBJECT)


/**
 创建UIFont对象

 @param A CGFloat数值
 @return 返回UIFont对象
 */
#define LYS_FONT(A) LYS_Implementation_FONT(A)


/**
 三种方式,创建UIColor颜色对象

 @param r red
 @param g green
 @param b blue
 @param a Alpha
 @return 返回UIColor对象
 */
#define LYS_RGBA(r,g,b,a) LYS_Implementation_RGBA(r,g,b,a)
#define LYS_RGB(r,g,b) LYS_Implementation_RGB(r,g,b)

/**
 十六进制字符串转UIColor颜色

 @param str 十六进制
 @return 返回UIColor对象
 */
#define LYS_HEX(str) LYS_Implementation_HEX(str)


/**
 控制设备横屏和竖屏,LYS_OrientationAndDefaultOrientation 要写在AppDelegate中,在这个宏中,实际上是实现了代理方法
 - (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window 通过控制返回的参数来控制屏幕的旋转
 @param A 设备横屏竖屏参数
 @return 无返回
 */

//typedef NS_ENUM(NSInteger,LYSupportedOrientation) {
//    LYSupportedOrientationMaskPortrait,      // 只允许home在下,即不支持旋转
//    LYSupportedOrientationMaskLandscapeLeft, // 支持home在右旋转
//    LYSupportedOrientationMaskLandscapeRight,// 支持home在左旋转
//    LYSupportedOrientationMaskAll,           // 支持以上三种方式旋转
//};

#define LYS_OrientationAndDefaultOrientation(A) LYS_Implementation_OrientationAndDefaultOrientation(A)
#define LYS_Orientation(A) LYS_Implementation_Orientation(A)


/**
 控制打印信息

 @param ... 打印内容
 @return 无返回
 */
#define LYS_NSLog(...) LYS_Implementation_NSLog(...)


/**
 简单的实现系统的约束
 
 关于约束,无法获取视图的frame的问题,有两个解决方案:
 
 1.调用[superView layoutIfNeeded],父类的layoutIfNeeded方法之后就可以正确获取视图的frame
 2.dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
     NSLog(@"%@",[NSValue valueWithCGRect:view.frame]);
 });
 添加定时器,也同样可以获取view的frame

 @param A 被约束对象
 @param AttributeOne 被约束对象的属性
 @param RelatedBy 约束类型
 @param B 参考约束对象
 @param AttributeTwo 参考约束对象的属性
 @param M 比例倍数
 @param C 差距值
 @return 返回NSLayoutConstraint类型
 */
#define LYS_Equal   LYS_Implementation_Equal
#define LYS_Top     LYS_Implementation_Top
#define LYS_Left    LYS_Implementation_Left
#define LYS_Right   LYS_Implementation_Right
#define LYS_Bottom  LYS_Implementation_Bottom
#define LYS_Width   LYS_Implementation_Width
#define LYS_Height  LYS_Implementation_Height
#define LYS_CenterX LYS_Implementation_CenterX
#define LYS_CenterY LYS_Implementation_CenterY
#define LYS_Not     LYS_Implementation_Not
#define LYS_Layout(A,AttributeOne,RelatedBy,B,AttributeTwo,M,C) LYS_Implementation_Layout(A,AttributeOne,RelatedBy,B,AttributeTwo,M,C)


/**
 模拟swift,制作元组类型

 @param ONE 元组属性一
 @param TWO 元组属性二
 @return 返回LYSTuple类型
 */
#define LYSTuple(ONE,TWO) LYS_Implementation_Tuple(ONE,TWO)
