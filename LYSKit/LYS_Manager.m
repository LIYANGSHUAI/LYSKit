//
//  LYS_Manager.m
//  LYSKitDemo
//
//  Created by HENAN on 2017/11/9.
//  Copyright © 2017年 HENAN. All rights reserved.
//

#import "LYS_Manager.h"

#import "LYSReachability.h"
#import "sys/utsname.h"

@implementation LYSystemManager

// 返回设备型号信息
+ (LYSTuple)ly_deviceString
{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    NSDictionary *argumentsAry = @{
                                   @"iPhone1,1":@"iPhone 1G",
                                   
                                   @"iPhone1,2":@"iPhone 3G",
                                   
                                   @"iPhone2,1":@"iPhone 3GS",
                                   
                                   @"iPhone3,1":@"iPhone 4",
                                   @"iPhone3,2":@"iPhone 4",
                                   
                                   @"iPhone4,1":@"iPhone 4S",
                                   
                                   @"iPhone5,1":@"iPhone 5",
                                   @"iPhone5,2":@"iPhone 5 (GSM+CDMA)",
                                   @"iPhone5,3":@"iPhone 5c (GSM)",
                                   @"iPhone5,4":@"iPhone 5c (GSM+CDMA)",
                                   
                                   @"iPhone6,1":@"iPhone 5s (GSM)",
                                   @"iPhone6,2":@"iPhone 5s (GSM+CDMA)",
                                   
                                   @"iPhone7,1":@"iPhone 6",
                                   @"iPhone7,2":@"iPhone 6 Plus",
                                   
                                   @"iPhone8,1":@"iPhone 6s",
                                   @"iPhone8,2":@"iPhone 6s Plus",
                                   @"iPhone8,4":@"iPhone SE",
                                   
                                   @"iPhone9,1":@"国行、日版、港行iPhone 7",
                                   @"iPhone9,2":@"港行、国行iPhone 7 Plus",
                                   @"iPhone9,3":@"美版、台版iPhone 7",
                                   @"iPhone9,4":@"美版、台版iPhone 7 Plus",
                                   
                                   @"Phone10,1":@"国行(A1863)、日行(A1906)iPhone 8",
                                   @"Phone10,2":@"国行(A1864)、日行(A1898)iPhone 8 Plus",
                                   @"Phone10,3":@"国行(A1865)、日行(A1902)iPhone X",
                                   @"Phone10,4":@"美版(Global/A1905)iPhone 8",
                                   @"Phone10,5":@"美版(Global/A1897)iPhone 8 Plus",
                                   @"Phone10,6":@"美版(Global/A1901)iPhone X",
                                   
                                   @"iPod1,1":@"iPod Touch 1G",
                                   
                                   @"iPod2,1":@"iPod Touch 2G",
                                   
                                   @"iPod3,1":@"iPod Touch 3G",
                                   
                                   @"iPod4,1":@"iPod Touch 4G",
                                   
                                   @"iPod5,1":@"iPod Touch (5 Gen)",
                                   
                                   @"iPad1,1":@"iPad",
                                   @"iPad1,2":@"iPad 3G",
                                   
                                   @"iPad2,1":@"iPad 2 (WiFi)",
                                   @"iPad2,2":@"iPad 2",
                                   @"iPad2,3":@"iPad 2 (CDMA)",
                                   @"iPad2,4":@"iPad 2",
                                   @"iPad2,5":@"iPad Mini (WiFi)",
                                   @"iPad2,6":@"iPad Mini",
                                   @"iPad2,7":@"iPad Mini (GSM+CDMA)",
                                   
                                   @"iPad3,1":@"iPad 3 (WiFi)",
                                   @"iPad3,2":@"iPad 3 (GSM+CDMA)",
                                   @"iPad3,3":@"iPad 3",
                                   @"iPad3,4":@"iPad 4 (WiFi)",
                                   @"iPad3,5":@"iPad 4",
                                   @"iPad3,6":@"iPad 4 (GSM+CDMA)",
                                   
                                   @"iPad4,1":@"iPad Air (WiFi)",
                                   @"iPad4,2":@"iPad Air (Cellular)",
                                   @"iPad4,4":@"iPad Mini 2 (WiFi)",
                                   @"iPad4,5":@"iPad Mini 2 (Cellular)",
                                   @"iPad4,6":@"iPad Mini 2",
                                   @"iPad4,7":@"iPad Mini 3",
                                   @"iPad4,8":@"iPad Mini 3",
                                   @"iPad4,9":@"iPad Mini 3",
                                   
                                   @"iPad5,1":@"iPad Mini 4 (WiFi)",
                                   @"iPad5,2":@"iPad Mini 4 (LTE)",
                                   @"iPad5,3":@"iPad Air 2",
                                   @"iPad5,4":@"iPad Air 2",
                                   
                                   @"iPad6,3":@"iPad Pro 9.7",
                                   @"iPad6,4":@"iPad Pro 9.7",
                                   @"iPad6,7":@"iPad Pro 12.9",
                                   @"iPad6,8":@"iPad Pro 12.9",
                                   @"iPad6,11":@"iPad 5 (WiFi)",
                                   @"iPad6,12":@"iPad 5 (Cellular)",
                                   
                                   @"iPad7,1": @"iPad Pro 12.9 inch 2nd gen (WiFi)",
                                   @"iPad7,2": @"iPad Pro 12.9 inch 2nd gen (Cellular)",
                                   @"iPad7,3": @"iPad Pro 10.5 inch (WiFi)",
                                   @"iPad7,4": @"iPad Pro 10.5 inch (Cellular)",
                                   
                                   @"AppleTV2,1":@"Apple TV 2",
                                   @"AppleTV3,1":@"Apple TV 3",
                                   @"AppleTV3,2":@"Apple TV 3",
                                   @"AppleTV5,3":@"Apple TV 4",
                                   
                                   @"i386":@"Simulator",
                                   @"x86_64":@"Simulator",
                                   };
    
    return [LYSTupleManager ly_create:[[argumentsAry allKeys] containsObject:platform] ? argumentsAry[platform] : @"未知" two:platform];
}

