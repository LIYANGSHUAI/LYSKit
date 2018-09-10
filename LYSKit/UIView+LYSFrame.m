//
//  UIView+LYSFrame.m
//  LYSKitDemo
//
//  Created by HENAN on 2018/9/4.
//  Copyright © 2018年 liyangshuai. All rights reserved.
//

#import "UIView+LYSFrame.h"

@implementation UIView (LYSFrame)
- (void)setLy_left:(CGFloat)ly_left
{
    CGRect frame = self.frame;
    frame.origin.x = ly_left;
    self.frame = frame;
}
- (void)setLy_top:(CGFloat)ly_top
{
    CGRect frame = self.frame;
    frame.origin.y = ly_top;
    self.frame = frame;
}
- (void)setLy_right:(CGFloat)ly_right
{
    CGRect frame = self.frame;
    frame.origin.x = ly_right - frame.size.width;
    self.frame = frame;
}
- (void)setLy_bottom:(CGFloat)ly_bottom
{
    CGRect frame = self.frame;
    frame.origin.y = ly_bottom - frame.size.height;
    self.frame = frame;
}
- (void)setLy_width:(CGFloat)ly_width
{
    CGRect frame = self.frame;
    frame.size.width = ly_width;
    self.frame = frame;
}
- (void)setLy_height:(CGFloat)ly_height
{
    CGRect frame = self.frame;
    frame.size.height = ly_height;
    self.frame = frame;
}
- (void)setLy_size:(CGSize)ly_size
{
    CGRect frame = self.frame;
    frame.size.width = ly_size.width;
    frame.size.height = ly_size.height;
    self.frame = frame;
}
- (void)setLy_center:(CGPoint)ly_center
{
    CGRect frame = self.frame;
    frame.origin = CGPointMake(ly_center.x - frame.size.width * 0.5, ly_center.y - frame.size.height * 0.5);
    self.frame = frame;
}
- (void)setLy_centerX:(CGFloat)ly_centerX
{
    CGRect frame = self.frame;
    frame.origin.x = ly_centerX - frame.size.width * 0.5;
    self.frame = frame;
}
- (void)setLy_centerY:(CGFloat)ly_centerY
{
    CGRect frame = self.frame;
    frame.origin.y = ly_centerY - frame.size.height * 0.5;
    self.frame = frame;
}
- (CGFloat)ly_left
{
    return self.frame.origin.x;
}
- (CGFloat)ly_top
{
    return self.frame.origin.y;
}
- (CGFloat)ly_right
{
    return self.frame.origin.x + self.frame.size.width;
}
- (CGFloat)ly_bottom
{
    return self.frame.origin.y + self.frame.size.height;
}
- (CGFloat)ly_width
{
    return self.frame.size.width;
}
- (CGFloat)ly_height
{
    return self.frame.size.height;
}
- (CGSize)ly_size
{
    return self.frame.size;
}
- (CGPoint)ly_center
{
    return CGPointMake(self.frame.origin.x + self.frame.size.width * 0.5, self.frame.origin.y + self.frame.size.height * 0.5);
}
- (CGFloat)ly_centerX
{
    return self.frame.origin.x + self.frame.size.width * 0.5;
}
- (CGFloat)ly_centerY
{
    return self.frame.origin.y + self.frame.size.height * 0.5;
}
- (CGPoint)ly_interiorCenter
{
    return CGPointMake(self.frame.size.width * 0.5, self.frame.size.height * 0.5);
}
- (CGFloat)ly_interiorCenterX
{
    return self.frame.size.width * 0.5;
}
- (CGFloat)ly_interiorCenterY
{
    return self.frame.size.height * 0.5;
}
@end
