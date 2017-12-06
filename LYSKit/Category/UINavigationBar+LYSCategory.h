//
//  UINavigationBar+LYSCategory.h
//  LYSKitDemo
//
//  Created by HENAN on 2017/12/6.
//  Copyright © 2017年 HENAN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationBar (LYSCategory)

// Get the bottom line of the navigation
- (UIView *)navigationBarBottomLine;

// Hidden navigation bar background picture
- (void)hiddenBackgroundImage;

// Hide the background picture and give a picture of a given alpha
- (void)hiddenAndSetBackgroundImageColor:(UIColor *)color alpha:(CGFloat)alpha;

// Setting the navigation background picture
- (void)setBackgroundImage:(UIImage *)image;
@end
