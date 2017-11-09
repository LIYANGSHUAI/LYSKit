//
//  UITabBar+LYSCategory.m
//  LYSKitDemo
//
//  Created by HENAN on 2017/11/9.
//  Copyright © 2017年 HENAN. All rights reserved.
//

#import "UITabBar+LYSCategory.h"
#import "UIImage+LYSCategory.h"
@implementation UITabBar (LYSCategory)
// 设置导航条顶部线的alpha
- (void)ly_setBarButtonLineColor:(UIColor *)color
                           alpha:(CGFloat)alpha
{
    UIImage *image = [UIImage ly_imageWithColor:color alpha:alpha];
    [self setShadowImage:image];
}
// 隐藏导航条背景图片
- (void)ly_hiddenBackgroundImage
{
    [self setBackgroundImage:nil];
}
// 隐藏背景图片,并给一个给定alpha的图片
- (void)ly_hiddenAndSetBackgroundImageColor:(UIColor *)color
                                      alpha:(CGFloat)alpha
{
    UIImage *image = [UIImage ly_imageWithColor:color alpha:alpha];
    [self setBackgroundImage:image];
}
// 设置背景图片
- (void)ly_setBackgroundImage:(UIImage *)image
{
    [self setBackgroundImage:image];
}
@end
