//
//  UINavigationBar+LYSCategory.h
//  LYSKitDemo
//
//  Created by HENAN on 2017/11/9.
//  Copyright © 2017年 HENAN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationBar (LYSCategory)

/**
 获取导航底部细线
 
 @return 返回细线视图
 */
- (UIView *)ly_navigationBarBottomLine;

/**
 隐藏导航条背景图片
 */
- (void)ly_hiddenBackgroundImage;

/**
 隐藏背景图片,并给一个给定alpha的图片
 
 @param color 背景图片的颜色
 @param alpha 背景图片的透明度
 */
- (void)ly_hiddenAndSetBackgroundImageColor:(UIColor *)color
                                      alpha:(CGFloat)alpha;

/**
 设置导航背景图片
 
 @param image 背景图片
 */
- (void)ly_setBackgroundImage:(UIImage *)image;
@end
