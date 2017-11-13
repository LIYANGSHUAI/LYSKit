//
//  LYS_Manager.h
//  LYSKitDemo
//
//  Created by HENAN on 2017/11/9.
//  Copyright © 2017年 HENAN. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LYS_BaseObj.h"

@interface LYSystemManager : NSObject

/**
 获取设备型号信息
 
 @return 返回型号
 */
+ (LYSTuple)ly_deviceString;

@end

@class LYSReachability;

typedef void(^MonitorNetworkChangeAction)(LYSReachability *reachability);

@interface LYSReachabilityManager : NSObject

/**
 注册网络监听

 @param action 监听回调事件
 @param reachability 网络监听对象
 @param promptly promptly 的作用主要是用来决定是否立即获取一下当前网络状态
 */
+ (void)ly_notifitionReachability:(MonitorNetworkChangeAction)action
                     reachability:(LYSReachability *)reachability
                         promptly:(BOOL)promptly;

/**
 移除网络监听
 
 @param reachability 网络监听对象
 */
+ (void)ly_stopNotifitionReachability:(LYSReachability *)reachability;

@end

@class CLLocation;

@class CLPlacemark;

@interface LYSLocationManager : NSObject
/**
 获取位置信息(如果此方法调用多次,那么下次的回调函数会覆盖上次的回调,前提时此时还没有定位成功)
 
 @param success 成功定位回调
 @param fail 失败定位回调
 */
+ (void)ly_location:(void(^)(CLLocation *location))success
               fail:(void(^)(NSString *state))fail;

/**
 对定位信息进行反编码
 
 @param location 定位信息
 @param success 反编码成功回调
 */
+ (void)ly_geocoder:(CLLocation *)location
            success:(void(^)(CLPlacemark *placemark))success;
@end

@interface LYSAPPDelegateManager : NSObject

/**
 设置window的跟视图控制器
 
 @param rootViewController 要设置的跟视图控制器
 */
+ (void)ly_createWindowAndSetRootViewController:(UIViewController *)rootViewController;

/**
 根据返回条件分别显示不同的视图控制器
 
 @param ispermit 判断条件
 @param firstViewController 如果判断条件:YES,显示这个控制器
 @param secoundViewController 如果判断条件:NO,显示这个控制器
 */
+ (void)ly_if:(BOOL(^)(void))ispermit showViewController:(UIViewController *)firstViewController elseShowViewController:(UIViewController *)secoundViewController;

/**
 设置window的跟视图控制器
 
 @param rootViewController 根视图控制器
 */
+ (void)ly_setWindowRootViewController:(UIViewController *)rootViewController;

/**
 设置启动动画
 
 @param startInterface 启动界面
 @param mainInterface 应用主界面
 @param interval 启动动画的显示时间
 @param durtion 动画消失的动画时间
 */
+ (void)ly_createWindowAndloadStartInterface:(UIViewController *)startInterface mainInterface:(UIViewController *)mainInterface delay:(NSTimeInterval)interval durtion:(NSTimeInterval)durtion;

/**
 模仿导航进入下一级页面
 
 @param fromVC 上一级页面
 @param toVC 下一级页面
 @param completion 完成回调
 */
+ (void)pushFrom:(UIViewController *)fromVC toViewController:(UIViewController *)toVC completion:(void(^)(void))completion;

/**
 模仿导航退回上一级页面
 
 @param fromVC 下一级页面
 @param toVC 上一级页面
 @param completion 完成回调
 */
+ (void)popFrom:(UIViewController *)fromVC toViewController:(UIViewController *)toVC completion:(void(^)(void))completion;
@end

/**
 定义一个结构体,用来存储一个特定日期的年月日时分秒
 */
typedef struct {
    NSInteger y;
    NSInteger m;
    NSInteger d;
    NSInteger h;
    NSInteger f;
    NSInteger s;
}LYDate;

/**
 创建一个时间的日期结构体
 
 @param y 年
 @param m 月
 @param d 日
 @param h 时
 @param f 分
 @param s 秒
 @return 返回LYDate
 */
LYDate ly_CreateDate(NSInteger y,
                     NSInteger m,
                     NSInteger d,
                     NSInteger h,
                     NSInteger f,
                     NSInteger s);

/**
 判断两个日期是否是同一天的同一时刻
 
 @param date1 日期一
 @param date2 日期二
 @return 比较结果
 */
bool ly_IsEqual(LYDate date1,LYDate date2);

/**
 判断是否是同一年
 
 @param date1 日期一
 @param date2 日期二
 @return 比较结果
 */
bool ly_SameYear(LYDate date1,LYDate date2);

/**
 判断是否是同一月
 
 @param date1 日期一
 @param date2 日期二
 @return 比较结果
 */
bool ly_SameMonth(LYDate date1,LYDate date2);

/**
 判断是否是同一天
 
 @param date1 日期一
 @param date2 日期二
 @return 比较结果
 */
bool ly_SameDay(LYDate date1,LYDate date2);

/**
 比较两个日期返回(1, 0, -1)对应(date1比date2晚,date1和date2一样,date1比date2晚),最小比较到日,如果具体到时分秒,则不能区分
 
 @param date1 日期一
 @param date2 日期二
 @return 比较结果
 */
NSInteger ly_CompareDate(LYDate date1,LYDate date2);

@interface LYSDateManager : NSObject
/**
 获取今天的LYDate格式
 
 @return 返回LYDate类型
 */
+ (LYDate)ly_Today;

/**
 将某一日期转换为LYDate格式
 
 @param date 转换日期
 @return 返回LYDate类型
 */
+ (LYDate)ly_LYDateFromDate:(NSDate *)date;

/**
 获取给定日期是星期几
 
 @param date 传入日期
 @return 返回星期几
 */
+ (NSInteger)ly_WeekDayForDate:(NSDate *)date;

/**
 获取这个月有多少天
 
 @param date 传入日期
 @return 返回这个月有多少天
 */
+ (NSInteger)ly_DayNumForDate:(NSDate *)date;

/**
 获取这个月的第一天星期几
 
 @param date 传入日期
 @return 返回这个月的第一天星期几
 */
+ (NSInteger)ly_WeekDayForFirstDate:(NSDate *)date;

/**
 获取给定日期是几号
 
 @param date 传入日期
 @return 返回给定日期是星期几
 */
+ (NSInteger)ly_DayForDate:(NSDate *)date;

/**
 获取今天是几号
 
 @return 返回今天是几号
 */
+ (NSInteger)ly_DayForToday;

/**
 将LYDate转为NSDate
 
 @param date 传入日期
 @return 返回NSDate类型
 */
+ (NSDate *)ly_DateFromLYDate:(LYDate)date;
@end
