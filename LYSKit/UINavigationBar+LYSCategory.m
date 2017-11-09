//
//  UINavigationBar+LYSCategory.m
//  LYSKitDemo
//
//  Created by HENAN on 2017/11/9.
//  Copyright © 2017年 HENAN. All rights reserved.
//

#import "UINavigationBar+LYSCategory.h"
#import "UIImage+LYSCategory.h"
@implementation UINavigationBar (LYSCategory)
// 获取导航底部细线
- (UIView *)ly_navigationBarBottomLine
{
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:NSClassFromString(@"_UIBarBackground")]) {
            for (UIView *temView in view.subviews) {
                if ([temView isKindOfClass:NSClassFromString(@"UIImageView")]) {
                    return temView;
                }
            }
        }
    }
    return nil;
}
// 隐藏导航条背景图片
- (void)ly_hiddenBackgroundImage
{
    [self setBackgroundImage:nil forBarMetrics:(UIBarMetricsDefault)];
}
// 隐藏背景图片,并给一个给定alpha的图片
- (void)ly_hiddenAndSetBackgroundImageColor:(UIColor *)color
                                      alpha:(CGFloat)alpha
{
    [self setBackgroundImage:nil forBarMetrics:(UIBarMetricsDefault)];
    [self setBackgroundImage:[UIImage ly_imageWithColor:color alpha:alpha] forBarMetrics:(UIBarMetricsDefault)];
}
// 设置导航背景图片
- (void)ly_setBackgroundImage:(UIImage *)image
{
    [self setBackgroundImage:image forBarMetrics:(UIBarMetricsDefault)];
}
@end
