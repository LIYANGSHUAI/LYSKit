//
//  UIView+LYS.h
//  LYSKit
//
//  Created by HENAN on 2018/2/26.
//  Copyright © 2018年 liyangshuai. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark - UIView视图振动方向枚举值 -

/**
 控件振动的方向
 
 - LYSQHLDirectionHorizontal:               垂直方向
 - LYSQHLDirectionVertical:                 水平方向
 */

typedef NS_ENUM(NSInteger, LYSQHLDirection) {
    LYSQHLDirectionHorizontal,
    LYSQHLDirectionVertical
};

@interface UIView (LYS)

- (NSMutableArray *)ly_getTopSubViews;
- (UIViewController*)ly_getRootViewController;

- (void)ly_shakeWithShakeDirection:(LYSQHLDirection)shakeDirection;
- (void)ly_shakeWithTimes:(NSInteger)times shakeDirection:(LYSQHLDirection)shakeDirection;
- (void)ly_shakeWithTimes:(NSInteger)times speed:(CGFloat)speed shakeDirection:(LYSQHLDirection)shakeDirection;
- (void)ly_shakeWithTimes:(NSInteger)times speed:(CGFloat)speed range:(CGFloat)range shakeDirection:(LYSQHLDirection)shakeDirection;

- (void)ly_showLoadingWithColor:(UIColor *)color;
- (void)ly_hiddenLoadingView;

- (void)ly_tapGesture:(void(^)(UITapGestureRecognizer *sender,UIView *view))tapGesture tapNum:(NSInteger)tapNum touchNum:(NSInteger)touchNum;
@end