@end

@interface LYSReachabilityManager ()

@property (nonatomic,strong)NSMutableArray *reachabilityAry;

@end

@implementation LYSReachabilityManager

- (NSMutableArray *)reachabilityAry
{
    if (!_reachabilityAry)
    {
        _reachabilityAry = [NSMutableArray array];
    }
    return _reachabilityAry;
}

+ (instancetype)shareInstance
{
    static LYSReachabilityManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[LYSReachabilityManager alloc] init];
    });
    return manager;
}

+ (void)ly_notifitionReachability:(MonitorNetworkChangeAction)action
                     reachability:(LYSReachability *)reachability
                         promptly:(BOOL)promptly
{
    if (promptly == YES) {if (action) {action(reachability);}}
    [[[self shareInstance] reachabilityAry] addObject:reachability];
    [reachability startNotifier];
    reachability.notifitionCallBack = ^(LYSReachability *reachability) {
        if (action) {action(reachability);}
    };
}

+ (void)ly_stopNotifitionReachability:(LYSReachability *)reachability
{
    [reachability stopNotifier];
    [[[self shareInstance] reachabilityAry] removeObject:reachability];
}

@end

#import <CoreLocation/CoreLocation.h>

@interface LYSLocationManager ()<CLLocationManagerDelegate>

@property (nonatomic,strong)CLLocationManager *locationManager;

@property (nonatomic,strong)CLGeocoder *geocoderManager;

@property (nonatomic,copy)void(^success)(CLLocation *location);

@property (nonatomic,copy)void(^fail)(NSString *state);

@property (nonatomic,assign)BOOL isSuccess;

@end

