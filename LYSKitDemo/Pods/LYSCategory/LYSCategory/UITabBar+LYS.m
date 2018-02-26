//
//  UITabBar+LYS.m
//  LYSKit
//
//  Created by HENAN on 2018/2/26.
//  Copyright © 2018年 liyangshuai. All rights reserved.
//

#import "UITabBar+LYS.h"
#import "UIImage+LYS.h"

#define ISKINDOFCLASS(A,B) [A isKindOfClass:NSClassFromString(B)]

@implementation UITabBar (LYS)
- (void)ly_hiddenTabbarTopLine
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0)
    {
        for (UIView *view in self.subviews) {
            if (ISKINDOFCLASS(view,@"_UIBarBackground")) {
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
            if (ISKINDOFCLASS(view,@"UIImageView") && CGRectGetHeight(view.frame) <= 1) {
                view.hidden = YES;
            }
        }
    }
}

- (void)ly_showTabbarTopLine
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0)
    {
        for (UIView *view in self.subviews) {
            if (ISKINDOFCLASS(view,@"_UIBarBackground")) {
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
            if (ISKINDOFCLASS(view,@"UIImageView") && CGRectGetHeight(view.frame) <= 1) {
                view.hidden = NO;
            }
        }
    }
}

- (void)ly_hiddenBackgroundImage
{
    UIImage *image = [UIImage ly_imageWithColor:[UIColor clearColor] alpha:0];
    [self setBackgroundImage:image];
}

- (void)ly_setBackgroundImage:(UIImage *)image
{
    [self setBackgroundImage:image];
}

@end
