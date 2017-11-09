//
//  UIView+LYSCategory.h
//  LYSKitDemo
//
//  Created by HENAN on 2017/11/9.
//  Copyright © 2017年 HENAN. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 控件振动的方向
 
 - LYSQHLDirectionHorizontal: 垂直方向
 - LYSQHLDirectionVertical: 水平方向
 */
typedef NS_ENUM(NSInteger, LYSQHLDirection) {
    LYSQHLDirectionHorizontal,
    LYSQHLDirectionVertical
};
@interface UIView (LYSCategory)
/**
 获取某个view的叶子View(一般为Window)
 
 @return 叶子view数组
 */
- (NSMutableArray *)ly_getTopSubViews;

/**
 获取当前视图所在的根视图控制器
 
 @return 返回跟视图控制器
 */
- (UIViewController*)ly_getRootViewController;

/**
 传一个振动的方向
 
 @param shakeDirection 振动的方向
 */
- (void)ly_shakeWithShakeDirection:(LYSQHLDirection)shakeDirection;

/**
 传一个振动的次数和振动的方向
 
 @param times 振动的次数
 @param shakeDirection 振动的方向
 */
- (void)ly_shakeWithTimes:(NSInteger)times
           shakeDirection:(LYSQHLDirection)shakeDirection;

/**
 传一个振动的次数,振动的速度和振动的方向
 
 @param times 振动的次数
 @param speed 振动的速度
 @param shakeDirection 振动的方向
 */
- (void)ly_shakeWithTimes:(NSInteger)times
                    speed:(CGFloat)speed
           shakeDirection:(LYSQHLDirection)shakeDirection;

/**
 传一个振动的次数,振动的速度,振动的幅度和振动的方向
 
 @param times 振动的次数
 @param speed 振动的速度
 @param range 振动的幅度
 @param shakeDirection 振动的方向
 */
- (void)ly_shakeWithTimes:(NSInteger)times
                    speed:(CGFloat)speed
                    range:(CGFloat)range
           shakeDirection:(LYSQHLDirection)shakeDirection;

/**
 添加加载圈
 
 @param color 加载圈的颜色
 */
- (void)ly_showLoadingWithColor:(UIColor *)color;

/**
 隐藏加载圈
 */
- (void)ly_hiddenLoadingView;

/**
 给一个视图控件添加点击手势
 
 @param tapGesture 手势回调
 @param tapNum 触发回调的点击次数
 @param touchNum 触发回调的手指个数
 */
- (void)ly_tapGesture:(void(^)(UITapGestureRecognizer *sender,UIView *view))tapGesture
               tapNum:(NSInteger)tapNum
             touchNum:(NSInteger)touchNum;
@end
