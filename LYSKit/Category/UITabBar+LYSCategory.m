//
//  UITabBar+LYSCategory.m
//  LYSKitDemo
//
//  Created by HENAN on 2017/12/6.
//  Copyright © 2017年 HENAN. All rights reserved.
//

#import "UITabBar+LYSCategory.h"
#import "UIImage+LYSCategory.h"

@implementation UITabBar (LYSCategory)
- (void)setBarButtonLineColor:(UIColor *)color
                           alpha:(CGFloat)alpha
{
    UIImage *image = [UIImage imageWithColor:color alpha:alpha];
    [self setShadowImage:image];
}
- (void)hiddenBackgroundImage
{
    [self setBackgroundImage:nil];
}
- (void)hiddenAndSetBackgroundImageColor:(UIColor *)color
                                      alpha:(CGFloat)alpha
{
    UIImage *image = [UIImage imageWithColor:color alpha:alpha];
    [self setBackgroundImage:image];
}
- (void)setBackgroundImage:(UIImage *)image
{
    [self setBackgroundImage:image];
}
@end
