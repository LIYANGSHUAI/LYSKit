//
//  UITabBar+LYSCategory.h
//  LYSKitDemo
//
//  Created by HENAN on 2017/12/6.
//  Copyright © 2017年 HENAN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBar (LYSCategory)

// Set the alpha of the top line of the navigation bar
- (void)setBarButtonLineColor:(UIColor *)color alpha:(CGFloat)alpha;

// Hidden navigation bar background picture
- (void)hiddenBackgroundImage;

// Hide the background picture and give a picture of a given alpha
- (void)hiddenAndSetBackgroundImageColor:(UIColor *)color
                                      alpha:(CGFloat)alpha;
// Setting the background picture
- (void)setBackgroundImage:(UIImage *)image;
@end

