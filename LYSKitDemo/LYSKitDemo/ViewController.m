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
    
    [self.view ly_tapGesture:^(UITapGestureRecognizer *sender, UIView *view) {
        [self ly_alertTitle:@"提示" message:@"你好!!" comfirmStr:@"确定" comfirmAction:^{
            NSLog(@"完成");
            [LYSLocationManager ly_location:^(CLLocation *location) {
                NSLog(@"%@",location);
            } fail:^(NSString *state) {
                NSLog(@"%@",state);
            }];
        }];
    } tapNum:1 touchNum:1];
    
    NSArray *ary = @[[UIColor blueColor],
                     [UIColor yellowColor],
                     [UIColor redColor],
                     [UIColor greenColor],
                     [UIColor whiteColor],
                     [UIColor orangeColor]
    
    ];
    
    [LYSReachabilityManager ly_notifitionReachability:^(LYSReachability *reachability) {
        self.view.backgroundColor = ary[reachability.currentReachabilityStatus];
    } reachability:[LYSReachability ly_reachabilityForInternetConnection] promptly:YES];
    
    NSLog(@"%@",LYSTuple(@14, @12).one);
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
