//
//  ViewController.m
//  LYSKitDemo
//
//  Created by HENAN on 2018/2/26.
//  Copyright © 2018年 liyangshuai. All rights reserved.
//

#import "ViewController.h"
#import "LYSKit.h"

@interface ViewController ()<LYSLocationDelegate>


@end

@implementation ViewController
{
    LYSLocation *location;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    location = [[LYSLocation alloc] init];
    location.delegate = self;
    [location startLocation];
}

- (void)location:(LYSLocation *)mlocation didUpdateLocation:(CLLocation *)location{
    NSLog(@"%@",location);
}

- (void)location:(LYSLocation *)mlocation didFailLocation:(NSError *)error {
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
