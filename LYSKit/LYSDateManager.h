//
//  LYSDateManager.h
//  LYSKitDemo
//
//  Created by HENAN on 2018/4/20.
//  Copyright © 2018年 liyangshuai. All rights reserved.
//

#import <Foundation/Foundation.h>
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
 
 @param y                                   年
 @param m                                   月
 @param d                                   日
 @param h                                   时
 @param f                                   分
 @param s                                   秒
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
 
 @param date1                           日期一
 @param date2                           日期二
 @return                                比较结果
 */
bool ly_IsEqual(LYDate date1,LYDate date2);

/**
 判断是否是同一年
 
 @param date1                           日期一
 @param date2                           日期二
 @return                                比较结果
 */
bool ly_SameYear(LYDate date1,LYDate date2);

/**
 判断是否是同一月
 
 @param date1                           日期一
 @param date2                           日期二
 @return                                比较结果
 */
bool ly_SameMonth(LYDate date1,LYDate date2);

/**
 判断是否是同一天
 
 @param date1                           日期一
 @param date2                           日期二
 @return                                比较结果
 */
bool ly_SameDay(LYDate date1,LYDate date2);

/**
 比较两个日期返回(1, 0, -1)对应(date1比date2晚,date1和date2一样,date1比date2晚),最小比较到日,如果具体到时分秒,则不能区分
 
 @param date1                           日期一
 @param date2                           日期二
 @return                                比较结果
 */
NSInteger ly_CompareDate(LYDate date1,LYDate date2);


@interface LYSDateManager : NSObject

/**
 获取今天的LYDate格式
 
 @return                                返回LYDate类型
 */
+ (LYDate)ly_Today;

/**
 将某一日期转换为LYDate格式
 
 @param date                            转换日期
 @return                                返回LYDate类型
 */
+ (LYDate)ly_LYDateFromDate:(NSDate *)date;

/**
 获取给定日期是星期几
 
 @param date                            传入日期
 @return                                返回星期几
 */
+ (NSInteger)ly_WeekDayForDate:(NSDate *)date;

/**
 获取这个月有多少天
 
 @param date                            传入日期
 @return                                返回这个月有多少天
 */
+ (NSInteger)ly_DayNumForDate:(NSDate *)date;

/**
 获取这个月的第一天星期几
 
 @param date                            传入日期
 @return                                返回这个月的第一天星期几
 */
+ (NSInteger)ly_WeekDayForFirstDate:(NSDate *)date;

/**
 获取给定日期是几号
 
 @param date                            传入日期
 @return                                返回给定日期是星期几
 */
+ (NSInteger)ly_DayForDate:(NSDate *)date;

/**
 获取今天是几号
 
 @return                                返回今天是几号
 */
+ (NSInteger)ly_DayForToday;

/**
 将LYDate转为NSDate
 
 @param date                            传入日期
 @return                                返回NSDate类型
 */
+ (NSDate *)ly_DateFromLYDate:(LYDate)date;

@end
