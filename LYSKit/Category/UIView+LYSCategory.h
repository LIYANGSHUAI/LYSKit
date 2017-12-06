//
//  UIView+LYSCategory.h
//  LYSKitDemo
//
//  Created by HENAN on 2017/12/6.
//  Copyright © 2017年 HENAN. All rights reserved.
//

#import <UIKit/UIKit.h>

// The direction of the vibration of the control
typedef NS_ENUM(NSInteger, LYSQHLDirection) {
    LYSQHLDirectionHorizontal,
    LYSQHLDirectionVertical
};

@interface UIView (LYSCategory)

// Get the leaf View of a view (generally Window)
- (NSMutableArray *)getTopSubViews;

// Get the root view controller where the current view is located
- (UIViewController*)getRootViewController;

// Vibratory view
- (void)shakeWithShakeDirection:(LYSQHLDirection)shakeDirection;
- (void)shakeWithTimes:(NSInteger)times shakeDirection:(LYSQHLDirection)shakeDirection;
- (void)shakeWithTimes:(NSInteger)times speed:(CGFloat)speed shakeDirection:(LYSQHLDirection)shakeDirection;
- (void)shakeWithTimes:(NSInteger)times speed:(CGFloat)speed range:(CGFloat)range shakeDirection:(LYSQHLDirection)shakeDirection;

// Add load ring
- (void)showLoadingWithColor:(UIColor *)color;
- (void)hiddenLoadingView;

// Add click gestures to a view control
- (void)tapGesture:(void(^)(UITapGestureRecognizer *sender,UIView *view))tapGesture tapNum:(NSInteger)tapNum touchNum:(NSInteger)touchNum;
@end
