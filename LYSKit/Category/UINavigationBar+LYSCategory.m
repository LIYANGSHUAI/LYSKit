//
//  UINavigationBar+LYSCategory.m
//  LYSKitDemo
//
//  Created by HENAN on 2017/12/6.
//  Copyright © 2017年 HENAN. All rights reserved.
//

#import "UINavigationBar+LYSCategory.h"
#import "UIImage+LYSCategory.h"
@implementation UINavigationBar (LYSCategory)
- (UIView *)navigationBarBottomLine
{
    for (UIView *view in self.subviews)
    {
        if ([view isKindOfClass:NSClassFromString(@"_UIBarBackground")])
        {
            for (UIView *temView in view.subviews)
            {
                if ([temView isKindOfClass:NSClassFromString(@"UIImageView")])
                {
                    return temView;
                }
            }
        }
    }
    return nil;
}
- (void)hiddenBackgroundImage
{
    [self setBackgroundImage:nil forBarMetrics:(UIBarMetricsDefault)];
}
- (void)hiddenAndSetBackgroundImageColor:(UIColor *)color
                                      alpha:(CGFloat)alpha
{
    [self setBackgroundImage:nil forBarMetrics:(UIBarMetricsDefault)];
    [self setBackgroundImage:[UIImage imageWithColor:color alpha:alpha] forBarMetrics:(UIBarMetricsDefault)];
}
- (void)setBackgroundImage:(UIImage *)image
{
    [self setBackgroundImage:image forBarMetrics:(UIBarMetricsDefault)];
}
@end
