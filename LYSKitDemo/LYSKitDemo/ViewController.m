//
//  ViewController.m
//  LYSKitDemo
//
//  Created by HENAN on 2017/11/6.
//  Copyright © 2017年 HENAN. All rights reserved.
//

#import "ViewController.h"
#import "LYSKit.h"
#import "LYSLocationManager.h"
@interface ViewController ()<LYSLocationManagerDelegate>

@end

@implementation ViewController
{
    LYSLocationManager *manager;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
  
    manager = [LYSLocationManager loactionWithDelegate:self];
    [manager startLocation];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didUpdate:) name:LYSLocationDidUpdateNotifition object:nil];
}
- (void)didUpdate:(NSNotification *)notifition
{
    CLLocation *location = notifition.userInfo[LYSLocationUserInfoKey];
    NSLog(@"%@",location);
        [manager geocoder:location success:^(CLPlacemark *placemark) {
            NSLog(@"%@",placemark);
        }];
}
//- (void)manager:(LYSLocationManager *)manager didUpdateLocation:(CLLocation *)location{
//    NSLog(@"%@",location);
//    [manager geocoder:location success:^(CLPlacemark *placemark) {
//        NSLog(@"%@",placemark);
//    }];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
