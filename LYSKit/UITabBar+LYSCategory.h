//
//  UITabBar+LYSCategory.h
//  LYSKitDemo
//
//  Created by HENAN on 2017/11/9.
//  Copyright © 2017年 HENAN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBar (LYSCategory)
/**
 设置导航条顶部线的alpha
 
 @param color 颜色
 @param alpha 透明度
 */
- (void)ly_setBarButtonLineColor:(UIColor *)color
                           alpha:(CGFloat)alpha;

/**
 隐藏导航条背景图片
 */
- (void)ly_hiddenBackgroundImage;

/**
 隐藏背景图片,并给一个给定alpha的图片
 
 @param color 颜色
 @param alpha 透明度
 */
- (void)ly_hiddenAndSetBackgroundImageColor:(UIColor *)color
                                      alpha:(CGFloat)alpha;

/**
 设置背景图片
 
 @param image 设置背景图片
 */
- (void)ly_setBackgroundImage:(UIImage *)image;
@end
