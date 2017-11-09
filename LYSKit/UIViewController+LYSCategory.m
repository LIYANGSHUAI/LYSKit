//
//  UIViewController+LYSCategory.m
//  LYSKitDemo
//
//  Created by HENAN on 2017/11/9.
//  Copyright © 2017年 HENAN. All rights reserved.
//

#import "UIViewController+LYSCategory.h"
#import "UIView+LYSCategory.h"
@implementation UIViewController (LYSCategory)
// 这段代码的意思是，如果我能判断的更精确就精确些。比如某个导航控制器，你说他在响应也行，他的top元素在响应也行，显然我想精确到top元素
+ (UIViewController *)ly_getOuterViewController
{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    NSMutableArray *array = [keyWindow ly_getTopSubViews];
    UINavigationController *nav = nil;
    UITabBarController *tab = nil;
    for (UIView *subView in array) {
        UIViewController *vc = [subView ly_getRootViewController];
        if (!([vc isKindOfClass:[UINavigationController class]] || [vc isKindOfClass:[UITabBarController class]]))
        {
            return vc;
        }
        if ([vc isKindOfClass:[UINavigationController class]])
        {
            nav = (UINavigationController *)vc;
        }
        if ([vc isKindOfClass:[UITabBarController class]])
        {
            tab = (UITabBarController *)vc;
        }
    }
    if (nav) {return nav;}
    if (tab) {return tab;}
    return nil;
}
// 弹出提示窗口
- (void)ly_alertTitle:(NSString *)title
              message:(NSString *)message
              leftStr:(NSString *)leftStr
           leftAction:(void(^)(void))leftAction
             rightStr:(NSString *)rightStr
          rightAction:(void(^)(void))rightAction
{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:leftStr style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        if (leftAction) {leftAction();}
    }];
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:rightStr style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        if (rightAction) {rightAction();}
    }];
    [alertVC addAction:confirmAction];
    [alertVC addAction:cancleAction];
    [self presentViewController:alertVC animated:YES completion:nil];
}
// 弹出提示窗口
+ (void)ly_alertTitle:(NSString *)title
              message:(NSString *)message
              leftStr:(NSString *)leftStr
           leftAction:(void(^)(void))leftAction
             rightStr:(NSString *)rightStr
          rightAction:(void(^)(void))rightAction
{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:leftStr style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        if (leftAction) {leftAction();}
    }];
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:rightStr style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        if (rightAction) {rightAction();}
    }];
    [alertVC addAction:confirmAction];
    [alertVC addAction:cancleAction];
    [[self ly_getOuterViewController] presentViewController:alertVC animated:YES completion:nil];
}
// 弹出提示窗口
- (void)ly_alertTitle:(NSString *)title
              message:(NSString *)message
 textfieldPlaceholder:(NSArray<NSString *> *)placeholders
              leftStr:(NSString *)leftStr
           leftAction:(void(^)(NSArray<UITextField *> *textFields))leftAction
             rightStr:(NSString *)rightStr
          rightAction:(void(^)(NSArray<UITextField *> *textFields))rightAction
{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    if (placeholders)
    {
        for (NSString *str in placeholders)
        {
            [alertVC addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
                textField.placeholder = str;
            }];
        }
    }
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:leftStr style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        if (leftAction) {leftAction(alertVC.textFields);}
    }];
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:rightStr style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        if (rightAction) {rightAction(alertVC.textFields);}
    }];
    [alertVC addAction:confirmAction];
    [alertVC addAction:cancleAction];
    [self presentViewController:alertVC animated:YES completion:nil];
}
// 弹出提示窗口
+ (void)ly_alertTitle:(NSString *)title
              message:(NSString *)message
 textfieldPlaceholder:(NSArray<NSString *> *)placeholders
              leftStr:(NSString *)leftStr
           leftAction:(void(^)(NSArray<UITextField *> *textFields))leftAction
             rightStr:(NSString *)rightStr
          rightAction:(void(^)(NSArray<UITextField *> *textFields))rightAction
{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    if (placeholders)
    {
        for (NSString *str in placeholders)
        {
            [alertVC addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
                textField.placeholder = str;
            }];
        }
    }
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:leftStr style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        if (leftAction) {leftAction(alertVC.textFields);}
    }];
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:rightStr style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        if (rightAction) {rightAction(alertVC.textFields);}
    }];
    [alertVC addAction:confirmAction];
    [alertVC addAction:cancleAction];
    [[self ly_getOuterViewController] presentViewController:alertVC animated:YES completion:nil];
}
// 仅仅显示确定按钮
- (void)ly_alertTitle:(NSString *)title
              message:(NSString *)message
           comfirmStr:(NSString *)comfirmStr
        comfirmAction:(void(^)(void))comfirmAction
{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:comfirmStr style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        if (comfirmAction) {comfirmAction();}
    }];
    [alertVC addAction:confirmAction];
    [self presentViewController:alertVC animated:YES completion:nil];
}
// 仅仅显示确定按钮
+ (void)ly_alertTitle:(NSString *)title
              message:(NSString *)message
           comfirmStr:(NSString *)comfirmStr
        comfirmAction:(void(^)(void))comfirmAction
{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:comfirmStr style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        if (comfirmAction) {comfirmAction();}
    }];
    [alertVC addAction:confirmAction];
    [[self ly_getOuterViewController] presentViewController:alertVC animated:YES completion:nil];
}
// 自定义弹窗条数
- (void)ly_alertTitle:(NSString *)title
              message:(NSString *)message
       preferredStyle:(UIAlertControllerStyle)preferredStyle
         actionTitles:(NSArray<NSString *> *)actionTitles
          clickAction:(void(^)(NSInteger index))clickAction
            cancelStr:(NSString *)cancelStr
         cancelAction:(void(^)(void))cancelAction
{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:preferredStyle];
    if (actionTitles)
    {
        for (int i = 0;i < actionTitles.count;i++)
        {
            UIAlertAction *action = [UIAlertAction actionWithTitle:actionTitles[i] style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                if (clickAction) { clickAction(i);}
            }];
            [alertVC addAction:action];
        }
    }
    if (cancelStr)
    {
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:cancelStr style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
            if (cancelAction) { cancelAction();}
        }];
        [alertVC addAction:cancel];
    }
    [self presentViewController:alertVC animated:YES completion:nil];
}
// 自定义弹窗条数
+ (void)ly_alertTitle:(NSString *)title
              message:(NSString *)message
       preferredStyle:(UIAlertControllerStyle)preferredStyle
         actionTitles:(NSArray<NSString *> *)actionTitles
          clickAction:(void(^)(NSInteger index))clickAction
            cancelStr:(NSString *)cancelStr
         cancelAction:(void(^)(void))cancelAction
{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:preferredStyle];
    if (actionTitles)
    {
        for (int i = 0;i < actionTitles.count;i++)
        {
            UIAlertAction *action = [UIAlertAction actionWithTitle:actionTitles[i] style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                if (clickAction) { clickAction(i);}
            }];
            [alertVC addAction:action];
        }
    }
    if (cancelStr)
    {
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:cancelStr style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
            if (cancelAction) { cancelAction();}
        }];
        [alertVC addAction:cancel];
    }
    [[self ly_getOuterViewController] presentViewController:alertVC animated:YES completion:nil];
}
// 判断一个控制器是否正在显示
+ (BOOL)ly_currentViewControllerVisible:(UIViewController *)viewController
{
    return (viewController.isViewLoaded && viewController.view.window);
}
@end
