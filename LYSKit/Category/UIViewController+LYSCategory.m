//
//  UIViewController+LYSCategory.m
//  LYSKitDemo
//
//  Created by HENAN on 2017/12/6.
//  Copyright © 2017年 HENAN. All rights reserved.
//

#import "UIViewController+LYSCategory.h"
#import "UIView+LYSCategory.h"

@implementation UIViewController (LYSCategory)

+ (UIViewController *)getOuterViewController
{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    NSMutableArray *array = [keyWindow getTopSubViews];
    UINavigationController *nav = nil;
    UITabBarController *tab = nil;
    for (UIView *subView in array) {
        UIViewController *vc = [subView getRootViewController];
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
+ (BOOL)currentViewControllerVisible:(UIViewController *)viewController
{
    return (viewController.isViewLoaded && viewController.view.window);
}
- (void)alertTitle:(NSString *)title message:(NSString *)message leftStr:(NSString *)leftStr leftAction:(void(^)(void))leftAction rightStr:(NSString *)rightStr rightAction:(void(^)(void))rightAction
{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:leftStr style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action)
    {
        if (leftAction) {leftAction();}
    }];
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:rightStr style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action)
    {
        if (rightAction) {rightAction();}
    }];
    [alertVC addAction:confirmAction];
    [alertVC addAction:cancleAction];
    [self presentViewController:alertVC animated:YES completion:nil];
}
+ (void)alertTitle:(NSString *)title message:(NSString *)message leftStr:(NSString *)leftStr leftAction:(void(^)(void))leftAction rightStr:(NSString *)rightStr rightAction:(void(^)(void))rightAction
{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:leftStr style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action)
    {
        if (leftAction) {leftAction();}
    }];
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:rightStr style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action)
    {
        if (rightAction) {rightAction();}
    }];
    [alertVC addAction:confirmAction];
    [alertVC addAction:cancleAction];
    [[self getOuterViewController] presentViewController:alertVC animated:YES completion:nil];
}
- (void)alertTitle:(NSString *)title message:(NSString *)message textfieldPlaceholder:(NSArray<NSString *> *)placeholders leftStr:(NSString *)leftStr leftAction:(void(^)(NSArray<UITextField *> *textFields))leftAction rightStr:(NSString *)rightStr rightAction:(void(^)(NSArray<UITextField *> *textFields))rightAction
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
+ (void)alertTitle:(NSString *)title message:(NSString *)message textfieldPlaceholder:(NSArray<NSString *> *)placeholders leftStr:(NSString *)leftStr leftAction:(void(^)(NSArray<UITextField *> *textFields))leftAction rightStr:(NSString *)rightStr rightAction:(void(^)(NSArray<UITextField *> *textFields))rightAction
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
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:leftStr style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action)
    {
        if (leftAction) {leftAction(alertVC.textFields);}
    }];
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:rightStr style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action)
    {
        if (rightAction) {rightAction(alertVC.textFields);}
    }];
    [alertVC addAction:confirmAction];
    [alertVC addAction:cancleAction];
    [[self getOuterViewController] presentViewController:alertVC animated:YES completion:nil];
}
- (void)alertTitle:(NSString *)title message:(NSString *)message comfirmStr:(NSString *)comfirmStr comfirmAction:(void(^)(void))comfirmAction
{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:comfirmStr style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        if (comfirmAction) {comfirmAction();}
    }];
    [alertVC addAction:confirmAction];
    [self presentViewController:alertVC animated:YES completion:nil];
}
+ (void)alertTitle:(NSString *)title message:(NSString *)message comfirmStr:(NSString *)comfirmStr comfirmAction:(void(^)(void))comfirmAction
{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:comfirmStr style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        if (comfirmAction) {comfirmAction();}
    }];
    [alertVC addAction:confirmAction];
    [[self getOuterViewController] presentViewController:alertVC animated:YES completion:nil];
}
- (void)alertTitle:(NSString *)title message:(NSString *)message preferredStyle:(UIAlertControllerStyle)preferredStyle actionTitles:(NSArray<NSString *> *)actionTitles clickAction:(void(^)(NSInteger index))clickAction cancelStr:(NSString *)cancelStr cancelAction:(void(^)(void))cancelAction
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
+ (void)alertTitle:(NSString *)title message:(NSString *)message preferredStyle:(UIAlertControllerStyle)preferredStyle actionTitles:(NSArray<NSString *> *)actionTitles clickAction:(void(^)(NSInteger index))clickAction cancelStr:(NSString *)cancelStr cancelAction:(void(^)(void))cancelAction
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
    [[self getOuterViewController] presentViewController:alertVC animated:YES completion:nil];
}
@end

