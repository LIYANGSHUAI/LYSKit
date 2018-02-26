//
//  UIViewController+LYS.h
//  LYSKit
//
//  Created by HENAN on 2018/2/26.
//  Copyright © 2018年 liyangshuai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (LYS)
/**
 获取最外层控制器
 
 @return                                    返回控制器
 */
+ (UIViewController *)ly_getOuterViewController;

/**
 判断这个控制器是否正在显示
 
 @param viewController                      需要判断的控制器
 @return                                    返回判断结果
 */
+ (BOOL)ly_currentViewControllerVisible:(UIViewController *)viewController;

/**
 弹出一个左右按钮的弹窗
 
 @param title                               标题
 @param message                             副标题
 @param leftStr                             左按钮
 @param leftAction                          左按钮事件
 @param rightStr                            右按钮
 @param rightAction                         右按钮事件
 */
- (void)ly_alertTitle:(NSString *)title message:(NSString *)message leftStr:(NSString *)leftStr leftAction:(void(^)(void))leftAction rightStr:(NSString *)rightStr rightAction:(void(^)(void))rightAction;

/**
 弹出一个左右按钮的弹窗
 
 @param title                               标题
 @param message                             副标题
 @param leftStr                             左按钮
 @param leftAction                          左按钮事件
 @param rightStr                            右按钮
 @param rightAction                         右按钮事件
 */
+ (void)ly_alertTitle:(NSString *)title message:(NSString *)message leftStr:(NSString *)leftStr leftAction:(void(^)(void))leftAction rightStr:(NSString *)rightStr rightAction:(void(^)(void))rightAction;

/**
 弹出一个只有一个按钮的弹窗
 
 @param title                               标题
 @param message                             副标题
 @param comfirmStr                          按钮
 @param comfirmAction                       按钮事件
 */
- (void)ly_alertTitle:(NSString *)title message:(NSString *)message comfirmStr:(NSString *)comfirmStr comfirmAction:(void(^)(void))comfirmAction;

/**
 弹出一个只有一个按钮的弹窗
 
 @param title                               标题
 @param message                             副标题
 @param comfirmStr                          按钮
 @param comfirmAction                       按钮事件
 */
+ (void)ly_alertTitle:(NSString *)title message:(NSString *)message comfirmStr:(NSString *)comfirmStr comfirmAction:(void(^)(void))comfirmAction;

/**
 弹出一个多个按钮的弹窗,并且附带取消按钮
 
 @param title                               标题
 @param message                             副标题
 @param preferredStyle                      弹窗样式
 @param actionTitles                        按钮
 @param clickAction                         按钮事件
 @param cancelStr                           取消
 @param cancelAction                        取消事件
 */
- (void)ly_alertTitle:(NSString *)title message:(NSString *)message preferredStyle:(UIAlertControllerStyle)preferredStyle actionTitles:(NSArray<NSString *> *)actionTitles clickAction:(void(^)(NSInteger index))clickAction cancelStr:(NSString *)cancelStr cancelAction:(void(^)(void))cancelAction;

/**
 弹出一个多个按钮的弹窗,并且附带取消按钮
 
 @param title                               标题
 @param message                             副标题
 @param preferredStyle                      弹窗样式
 @param actionTitles                        按钮
 @param clickAction                         按钮事件
 @param cancelStr                           取消
 @param cancelAction                        取消事件
 */
+ (void)ly_alertTitle:(NSString *)title message:(NSString *)message preferredStyle:(UIAlertControllerStyle)preferredStyle actionTitles:(NSArray<NSString *> *)actionTitles clickAction:(void(^)(NSInteger index))clickAction cancelStr:(NSString *)cancelStr cancelAction:(void(^)(void))cancelAction;

/**
 弹出一个多个按钮的弹窗,并且附带取消按钮
 
 @param title                               标题
 @param message                             副标题
 @param placeholders                        输入框
 @param actionTitles                        按钮
 @param clickAction                         按钮事件
 @param cancelStr                           取消
 @param cancelAction                        取消事件
 */
- (void)ly_alertTitle:(NSString *)title message:(NSString *)message textfieldPlaceholder:(NSArray<NSString *> *)placeholders actionTitles:(NSArray<NSString *> *)actionTitles clickAction:(void(^)(NSInteger index))clickAction cancelStr:(NSString *)cancelStr cancelAction:(void(^)(void))cancelAction;

/**
 弹出一个多个按钮的弹窗,并且附带取消按钮
 
 @param title                               标题
 @param message                             副标题
 @param placeholders                        输入框
 @param actionTitles                        按钮
 @param clickAction                         按钮事件
 @param cancelStr                           取消
 @param cancelAction                        取消事件
 */
+ (void)ly_alertTitle:(NSString *)title message:(NSString *)message textfieldPlaceholder:(NSArray<NSString *> *)placeholders actionTitles:(NSArray<NSString *> *)actionTitles clickAction:(void(^)(NSInteger index))clickAction cancelStr:(NSString *)cancelStr cancelAction:(void(^)(void))cancelAction;
@end
