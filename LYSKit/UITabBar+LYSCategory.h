//
//  UITabBar+LYSCategory.h
//  LYSKitDemo
//
//  Created by HENAN on 2018/4/20.
//  Copyright © 2018年 liyangshuai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBar (LYSCategory)
/**
 隐藏导航条顶部线的alpha
 */
- (void)ly_hiddenTabbarTopLine;

/**
 显示导航条顶部线的alpha
 */
- (void)ly_showTabbarTopLine;

/**
 隐藏导航条背景图片
 */
- (void)ly_hiddenBackgroundImage;

/**
 设置背景图片
 
 @param image                               设置背景图片
 */
- (void)ly_setBackgroundImage:(UIImage *)image;

@end
