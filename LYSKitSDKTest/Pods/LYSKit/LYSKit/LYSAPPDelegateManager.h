//
//  LYSAPPDelegateManager.h
//  LYSKitDemo
//
//  Created by HENAN on 2017/12/5.
//  Copyright © 2017年 HENAN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LYSAPPDelegateManager : NSObject

/**
 设置window的跟视图控制器
 
 @param rootViewController 要设置的跟视图控制器
 */
+ (void)ly_createWindowAndSetRootViewController:(UIViewController *)rootViewController;

/**
 根据返回条件分别显示不同的视图控制器
 
 @param ispermit 判断条件
 @param firstViewController 如果判断条件:YES,显示这个控制器
 @param secoundViewController 如果判断条件:NO,显示这个控制器
 */
+ (void)ly_if:(BOOL(^)(void))ispermit showViewController:(UIViewController *)firstViewController elseShowViewController:(UIViewController *)secoundViewController;

/**
 设置window的跟视图控制器
 
 @param rootViewController 根视图控制器
 */
+ (void)ly_setWindowRootViewController:(UIViewController *)rootViewController;

/**
 设置启动动画
 
 @param startInterface 启动界面
 @param mainInterface 应用主界面
 @param interval 启动动画的显示时间
 @param durtion 动画消失的动画时间
 */
+ (void)ly_createWindowAndloadStartInterface:(UIViewController *)startInterface mainInterface:(UIViewController *)mainInterface delay:(NSTimeInterval)interval durtion:(NSTimeInterval)durtion;

/**
 模仿导航进入下一级页面
 
 @param fromVC 上一级页面
 @param toVC 下一级页面
 @param completion 完成回调
 */
+ (void)pushFrom:(UIViewController *)fromVC toViewController:(UIViewController *)toVC completion:(void(^)(void))completion;

/**
 模仿导航退回上一级页面
 
 @param fromVC 下一级页面
 @param toVC 上一级页面
 @param completion 完成回调
 */
+ (void)popFrom:(UIViewController *)fromVC toViewController:(UIViewController *)toVC completion:(void(^)(void))completion;
@end
