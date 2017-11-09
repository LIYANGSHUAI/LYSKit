//
//  UIViewController+LYSCategory.h
//  LYSKitDemo
//
//  Created by HENAN on 2017/11/9.
//  Copyright © 2017年 HENAN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (LYSCategory)
/**
 获取最外层的视图控制器
 
 @return 返回最外层的视图控制器
 */
+ (UIViewController *)ly_getOuterViewController;

/**
 实例方法弹出窗口,窗口样式默认是UIAlertControllerStyleAlert类型
 
 @param title 弹窗的标题
 @param message 弹窗的提示信息
 @param leftStr 弹窗的左边按钮标题
 @param leftAction 弹出的左边按钮点击事件
 @param rightStr 弹窗的右边按钮标题
 @param rightAction 弹出的右边按钮点击事件
 */
- (void)ly_alertTitle:(NSString *)title
              message:(NSString *)message
              leftStr:(NSString *)leftStr
           leftAction:(void(^)(void))leftAction
             rightStr:(NSString *)rightStr
          rightAction:(void(^)(void))rightAction NS_AVAILABLE_IOS(8.0);

/**
 类方法弹出窗口,窗口样式默认是UIAlertControllerStyleAlert类型
 
 @param title 弹窗的标题
 @param message 弹窗的提示信息
 @param leftStr 弹窗的左边按钮标题
 @param leftAction 弹出的左边按钮点击事件
 @param rightStr 弹窗的右边按钮标题
 @param rightAction 弹出的右边按钮点击事件
 */
+ (void)ly_alertTitle:(NSString *)title
              message:(NSString *)message
              leftStr:(NSString *)leftStr
           leftAction:(void(^)(void))leftAction
             rightStr:(NSString *)rightStr
          rightAction:(void(^)(void))rightAction NS_AVAILABLE_IOS(8.0);

/**
 实例方法,带有输入框的弹窗
 
 @param title 弹窗的标题
 @param message 弹窗的提示信息
 @param placeholders 输入的占位字符串,个数决定输入框的个数
 @param leftStr 弹窗的左边按钮标题
 @param leftAction 弹窗的左边按钮点击事件
 @param rightStr 弹窗的右边按钮标题
 @param rightAction 弹窗的右边按钮点击事件
 */
- (void)ly_alertTitle:(NSString *)title
              message:(NSString *)message
 textfieldPlaceholder:(NSArray<NSString *> *)placeholders
              leftStr:(NSString *)leftStr
           leftAction:(void(^)(NSArray<UITextField *> *textFields))leftAction
             rightStr:(NSString *)rightStr
          rightAction:(void(^)(NSArray<UITextField *> *textFields))rightAction NS_AVAILABLE_IOS(8.0);

/**
 类方法,带有输入框的弹窗
 
 @param title 弹窗的标题
 @param message 弹窗的提示信息
 @param placeholders 输入的占位字符串,个数决定输入框的个数
 @param leftStr 弹窗的左边按钮标题
 @param leftAction 弹窗的左边按钮点击事件
 @param rightStr 弹窗的右边按钮标题
 @param rightAction 弹窗的右边按钮点击事件 \
 */
+ (void)ly_alertTitle:(NSString *)title
              message:(NSString *)message
 textfieldPlaceholder:(NSArray<NSString *> *)placeholders
              leftStr:(NSString *)leftStr
           leftAction:(void(^)(NSArray<UITextField *> *textFields))leftAction
             rightStr:(NSString *)rightStr
          rightAction:(void(^)(NSArray<UITextField *> *textFields))rightAction NS_AVAILABLE_IOS(8.0);

/**
 实例方法,只有一个按钮的弹窗
 
 @param title 弹窗的标题
 @param message 弹窗的提示信息
 @param comfirmStr 弹窗按钮标题
 @param comfirmAction 弹窗按钮点击事件
 */
- (void)ly_alertTitle:(NSString *)title
              message:(NSString *)message
           comfirmStr:(NSString *)comfirmStr
        comfirmAction:(void(^)(void))comfirmAction NS_AVAILABLE_IOS(8.0);

/**
 类方法,只有一个按钮的弹窗
 
 @param title 弹窗的标题
 @param message 弹窗的提示信息
 @param comfirmStr 弹窗按钮标题
 @param comfirmAction 弹窗按钮点击事件
 */
+ (void)ly_alertTitle:(NSString *)title
              message:(NSString *)message
           comfirmStr:(NSString *)comfirmStr
        comfirmAction:(void(^)(void))comfirmAction NS_AVAILABLE_IOS(8.0);

/**
 实例方法,返回自定义条数弹窗
 
 @param title 弹窗的标题
 @param message 弹窗的提示信息
 @param preferredStyle 弹窗的样式
 @param actionTitles 弹窗的条目标题
 @param clickAction 弹窗的点击事件
 @param cancelStr 弹窗的取消按钮标题
 @param cancelAction 弹窗的去掉点击事件
 */
- (void)ly_alertTitle:(NSString *)title
              message:(NSString *)message
       preferredStyle:(UIAlertControllerStyle)preferredStyle
         actionTitles:(NSArray<NSString *> *)actionTitles
          clickAction:(void(^)(NSInteger index))clickAction
            cancelStr:(NSString *)cancelStr
         cancelAction:(void(^)(void))cancelAction NS_AVAILABLE_IOS(8.0);

/**
 类方法,返回自定义条数弹窗
 
 @param title 弹窗的标题
 @param message 弹窗的提示信息
 @param preferredStyle 弹窗的样式
 @param actionTitles 弹窗的条目标题
 @param clickAction 弹窗的点击事件
 @param cancelStr 弹窗的取消按钮标题
 @param cancelAction 弹窗的去掉点击事件
 */
+ (void)ly_alertTitle:(NSString *)title
              message:(NSString *)message
       preferredStyle:(UIAlertControllerStyle)preferredStyle
         actionTitles:(NSArray<NSString *> *)actionTitles
          clickAction:(void(^)(NSInteger index))clickAction
            cancelStr:(NSString *)cancelStr
         cancelAction:(void(^)(void))cancelAction NS_AVAILABLE_IOS(8.0);
/**
 判断一个控制器是否正在显示
 
 @param viewController 参数控制器
 @return 返回BOOL类型
 */
+ (BOOL)ly_currentViewControllerVisible:(UIViewController *)viewController;
@end
