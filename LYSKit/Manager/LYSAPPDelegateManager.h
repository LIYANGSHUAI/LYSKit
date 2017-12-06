//
//  LYSAPPDelegateManager.h
//  LYSKitDemo
//
//  Created by HENAN on 2017/12/5.
//  Copyright © 2017年 HENAN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LYSAPPDelegateManager : NSObject

// Setting up window's heel view controller
+ (void)createWindowAndSetRootViewController:(UIViewController *)rootViewController;
+ (void)setWindowRootViewController:(UIViewController *)rootViewController;

// Different view controllers are displayed separately according to the return conditions
+ (void)judge:(BOOL(^)(void))ispermit showViewController:(UIViewController *)firstViewController elseShowViewController:(UIViewController *)secoundViewController;

// Setting up the startup animation
+ (void)createWindowAndloadStartInterface:(UIViewController *)startInterface mainInterface:(UIViewController *)mainInterface delay:(NSTimeInterval)interval durtion:(NSTimeInterval)durtion;

// Imitating navigation into the next level page
+ (void)pushFrom:(UIViewController *)fromVC toViewController:(UIViewController *)toVC completion:(void(^)(void))completion;
+ (void)popFrom:(UIViewController *)fromVC toViewController:(UIViewController *)toVC completion:(void(^)(void))completion;
@end