@implementation LYSLocationManager
// 单例创建
+ (instancetype)shareInstance{
    static LYSLocationManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[LYSLocationManager alloc] init];
    });
    return manager;
}
- (CLLocationManager *)locationManager{
    if (!_locationManager) {
        self.locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
    }
    return _locationManager;
}
- (CLGeocoder *)geocoderManager{
    if (!_geocoderManager) {
        self.geocoderManager = [[CLGeocoder alloc] init];
    }
    return _geocoderManager;
}
// 监测定位
+ (void)ly_location:(void(^)(CLLocation *location))success fail:(void(^)(NSString *state))fail{
    LYSLocationManager *manager = [self shareInstance];
    CLLocationManager *lCManager = manager.locationManager;
    manager.isSuccess = NO;
    if ([CLLocationManager locationServicesEnabled]) {
        if (success) {
            manager.success = success;
        }
        if (fail) {
            manager.fail = fail;
        }
        [lCManager startUpdatingLocation];
        [lCManager requestWhenInUseAuthorization];
        lCManager.distanceFilter=kCLDistanceFilterNone;
        //设置定位的精准度，一般精准度越高，越耗电（这里设置为精准度最高的，适用于导航应用）
        lCManager.desiredAccuracy=kCLLocationAccuracyBestForNavigation;
    }else {
        if (fail) {
            fail(@"用户没有打开定位或者网络不好");
        }
    }
}
#pragma mark - CLLocationManagerDelegate -
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    if (!self.isSuccess) {
        [manager stopUpdatingLocation];
        CLLocation *loc = [locations firstObject];
        if (self.success) {
            self.success(loc);
            self.isSuccess = YES;
        }
    }
}
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    if (self.fail) {
        self.fail(error.localizedDescription);
    }
}
#pragma mark - 地理反编码 -
+ (void)ly_geocoder:(CLLocation *)location success:(void(^)(CLPlacemark *placemark))success{
    LYSLocationManager *manager = [self shareInstance];
    [manager.geocoderManager reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (success) {
            success([placemarks firstObject]);
        }
    }];
}
@end
@implementation LYSAPPDelegateManager
#pragma mark - 设置window的跟视图控制器 -
+ (void)ly_createWindowAndSetRootViewController:(UIViewController *)rootViewController
{
    if ([UIApplication sharedApplication].delegate == nil) {return;}
    [[UIApplication sharedApplication].delegate setWindow:[[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds]];
    [[[UIApplication sharedApplication].delegate window] setRootViewController:rootViewController];
    [[[UIApplication sharedApplication].delegate window] makeKeyAndVisible];
}
#pragma mark - 根据参数ispermit返回的BOOL值,来判断显示哪一个视图 -
+ (void)ly_if:(BOOL(^)(void))ispermit showViewController:(UIViewController *)firstViewController elseShowViewController:(UIViewController *)secoundViewController
{
    if (ispermit())
    {
        [self ly_createWindowAndSetRootViewController:firstViewController];
    }else
    {
        [self ly_createWindowAndSetRootViewController:secoundViewController];
    }
}
#pragma mark - 设置视图控制器 -
+ (void)ly_setWindowRootViewController:(UIViewController *)rootViewController
{
    if ([UIApplication sharedApplication].delegate == nil) {return;}
    [[[UIApplication sharedApplication].delegate window] setRootViewController:rootViewController];
}
#pragma mark - 设置启动动画 -
+ (void)ly_createWindowAndloadStartInterface:(UIViewController *)startInterface mainInterface:(UIViewController *)mainInterface delay:(NSTimeInterval)interval durtion:(NSTimeInterval)durtion
{
    [self ly_createWindowAndSetRootViewController:startInterface];
    if ([UIApplication sharedApplication].delegate == nil) {return;}
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(interval * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[[UIApplication sharedApplication].delegate window] setRootViewController:mainInterface];
        [[[UIApplication sharedApplication].delegate window] addSubview:startInterface.view];
        [UIView animateWithDuration:durtion animations:^{
            startInterface.view.layer.opacity = 0;
        } completion:^(BOOL finished) {
            [startInterface.view removeFromSuperview];
        }];
    });
}
#pragma mark - 模仿导航进入下一级页面 -
+ (void)pushFrom:(UIViewController *)fromVC toViewController:(UIViewController *)toVC completion:(void(^)(void))completion
{
    UIView *lastView = fromVC.view;
    [self ly_setWindowRootViewController:toVC];
    [[UIApplication sharedApplication].keyWindow insertSubview:lastView atIndex:0];
    toVC.view.frame = CGRectMake([UIScreen mainScreen].bounds.size.width, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    [UIView animateWithDuration:0.5 animations:^{
        lastView.frame = CGRectMake(-[UIScreen mainScreen].bounds.size.width, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        toVC.view.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    } completion:^(BOOL finished) {
        [lastView removeFromSuperview];
        if (completion) {completion();}
    }];
}
#pragma mark - 模仿导航退回上一级页面 -
+ (void)popFrom:(UIViewController *)fromVC toViewController:(UIViewController *)toVC completion:(void(^)(void))completion
{
    UIView *lastView = fromVC.view;
    [self ly_setWindowRootViewController:toVC];
    [[UIApplication sharedApplication].keyWindow insertSubview:lastView atIndex:0];
    toVC.view.frame = CGRectMake(-[UIScreen mainScreen].bounds.size.width, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    [UIView animateWithDuration:0.5 animations:^{
        lastView.frame = CGRectMake([UIScreen mainScreen].bounds.size.width, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        toVC.view.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    } completion:^(BOOL finished) {
        [lastView removeFromSuperview];
        if (completion) {completion();}
    }];
}
@end
// 创建一个给点时间的日期结构体
LYDate ly_CreateDate(NSInteger y,NSInteger m,NSInteger d,NSInteger h,NSInteger f,NSInteger s){
    LYDate lyDate;
    lyDate.y = y;
    lyDate.m = m;
    lyDate.d = d;
    lyDate.h = h;
    lyDate.f = f;
    lyDate.s = s;
    return lyDate;
}
// 判断两个日期是否是同一天
bool ly_IsEqual(LYDate date1,LYDate date2){
    bool result = false;
    if (date1.y == date2.y && date1.m == date2.m && date1.d == date2.d && date1.h == date2.h && date1.f == date2.f && date1.s == date2.s) {
        result = true;
    }
    return result;
}
// 判断是否是同一年
bool ly_SameYear(LYDate date1,LYDate date2){
    bool result = false;
    if (date1.y == date2.y) {
        result = true;
    }
    return result;
}
// 判断是否是同一月
bool ly_SameMonth(LYDate date1,LYDate date2){
    bool result = false;
    if (ly_SameYear(date1, date2) && date1.m == date2.m) {
        result = true;
    }
    return result;
}
// 判断是否是同一天
bool ly_SameDay(LYDate date1,LYDate date2){
    bool result = false;
    if (ly_SameMonth(date1, date2) && date1.d == date2.d) {
        result = true;
    }
    return result;
}
// 比较两个日期返回(1, 0, -1)对应(date1比date2晚,date1和date2一样,date1比date2晚)
NSInteger ly_CompareDate(LYDate date1,LYDate date2){
    NSInteger index = 0;
    if (ly_SameDay(date1, date2)) {
        index = 0;
    }else {
        if (date1.y > date2.y) {
            index = 1;
        }else if (date1.y < date2.y){
            index = -1;
        }else {
            if (date1.m > date2.m) {
                index = 1;
            }else if (date1.m < date2.m){
                index = -1;
            }else {
                if (date1.d > date2.d) {
                    index = 1;
                }else if (date1.d < date2.d){
                    index = -1;
                }
            }
        }
    }
    return index;
}
@implementation LYSDateManager
// 获取今天的LYDate格式
+ (LYDate)ly_Today{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    LYDate LYdate;
    NSDate *date = [NSDate date];
    [formatter setDateFormat:@"YYYY"];
    LYdate.y = [[formatter stringFromDate:date] integerValue];
    [formatter setDateFormat:@"MM"];
    LYdate.m = [[formatter stringFromDate:date] integerValue];
    [formatter setDateFormat:@"dd"];
    LYdate.d = [[formatter stringFromDate:date] integerValue];
    [formatter setDateFormat:@"HH"];
    LYdate.h = [[formatter stringFromDate:date] integerValue];
    [formatter setDateFormat:@"mm"];
    LYdate.f = [[formatter stringFromDate:date] integerValue];
    [formatter setDateFormat:@"ss"];
    LYdate.s = [[formatter stringFromDate:date] integerValue];
    return LYdate;
}
// 将某一日期转换为LYDate格式
+ (LYDate)ly_LYDateFromDate:(NSDate *)date{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    LYDate LYdate;
    [formatter setDateFormat:@"YYYY"];
    LYdate.y = [[formatter stringFromDate:date] integerValue];
    [formatter setDateFormat:@"MM"];
    LYdate.m = [[formatter stringFromDate:date] integerValue];
    [formatter setDateFormat:@"dd"];
    LYdate.d = [[formatter stringFromDate:date] integerValue];
    [formatter setDateFormat:@"HH"];
    LYdate.h = [[formatter stringFromDate:date] integerValue];
    [formatter setDateFormat:@"mm"];
    LYdate.f = [[formatter stringFromDate:date] integerValue];
    [formatter setDateFormat:@"ss"];
    LYdate.s = [[formatter stringFromDate:date] integerValue];
    return LYdate;
}
// 获取给定日期是星期几
+ (NSInteger)ly_WeekDayForDate:(NSDate *)date{
    NSInteger index = 0;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    [calendar setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:8]];
    [calendar setLocale:[NSLocale currentLocale]];
    switch ([calendar component:(NSCalendarUnitWeekday) fromDate:date]) {
        case 1:
            index = 7;
            break;
        case 2:
            index = 1;
            break;
        case 3:
            index = 2;
            break;
        case 4:
            index = 3;
            break;
        case 5:
            index = 4;
            break;
        case 6:
            index = 5;
            break;
        case 7:
            index = 6;
            break;
        default:
            break;
    }
    return index;
}
// 获取这个月有多少天
+ (NSInteger)ly_DayNumForDate:(NSDate *)date{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    [calendar setLocale:[NSLocale currentLocale]];
    [calendar setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:8]];
    NSRange range = [calendar rangeOfUnit:(NSCalendarUnitDay) inUnit:(NSCalendarUnitMonth) forDate:date];
    return range.length;
}
// 获取这个月的第一天星期几
+ (NSInteger)ly_WeekDayForFirstDate:(NSDate *)date{
    LYDate lydate = [self ly_LYDateFromDate:date];
    lydate.d = 1;
    NSDate *firstDate = [self ly_DateFromLYDate:lydate];
    return [self ly_WeekDayForDate:firstDate];
}
// 获取给定日期是几号
+ (NSInteger)ly_DayForDate:(NSDate *)date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd"];
    return [[dateFormatter stringFromDate:date] integerValue];
}
// 获取今天是几号
+ (NSInteger)ly_DayForToday{
    return [self ly_DayForDate:[NSDate date]];
}
// 将LYDate转为NSDate
+ (NSDate *)ly_DateFromLYDate:(LYDate)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:8]];
    NSString *dateStr = [NSString stringWithFormat:@"%ld-%@-%@ %@:%@:%@",(long)date.y,[self compareNum:date.m],[self compareNum:date.d],[self compareNum:date.h],[self compareNum:date.f],[self compareNum:date.s]];
    return [dateFormatter dateFromString:dateStr];
}
// 判断数字是否大于10,如果大于,前面加0
+ (NSString *)compareNum:(NSInteger)num{
    if (num < 10) {
        return [NSString stringWithFormat:@"0%ld",(long)num];
    }else {
        return [NSString stringWithFormat:@"%ld",(long)num];
    }
}
@end


