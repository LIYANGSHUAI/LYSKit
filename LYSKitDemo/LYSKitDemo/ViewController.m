//
//  ViewController.m
//  LYSKitDemo
//
//  Created by HENAN on 2017/11/6.
//  Copyright © 2017年 HENAN. All rights reserved.
//

#import "ViewController.h"
#import "LYSKit.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    [self.view ly_tapGesture:^(UITapGestureRecognizer *sender, UIView *view) {
//
//        NSString *str = [NSString stringWithFormat:@"%ld",(long)[LYS_Reachability ly_reachabilityForInternetConnection].currentReachabilityStatus];
//
//        [self ly_alertTitle:@"提示" message:str comfirmStr:@"确定" comfirmAction:^{
//            NSLog(@"完成");
//        }];
//    } tapNum:1 touchNum:1];
    
    NSArray *ary = @[[UIColor blueColor],
                     [UIColor yellowColor],
                     [UIColor redColor],
                     [UIColor greenColor],
                     [UIColor whiteColor],
                     [UIColor orangeColor]
    
    ];
    
    [LYSystemManager ly_notifitionReachability:^(LYS_Reachability *reachability) {
        self.view.backgroundColor = ary[reachability.currentReachabilityStatus];
    } reachability:[LYS_Reachability ly_reachabilityForInternetConnection] promptly:YES];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
