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
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self alertTitle:@"提示" message:@"你好" comfirmStr:@"确定" comfirmAction:^{
        NSLog(@"w");
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
