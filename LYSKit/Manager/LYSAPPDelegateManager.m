//
//  LYSAPPDelegateManager.m
//  LYSKitDemo
//
//  Created by HENAN on 2017/12/5.
//  Copyright © 2017年 HENAN. All rights reserved.
//

#import "LYSAPPDelegateManager.h"

@implementation LYSAPPDelegateManager
+ (void)createWindowAndSetRootViewController:(UIViewController *)rootViewController
{
    if ([UIApplication sharedApplication].delegate == nil) {return;}
    [[UIApplication sharedApplication].delegate setWindow:[[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds]];
    [[[UIApplication sharedApplication].delegate window] setRootViewController:rootViewController];
    [[[UIApplication sharedApplication].delegate window] makeKeyAndVisible];
}
+ (void)setWindowRootViewController:(UIViewController *)rootViewController
{
    if ([UIApplication sharedApplication].delegate == nil) {return;}
    [[[UIApplication sharedApplication].delegate window] setRootViewController:rootViewController];
}
+ (void)judge:(BOOL(^)(void))ispermit showViewController:(UIViewController *)firstViewController elseShowViewController:(UIViewController *)secoundViewController
{
    if (ispermit())
    {
        [self createWindowAndSetRootViewController:firstViewController];
    }else
    {
        [self createWindowAndSetRootViewController:secoundViewController];
    }
}
+ (void)createWindowAndloadStartInterface:(UIViewController *)startInterface mainInterface:(UIViewController *)mainInterface delay:(NSTimeInterval)interval durtion:(NSTimeInterval)durtion
{
    [self createWindowAndSetRootViewController:startInterface];
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
    [self setWindowRootViewController:toVC];
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
    [self setWindowRootViewController:toVC];
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
