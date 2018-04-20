//
//  LYSAPPDelegateManager.m
//  LYSKitDemo
//
//  Created by HENAN on 2018/4/20.
//  Copyright © 2018年 liyangshuai. All rights reserved.
//

#import "LYSAPPDelegateManager.h"

@implementation LYSAPPDelegateManager
+ (void)ly_createWindowAndSetRootViewController:(UIViewController *)rootViewController
{
    if ([UIApplication sharedApplication].delegate == nil) {return;}
    [[UIApplication sharedApplication].delegate setWindow:[[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds]];
    [[[UIApplication sharedApplication].delegate window] setRootViewController:rootViewController];
    [[[UIApplication sharedApplication].delegate window] makeKeyAndVisible];
}

+ (void)ly_if:(BOOL(^)(void))ispermit showViewController:(UIViewController *)firstViewController elseShowViewController:(UIViewController *)secoundViewController
{
    if (ispermit())
    {
        [self ly_createWindowAndSetRootViewController:firstViewController];
    }else
    {
        [self ly_createWindowAndSetRootViewController:secoundViewController];
    }
}

+ (void)ly_setWindowRootViewController:(UIViewController *)rootViewController
{
    if ([UIApplication sharedApplication].delegate == nil) {return;}
    [[[UIApplication sharedApplication].delegate window] setRootViewController:rootViewController];
}

+ (void)ly_createWindowAndloadStartInterface:(UIViewController *)startInterface mainInterface:(UIViewController *)mainInterface delay:(NSTimeInterval)interval durtion:(NSTimeInterval)durtion
{
    [self ly_createWindowAndSetRootViewController:startInterface];
    if ([UIApplication sharedApplication].delegate == nil) {return;}
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(interval * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[[UIApplication sharedApplication].delegate window] setRootViewController:mainInterface];
        [[[UIApplication sharedApplication].delegate window] addSubview:startInterface.view];
        [UIView animateWithDuration:durtion animations:^{
            startInterface.view.layer.opacity = 0;
        } completion:^(BOOL finished) {
            [startInterface.view removeFromSuperview];
        }];
    });
}

+ (void)pushFrom:(UIViewController *)fromVC toViewController:(UIViewController *)toVC completion:(void(^)(void))completion
{
    UIView *lastView = fromVC.view;
    [self ly_setWindowRootViewController:toVC];
    [[UIApplication sharedApplication].keyWindow insertSubview:lastView atIndex:0];
    toVC.view.frame = CGRectMake([UIScreen mainScreen].bounds.size.width, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    [UIView animateWithDuration:0.5 animations:^{
        lastView.frame = CGRectMake(-[UIScreen mainScreen].bounds.size.width, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        toVC.view.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    } completion:^(BOOL finished) {
        [lastView removeFromSuperview];
        if (completion) {completion();}
    }];
}

+ (void)popFrom:(UIViewController *)fromVC toViewController:(UIViewController *)toVC completion:(void(^)(void))completion
{
    UIView *lastView = fromVC.view;
    [self ly_setWindowRootViewController:toVC];
    [[UIApplication sharedApplication].keyWindow insertSubview:lastView atIndex:0];
    toVC.view.frame = CGRectMake(-[UIScreen mainScreen].bounds.size.width, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    [UIView animateWithDuration:0.5 animations:^{
        lastView.frame = CGRectMake([UIScreen mainScreen].bounds.size.width, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        toVC.view.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    } completion:^(BOOL finished) {
        [lastView removeFromSuperview];
        if (completion) {completion();}
    }];
}
@end
