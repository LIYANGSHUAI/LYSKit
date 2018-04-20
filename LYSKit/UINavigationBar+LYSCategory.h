//
//  UINavigationBar+LYSCategory.h
//  LYSKitDemo
//
//  Created by HENAN on 2018/4/20.
//  Copyright © 2018年 liyangshuai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationBar (LYSCategory)
/**
 隐藏导航底部细线
 */
- (void)ly_hiddenNavigationBarBottomLine;

/**
 显示导航底部细线
 */
- (void)ly_showNavigationBarBottomLine;

/**
 隐藏导航条背景图片
 */
- (void)ly_hiddenBackgroundImage;

/**
 设置导航背景图片
 
 @param image                               背景图片
 */
- (void)ly_setBackgroundImage:(UIImage *)image;
@end
