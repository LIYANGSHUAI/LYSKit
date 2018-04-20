//
//  ViewController.m
//  LYSKitDemo
//
//  Created by HENAN on 2018/4/20.
//  Copyright © 2018年 liyangshuai. All rights reserved.
//

#import "ViewController.h"
#import "LYSKit.h"

@interface ViewController ()
@property (nonatomic,copy)NSString *(^block)(NSString *str);
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // NSDate
    NSLog(@"%@",[NSDate ly_stringWithDate:LYSCurrentDate formatter:(lyDateFormatterOptionStandardDateFormatBar)]);
    NSLog(@"%@",[NSDate ly_stringWithCurrentDateFormatter:(lyDateFormatterOptionStandardDateFormatBar)]);
    NSLog(@"%@",[LYSCurrentDate ly_stringWithFormatter:lyDateFormatterOptionStandardDateFormatBar]);
    
    NSLog(@"%@",[NSDate ly_dateWithString:@"2018-01-01 12:00:00" formatter:@"yyyy-MM-dd HH:mm:ss"]);
    
    {
        NSDate *date = [NSDate ly_dateWithString:@"2017-01-01 12:00:00" formatter:@"yyyy-MM-dd HH:mm:ss"];
        NSLog(@"%@",[NSDate ly_compareCurrentTime:date]);
    }
    
    {
        NSDate *date = [NSDate ly_dateSincleNow:2];
        NSLog(@"%@",[NSDate ly_compareCurrentTime:date]);
    }
    
    {
        NSDate *date = [NSDate ly_dateYesterday];
        NSLog(@"%@",[NSDate ly_compareCurrentTime:date]);
    }
    
    {
        NSDate *date = [NSDate ly_dateTomorrow];
        NSLog(@"%@",[NSDate ly_compareCurrentTime:date]);
    }
    
    NSLog(@"LYSUserPhoneName-%@",LYSUserPhoneName);
    NSLog(@"LYSDeviceName-%@",LYSDeviceName);
    NSLog(@"LYSDeviceModel-%@",LYSDeviceModel);
    NSLog(@"LYSDeviceLocalModel-%@",LYSDeviceLocalModel);
    NSLog(@"LYSProjectName-%@",LYSProjectName);
    NSLog(@"LYSAppCurVersion-%@",LYSAppCurVersion);
    NSLog(@"LYSAppCurVersionBuild-%@",LYSAppCurVersionBuild);
    NSLog(@"LYSystemVersion-%@",LYSystemVersion);
    
    NSLog(@"LYSDeviceStringIntegrity-%@",LYSDeviceStringIntegrity);
    NSLog(@"LYSDeviceStringSimpleness-%@",LYSDeviceStringSimpleness);
    
    
    NSLog(@"%d",[@"xxx" ly_containsString:@"x"]);
    
    
    NSLog(@"%d",[LYSDefineManager ly_randomA:0 B:10]);
    NSLog(@"%d",[LYSDefineManager ly_random_uniformA:0 B:10]);
    
    NSLog(@"%d",LYSRandom(0, 10));
    NSLog(@"%d",LYSRandom_uniform(10, 20));
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
