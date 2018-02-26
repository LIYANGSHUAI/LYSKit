//
//  UINavigationBar+LYS.m
//  LYSKit
//
//  Created by HENAN on 2018/2/26.
//  Copyright © 2018年 liyangshuai. All rights reserved.
//

#import "UINavigationBar+LYS.h"
#import "UIImage+LYS.h"

#define ISKINDOFCLASS(A,B) [A isKindOfClass:NSClassFromString(B)]

@implementation UINavigationBar (LYS)
- (void)ly_hiddenNavigationBarBottomLine
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0)
    {
        for (UIView *view in self.subviews) {
            if (ISKINDOFCLASS(view, @"_UIBarBackground")) {
                for (UIView *temView in view.subviews) {
                    if (ISKINDOFCLASS(temView,@"UIImageView") && CGRectGetHeight(temView.frame) <= 1) {
                        temView.hidden = YES;
                    }
                }
            }
        }
    }
    else
    {
        for (UIView *view in self.subviews) {
            if (ISKINDOFCLASS(view, @"_UINavigationBarBackground")) {
                for (UIView *temView in view.subviews) {
                    if (ISKINDOFCLASS(temView,@"UIImageView") && CGRectGetHeight(temView.frame) <= 1) {
                        temView.hidden = YES;
                    }
                }
            }
        }
    }
}

- (void)ly_showNavigationBarBottomLine{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0)
    {
        for (UIView *view in self.subviews) {
            if (ISKINDOFCLASS(view, @"_UIBarBackground")) {
                for (UIView *temView in view.subviews) {
                    if (ISKINDOFCLASS(temView,@"UIImageView") && CGRectGetHeight(temView.frame) <= 1) {
                        temView.hidden = NO;
                    }
                }
            }
        }
    }
    else
    {
        for (UIView *view in self.subviews) {
            if (ISKINDOFCLASS(view, @"_UINavigationBarBackground")) {
                for (UIView *temView in view.subviews) {
                    if (ISKINDOFCLASS(temView,@"UIImageView") && CGRectGetHeight(temView.frame) <= 1) {
                        temView.hidden = NO;
                    }
                }
            }
        }
    }
}

- (void)ly_hiddenBackgroundImage
{
    [self setBackgroundImage:[UIImage ly_imageWithColor:[UIColor clearColor] alpha:0] forBarMetrics:(UIBarMetricsDefault)];
}

- (void)ly_setBackgroundImage:(UIImage *)image
{
    [self setBackgroundImage:image forBarMetrics:(UIBarMetricsDefault)];
}

@end
