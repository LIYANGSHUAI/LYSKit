//
//  UIViewController+LYSCategory.h
//  LYSKitDemo
//
//  Created by HENAN on 2017/12/6.
//  Copyright © 2017年 HENAN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (LYSCategory)

// Get the outermost view controller
+ (UIViewController *)getOuterViewController;

// Determine whether the controller is being displayed
+ (BOOL)currentViewControllerVisible:(UIViewController *)viewController;

// A pop-up window that pops up the left and right buttons and comes with a click.
- (void)alertTitle:(NSString *)title message:(NSString *)message leftStr:(NSString *)leftStr leftAction:(void(^)(void))leftAction rightStr:(NSString *)rightStr rightAction:(void(^)(void))rightAction;
+ (void)alertTitle:(NSString *)title message:(NSString *)message leftStr:(NSString *)leftStr leftAction:(void(^)(void))leftAction rightStr:(NSString *)rightStr rightAction:(void(^)(void))rightAction;

// Pop-up a pop-up window with an input frame
- (void)alertTitle:(NSString *)title message:(NSString *)message textfieldPlaceholder:(NSArray<NSString *> *)placeholders leftStr:(NSString *)leftStr leftAction:(void(^)(NSArray<UITextField *> *textFields))leftAction rightStr:(NSString *)rightStr rightAction:(void(^)(NSArray<UITextField *> *textFields))rightAction;
+ (void)alertTitle:(NSString *)title message:(NSString *)message textfieldPlaceholder:(NSArray<NSString *> *)placeholders leftStr:(NSString *)leftStr leftAction:(void(^)(NSArray<UITextField *> *textFields))leftAction rightStr:(NSString *)rightStr rightAction:(void(^)(NSArray<UITextField *> *textFields))rightAction;

// A pop-up window with only one button
- (void)alertTitle:(NSString *)title message:(NSString *)message comfirmStr:(NSString *)comfirmStr comfirmAction:(void(^)(void))comfirmAction;
+ (void)alertTitle:(NSString *)title message:(NSString *)message comfirmStr:(NSString *)comfirmStr comfirmAction:(void(^)(void))comfirmAction;

// Pop up a pop-up window with a pop-up position.
- (void)alertTitle:(NSString *)title message:(NSString *)message preferredStyle:(UIAlertControllerStyle)preferredStyle actionTitles:(NSArray<NSString *> *)actionTitles clickAction:(void(^)(NSInteger index))clickAction cancelStr:(NSString *)cancelStr cancelAction:(void(^)(void))cancelAction;
+ (void)alertTitle:(NSString *)title message:(NSString *)message preferredStyle:(UIAlertControllerStyle)preferredStyle actionTitles:(NSArray<NSString *> *)actionTitles clickAction:(void(^)(NSInteger index))clickAction cancelStr:(NSString *)cancelStr cancelAction:(void(^)(void))cancelAction;
@end
