//
//  UIViewController+LYSCategory.m
//  LYSKitDemo
//
//  Created by HENAN on 2018/4/20.
//  Copyright © 2018年 liyangshuai. All rights reserved.
//

#import "UIViewController+LYSCategory.h"
#import "UIView+LYSCategory.h"

@implementation UIViewController (LYSCategory)

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

+ (BOOL)ly_currentViewControllerVisible:(UIViewController *)viewController
{
    return (viewController.isViewLoaded && viewController.view.window);
}

- (void)ly_alertTitle:(NSString *)title
              message:(NSString *)message
              leftStr:(NSString *)leftStr
           leftAction:(void(^)(void))leftAction
             rightStr:(NSString *)rightStr
          rightAction:(void(^)(void))rightAction
{
    [self ly_alertTitle:title
                message:message
         preferredStyle:(UIAlertControllerStyleAlert)
           actionTitles:@[leftStr,rightStr]
            clickAction:^(NSInteger index)
     {
         if (index == 0) {
             if (leftAction) {
                 leftAction();
             }
         }else{
             if (rightAction) {
                 rightAction();
             }
         }
     }
              cancelStr:nil
           cancelAction:nil];
}

+ (void)ly_alertTitle:(NSString *)title
              message:(NSString *)message
              leftStr:(NSString *)leftStr
           leftAction:(void(^)(void))leftAction
             rightStr:(NSString *)rightStr
          rightAction:(void(^)(void))rightAction
{
    [self ly_alertTitle:title
                message:message
         preferredStyle:(UIAlertControllerStyleAlert)
           actionTitles:@[leftStr,rightStr]
            clickAction:^(NSInteger index)
     {
         if (index == 0) {
             if (leftAction) {
                 leftAction();
             }
         }else{
             if (rightAction) {
                 rightAction();
             }
         }
     }
              cancelStr:nil
           cancelAction:nil];
}

- (void)ly_alertTitle:(NSString *)title
              message:(NSString *)message
           comfirmStr:(NSString *)comfirmStr
        comfirmAction:(void(^)(void))comfirmAction
{
    [self ly_alertTitle:title
                message:message
         preferredStyle:(UIAlertControllerStyleAlert)
           actionTitles:@[comfirmStr]
            clickAction:^(NSInteger index)
     {
         if (comfirmAction) {
             comfirmAction();
         }
     }
              cancelStr:nil
           cancelAction:nil];
}

+ (void)ly_alertTitle:(NSString *)title
              message:(NSString *)message
           comfirmStr:(NSString *)comfirmStr
        comfirmAction:(void(^)(void))comfirmAction
{
    [self ly_alertTitle:title
                message:message
         preferredStyle:(UIAlertControllerStyleAlert)
           actionTitles:@[comfirmStr]
            clickAction:^(NSInteger index)
     {
         if (comfirmAction) {
             comfirmAction();
         }
     }
              cancelStr:nil
           cancelAction:nil];
}

- (void)ly_alertTitle:(NSString *)title
              message:(NSString *)message
       preferredStyle:(UIAlertControllerStyle)preferredStyle
         actionTitles:(NSArray<NSString *> *)actionTitles
          clickAction:(void(^)(NSInteger index))clickAction
            cancelStr:(NSString *)cancelStr
         cancelAction:(void(^)(void))cancelAction
{
    UIAlertController *alertVC = [UIViewController alertWithTitle:title
                                                          message:message
                                                   preferredStyle:preferredStyle
                                                     actionTitles:actionTitles
                                                      clickAction:clickAction
                                                        cancelStr:cancelStr
                                                     cancelAction:cancelAction];
    [self presentViewController:alertVC animated:YES completion:nil];
}

+ (void)ly_alertTitle:(NSString *)title
              message:(NSString *)message
       preferredStyle:(UIAlertControllerStyle)preferredStyle
         actionTitles:(NSArray<NSString *> *)actionTitles
          clickAction:(void(^)(NSInteger index))clickAction
            cancelStr:(NSString *)cancelStr
         cancelAction:(void(^)(void))cancelAction
{
    UIAlertController *alertVC = [self alertWithTitle:title
                                              message:message
                                       preferredStyle:preferredStyle
                                         actionTitles:actionTitles
                                          clickAction:clickAction
                                            cancelStr:cancelStr
                                         cancelAction:cancelAction];
    [[self ly_getOuterViewController] presentViewController:alertVC animated:YES completion:nil];
}

- (void)ly_alertTitle:(NSString *)title
              message:(NSString *)message
 textfieldPlaceholder:(NSArray<NSString *> *)placeholders
         actionTitles:(NSArray<NSString *> *)actionTitles
          clickAction:(void(^)(NSInteger index))clickAction
            cancelStr:(NSString *)cancelStr
         cancelAction:(void(^)(void))cancelAction
{
    UIAlertController *alertVC = [UIViewController alertWithTitle:title
                                                          message:message
                                             textfieldPlaceholder:placeholders
                                                     actionTitles:actionTitles
                                                      clickAction:clickAction
                                                        cancelStr:cancelStr
                                                     cancelAction:cancelAction];
    [self presentViewController:alertVC animated:YES completion:nil];
}

- (void)ly_alertTitle:(NSString *)title message:(NSString *)message textfieldPlaceholder:(NSArray<NSString *> *)placeholders actionTitles:(NSArray<NSString *> *)actionTitles clickWithFieldAction:(void(^)(NSInteger index,NSArray<UITextField *> *textFields))clickAction cancelStr:(NSString *)cancelStr cancelAction:(void(^)(void))cancelAction
{
    UIAlertController *alertVC = [UIViewController alertWithTitle:title
                                                          message:message
                                             textfieldPlaceholder:placeholders
                                                     actionTitles:actionTitles
                                             clickWithFieldAction:clickAction
                                                        cancelStr:cancelStr
                                                     cancelAction:cancelAction];
    [self presentViewController:alertVC animated:YES completion:nil];
}

