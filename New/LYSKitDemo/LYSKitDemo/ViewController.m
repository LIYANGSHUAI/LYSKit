//
//  ViewController.m
//  LYSKitDemo
//
//  Created by HENAN on 2018/4/20.
//  Copyright © 2018年 liyangshuai. All rights reserved.
//

#import "ViewController.h"
#import "LYSKit.h"

// key跟后台协商一个即可，保持一致
static NSString *const PSW_AES_KEY = @"这里填写客户端跟后台商量的key";
// 这里的偏移量也需要跟后台一致，一般跟key一样就行
static NSString *const AES_IV_PARAMETER = @"偏移量";
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
    
    NSLog(@"%d",LYSISIPhone_X);
    
    NSLog(@"%@",LYSStringFormat(@"%@/%@",@"11",@"00"));
    
    NSLog(@"%ld",[LYSDateManager ly_WeekDayForDate:[NSDate date]]);
    
    
    NSLog(@"%@",[[NSDate date] ly_monthBeginDate]);
    NSLog(@"%@",[[NSDate date] ly_monthEndDate]);
    
    NSLog(@"%@",[[NSDate date] ly_yearBeginDate]);
    NSLog(@"%@",[[NSDate date] ly_yearEndDate]);
    
    NSDate *date = [NSDate ly_dateWithString:@"20180801" formatter:@"yyyyMMdd"];
    
    NSLog(@"%@",[date ly_weakDayBeginDateCrossMonth:NO]);
    NSLog(@"%@",[date ly_weakDayEndDateCrossMonth:NO]);
    
    NSLog(@"%@",[LYSCodeManager ly_matchingPropertyWithDict:@{
                                                               @"name": @"11",
                                                               @"age": @(23),
                                                               @"firends": @[],
                                                               @"girlds": @{}
                                                               }]);
    
    
    
    NSLog(@"加密-------------------------");
    NSLog(@"MD5加密: %@",[LYSEncryptManager ly_MD5Encrypt32LowerWithStr:@"123"]);
    NSLog(@"MD5加密: %@",[LYSEncryptManager ly_MD5Encrypt32UpperWithStr:@"123"]);
    NSLog(@"MD5加密: %@",[LYSEncryptManager ly_MD5Encrypt16UpperWithStr:@"123"]);
    NSLog(@"MD5加密: %@",[LYSEncryptManager ly_MD5Encrypt16LowerWithStr:@"123"]);
    
    NSString *bastStr = [LYSEncryptManager ly_AES_CBC_128_EncryptString:@"1234@qwer" key:@"asiainfo.aiecs" iv:@"1234567890123456"];
    NSLog(@"AES CBC模式加密: %@",bastStr);
    NSLog(@"AES CBC模式解密: %@",[LYSEncryptManager ly_AES_CBC_128_DecryptString:bastStr key:@"asiainfo.aiecs" iv:@"1234567890123456"]);
    
    NSString *bastStr1 = [LYSEncryptManager ly_AES_ECB_128_EncryptString:@"1234@qwer" key:@"asiainfo.aiecs"];
    NSLog(@"AES ECB模式加密: %@",bastStr1);
    NSLog(@"AES ECB模式解密: %@",[LYSEncryptManager ly_AES_ECB_128_DecryptString:bastStr1 key:@"asiainfo.aiecs"]);
    
    NSString *bastStr2 = [LYSEncryptManager ly_DES_CBC_128_EncryptString:@"1234@qwer" key:@"asiainfo.aiecs" iv:@"1234567890123456"];
    NSLog(@"DES CBC模式加密: %@",bastStr2);
    NSLog(@"DES CBC模式解密: %@",[LYSEncryptManager ly_DES_CBC_128_DecryptString:bastStr2 key:@"asiainfo.aiecs" iv:@"1234567890123456"]);
    
    NSString *bastStr3 = [LYSEncryptManager ly_DES_ECB_128_EncryptString:@"1234@qwer" key:@"asiainfo.aiecs"];
    NSLog(@"DES ECB模式加密: %@",bastStr3);
    NSLog(@"DES ECB模式解密: %@",[LYSEncryptManager ly_DES_ECB_128_DecryptString:bastStr3 key:@"asiainfo.aiecs"]);
    
    NSLog(@"sha1 加密: %@", [LYSEncryptManager ly_sha1EncryptString:@"1234@qwer"]);
    
    
    [self.view ly_addTapGetsureWithTarget:<#(id)#> action:<#(SEL)#>]
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self ly_alertTitle:@"提示" message:@"输入框" textfieldPlaceholder:@[@"用户名",@"密码"] actionTitles:@[@"取消",@"确定"] clickWithFieldAction:^(NSInteger index, NSArray<UITextField *> *textFields) {
        NSLog(@"%@",textFields[0].text);
        NSLog(@"%@",textFields[1].text);
    } cancelStr:@"取消" cancelAction:^{
        
    }];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
