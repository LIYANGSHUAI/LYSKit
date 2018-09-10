//
//  UIView+LYSFrame.h
//  LYSKitDemo
//
//  Created by HENAN on 2018/9/4.
//  Copyright © 2018年 liyangshuai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (LYSFrame)
/// 左位置
@property(nonatomic, assign) CGFloat ly_left;
/// 右位置
@property(nonatomic, assign) CGFloat ly_right;
/// 上位置
@property(nonatomic, assign) CGFloat ly_top;
/// 下位置
@property(nonatomic, assign) CGFloat ly_bottom;

/// 宽位置
@property(nonatomic, assign) CGFloat ly_width;
/// 高位置
@property(nonatomic, assign) CGFloat ly_height;
/// 宽和高
@property (nonatomic,assign) CGSize ly_size;

/// 中心点
@property(nonatomic, assign) CGPoint ly_center;
/// 中心点x
@property(nonatomic, assign) CGFloat ly_centerX;
/// 中心点y
@property(nonatomic, assign) CGFloat ly_centerY;

/// 内部中心点
@property(nonatomic, assign, readonly) CGPoint ly_interiorCenter;
/// 内部中心点x
@property(nonatomic, assign, readonly) CGFloat ly_interiorCenterX;
/// 内部中心点y
@property(nonatomic, assign, readonly) CGFloat ly_interiorCenterY;

@end
