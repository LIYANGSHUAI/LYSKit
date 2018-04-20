//
//  UIView+LYSCategory.m
//  LYSKitDemo
//
//  Created by HENAN on 2018/4/20.
//  Copyright © 2018年 liyangshuai. All rights reserved.
//

#import "UIView+LYSCategory.h"
#import <objc/runtime.h>

@implementation UIView (LYSCategory)
- (NSMutableArray *)ly_getTopSubViews
{
    NSMutableArray *stack = [NSMutableArray array];
    NSMutableArray *leafNodes = [NSMutableArray array];
    if (self.subviews.count == 0) {return nil;}
    [stack addObjectsFromArray:self.subviews];
    while (stack.count != 0)
    {
        UIView *subView = [stack lastObject];
        [stack removeLastObject];
        if (subView.subviews.count != 0)
        {
            [stack addObjectsFromArray:subView.subviews];
        }else
        {
            [leafNodes addObject:subView];
        }
    }
    return leafNodes;
}

- (UIViewController *)ly_getRootViewController
{
    UIResponder *res = self;
    while (res) {
        if (res.nextResponder)
        {
            res = res.nextResponder;
        }
        if ([res isKindOfClass:[UIViewController class]])
        {
            UIViewController *vc = (UIViewController*)res;
            return vc;
        }
    }
    return nil;
}

- (void)ly_shakeWithShakeDirection:(LYSQHLDirection)shakeDirection
{
    [self ly_shakeWithTimes:10
                      speed:0.05
                      range:5
             shakeDirection:shakeDirection];
}

- (void)ly_shakeWithTimes:(NSInteger)times shakeDirection:(LYSQHLDirection)shakeDirection
{
    [self ly_shakeWithTimes:times
                      speed:0.05
                      range:5
             shakeDirection:shakeDirection];
}

- (void)ly_shakeWithTimes:(NSInteger)times speed:(CGFloat)speed shakeDirection:(LYSQHLDirection)shakeDirection
{
    [self ly_shakeWithTimes:times
                      speed:speed
                      range:5
             shakeDirection:shakeDirection];
}

- (void)ly_shakeWithTimes:(NSInteger)times speed:(CGFloat)speed range:(CGFloat)range shakeDirection:(LYSQHLDirection)shakeDirection
{
    [self viewShakesWithTiems:times
                        speed:speed
                        range:range
               shakeDirection:shakeDirection
                 currentTimes:0 direction:1];
}

- (void)viewShakesWithTiems:(NSInteger)times speed:(CGFloat)speed range:(CGFloat)range shakeDirection:(LYSQHLDirection)shakeDirection currentTimes:(NSInteger)currentTimes direction:(int)direction
{
    [UIView animateWithDuration:speed animations:^{
        self.transform = (shakeDirection == LYSQHLDirectionHorizontal)? CGAffineTransformMakeTranslation(range * direction, 0):CGAffineTransformMakeTranslation(0, range * direction);
    } completion:^(BOOL finished) {
        if (currentTimes >= times)
        {
            [UIView animateWithDuration:speed animations:^{
                self.transform = CGAffineTransformIdentity;
            }];
            return;
        }
        [self viewShakesWithTiems:times - 1
                            speed:speed
                            range:range
                   shakeDirection:shakeDirection
                     currentTimes:currentTimes + 1
                        direction:direction * -1];
    }];
}

- (void)ly_showLoadingWithColor:(UIColor *)color
{
    UIActivityIndicatorView *indicatorView = objc_getAssociatedObject(self, @"LYS_loadingView") == nil ? nil : (UIActivityIndicatorView *)objc_getAssociatedObject(self, @"LYS_loadingView");
    if (indicatorView != nil)
    {
        [indicatorView stopAnimating];
        [indicatorView removeFromSuperview];
        objc_setAssociatedObject(self, @"LYS_loadingView", nil, OBJC_ASSOCIATION_RETAIN);
    }else
    {
        UIActivityIndicatorView *indicatorView = [[UIActivityIndicatorView alloc] init];
        [self addSubview:indicatorView];
        indicatorView.color = color;
        [indicatorView startAnimating];
        indicatorView.alpha = 0;
        indicatorView.userInteractionEnabled = NO;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            indicatorView.frame = self.bounds;
        });
        [UIView animateWithDuration:0.5 animations:^{
            indicatorView.alpha = 1;
        } completion:^(BOOL finished) {
            objc_setAssociatedObject(self, @"LYS_loadingView", indicatorView, OBJC_ASSOCIATION_RETAIN);
        }];
    }
}

- (void)ly_hiddenLoadingView
{
    UIActivityIndicatorView *indicatorView = objc_getAssociatedObject(self, @"LYS_loadingView") == nil ? nil : (UIActivityIndicatorView *)objc_getAssociatedObject(self, @"LYS_loadingView");
    if (indicatorView != nil)
    {
        [UIView animateWithDuration:0.5 animations:^{
            indicatorView.alpha = 0;
        } completion:^(BOOL finished) {
            [indicatorView stopAnimating];
            [indicatorView removeFromSuperview];
            objc_setAssociatedObject(self, @"LYS_loadingView", nil, OBJC_ASSOCIATION_RETAIN);
        }];
    }
}

- (void)ly_tapGesture:(void(^)(UITapGestureRecognizer *sender,UIView *view))tapGesture
               tapNum:(NSInteger)tapNum
             touchNum:(NSInteger)touchNum
{
    if (tapGesture == nil) {return;}
    objc_setAssociatedObject(self, @"LYS_tapGesture", tapGesture, OBJC_ASSOCIATION_COPY);
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickAction:)];
    tap.numberOfTapsRequired = tapNum;
    tap.numberOfTouchesRequired = touchNum;
    [self addGestureRecognizer:tap];
}
- (void)clickAction:(id)sender
{
    id tapGesture = objc_getAssociatedObject(self, @"LYS_tapGesture");
    ((void(^)(UITapGestureRecognizer *sender,UIView *view))tapGesture)(sender,self);
}

@end