+ (void)ly_alertTitle:(NSString *)title
              message:(NSString *)message
 textfieldPlaceholder:(NSArray<NSString *> *)placeholders
         actionTitles:(NSArray<NSString *> *)actionTitles
          clickAction:(void(^)(NSInteger index))clickAction
            cancelStr:(NSString *)cancelStr
         cancelAction:(void(^)(void))cancelAction
{
    UIAlertController *alertVC = [self alertWithTitle:title
                                              message:message
                                 textfieldPlaceholder:placeholders
                                         actionTitles:actionTitles
                                          clickAction:clickAction
                                            cancelStr:cancelStr
                                         cancelAction:cancelAction];
    [[self ly_getOuterViewController] presentViewController:alertVC animated:YES completion:nil];
}

+ (void)ly_alertTitle:(NSString *)title message:(NSString *)message textfieldPlaceholder:(NSArray<NSString *> *)placeholders actionTitles:(NSArray<NSString *> *)actionTitles clickWithFieldAction:(void(^)(NSInteger index,NSArray<UITextField *> *textFields))clickAction cancelStr:(NSString *)cancelStr cancelAction:(void(^)(void))cancelAction
{
    UIAlertController *alertVC = [self alertWithTitle:title
                                              message:message
                                 textfieldPlaceholder:placeholders
                                         actionTitles:actionTitles
                                 clickWithFieldAction:clickAction
                                            cancelStr:cancelStr
                                         cancelAction:cancelAction];
    [[self ly_getOuterViewController] presentViewController:alertVC animated:YES completion:nil];
}

+ (UIAlertController *)alertWithTitle:(NSString *)title
                              message:(NSString *)message
                 textfieldPlaceholder:(NSArray<NSString *> *)placeholders
                         actionTitles:(NSArray<NSString *> *)actionTitles
                 clickWithFieldAction:(void(^)(NSInteger index,NSArray<UITextField *> *textFields))clickAction
                            cancelStr:(NSString *)cancelStr
                         cancelAction:(void(^)(void))cancelAction
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
    if (actionTitles)
    {
        for (int i = 0;i < actionTitles.count;i++)
        {
            UIAlertAction *action = [UIAlertAction actionWithTitle:actionTitles[i]
                                                             style:(UIAlertActionStyleDefault)
                                                           handler:^(UIAlertAction * _Nonnull action)
                                     {
                                         if (clickAction) { clickAction(i,alertVC.textFields);}
                                     }
                                     ];
            [alertVC addAction:action];
        }
    }
    if (cancelStr)
    {
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:cancelStr
                                                         style:(UIAlertActionStyleCancel)
                                                       handler:^(UIAlertAction * _Nonnull action)
                                 {
                                     if (cancelAction) { cancelAction();}
                                 }
                                 ];
        [alertVC addAction:cancel];
    }
    return alertVC;
}

+ (UIAlertController *)alertWithTitle:(NSString *)title
                              message:(NSString *)message
                 textfieldPlaceholder:(NSArray<NSString *> *)placeholders
                         actionTitles:(NSArray<NSString *> *)actionTitles
                          clickAction:(void(^)(NSInteger index))clickAction
                            cancelStr:(NSString *)cancelStr
                         cancelAction:(void(^)(void))cancelAction
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
    if (actionTitles)
    {
        for (int i = 0;i < actionTitles.count;i++)
        {
            UIAlertAction *action = [UIAlertAction actionWithTitle:actionTitles[i]
                                                             style:(UIAlertActionStyleDefault)
                                                           handler:^(UIAlertAction * _Nonnull action)
                                     {
                                         if (clickAction) { clickAction(i);}
                                     }
                                     ];
            [alertVC addAction:action];
        }
    }
    if (cancelStr)
    {
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:cancelStr
                                                         style:(UIAlertActionStyleCancel)
                                                       handler:^(UIAlertAction * _Nonnull action)
                                 {
                                     if (cancelAction) { cancelAction();}
                                 }
                                 ];
        [alertVC addAction:cancel];
    }
    return alertVC;
}

+ (UIAlertController *)alertWithTitle:(NSString *)title
                              message:(NSString *)message
                       preferredStyle:(UIAlertControllerStyle)preferredStyle
                         actionTitles:(NSArray<NSString *> *)actionTitles
                          clickAction:(void(^)(NSInteger index))clickAction
                            cancelStr:(NSString *)cancelStr
                         cancelAction:(void(^)(void))cancelAction
{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:title
                                                                     message:message
                                                              preferredStyle:preferredStyle];
    if (actionTitles)
    {
        for (int i = 0;i < actionTitles.count;i++)
        {
            UIAlertAction *action = [UIAlertAction actionWithTitle:actionTitles[i]
                                                             style:(UIAlertActionStyleDefault)
                                                           handler:^(UIAlertAction * _Nonnull action)
                                     {
                                         if (clickAction) { clickAction(i);}
                                     }
                                     ];
            [alertVC addAction:action];
        }
    }
    if (cancelStr)
    {
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:cancelStr
                                                         style:(UIAlertActionStyleCancel)
                                                       handler:^(UIAlertAction * _Nonnull action)
                                 {
                                     if (cancelAction) { cancelAction();}
                                 }
                                 ];
        [alertVC addAction:cancel];
    }
    return alertVC;
}

@end
