//
//  UINavigationBar+LYSCategory.m
//  LYSKitDemo
//
//  Created by HENAN on 2018/4/20.
//  Copyright © 2018年 liyangshuai. All rights reserved.
//

#import "UINavigationBar+LYSCategory.h"

#define ISKINDOFCLASS(A,B) [A isKindOfClass:NSClassFromString(B)]

@implementation UINavigationBar (LYSCategory)

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
    [self setBackgroundImage:[self ly_imageWithColor:[UIColor clearColor] alpha:0] forBarMetrics:(UIBarMetricsDefault)];
}

- (void)ly_setBackgroundImage:(UIImage *)image
{
    [self setBackgroundImage:image forBarMetrics:(UIBarMetricsDefault)];
}

- (UIImage *)ly_imageWithColor:(UIColor *)color alpha:(CGFloat)alpha
{
    // 创建一个color对象
    UIColor *tempColor = [color colorWithAlphaComponent:alpha];
    // 声明一个绘制大小
    CGSize colorSize = CGSizeMake(1, 1);
    UIGraphicsBeginImageContext(colorSize);
    // 开始绘制颜色区域
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 根据提供的颜色给相应绘制内容填充
    CGContextSetFillColorWithColor(context, tempColor.CGColor);
    // 设置填充相应的区域
    CGContextFillRect(context, CGRectMake(0, 0, 1, 1));
    // 声明UIImage对象
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}
@end
