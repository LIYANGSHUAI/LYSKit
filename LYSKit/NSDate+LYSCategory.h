//
//  NSDate+LYSCategory.h
//  LYSKitDemo
//
//  Created by HENAN on 2017/11/9.
//  Copyright © 2017年 HENAN. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (LYSCategory)
/*
 *  YYYY:        年
 *  M/MM:   1~12 月
 *  MMM:    Jan/Feb/Mar/Apr/May/Jun/Jul/Aug/Sep/Oct/Nov/Dec月
 *  MMMM:   January/February/March/April/May/June/July/August/September/October/November/December月
 *
 *  d:      1~31 日
 *  H:      1~24 时 (24小时制)
 *  h:      1~12 时 (12小时制)
 *  m:      0~59 分
 *  s:      0~59 秒
 */

/**
 类方法,获取给定日期字符串显示
 
 @param date 需要转换的日期
 @param formatStr 转换的格式
 @return 时间的字符串形式
 */
+ (NSString *)ly_stringWithDate:(NSDate *)date
                      formatter:(NSString *)formatStr;

/**
 类方法,获取当前日期字符串显示
 
 @param formatStr 转换的格式
 @return 时间的字符串形式
 */
+ (NSString *)ly_stringWithCurrentDateFormatter:(NSString *)formatStr;

/**
 实例方法,获取当前日期字符串显示
 
 @param formatStr 转换的格式
 @return 时间的字符串形式
 */
- (NSString *)ly_stringWithFormatter:(NSString *)formatStr;

/**
 字符串转日期
 
 @param dateStr 时间字符串形式
 @param formatStr 时间格式
 @return 返回对应的时间对象
 */
+ (NSDate *)ly_dateWithStr:(NSString *)dateStr
                 formatter:(NSString *)formatStr;

/**
 指定时间和当前时间比较
 
 @param compareDate 和当前时间做比较的时间
 @return 返回比较的结果
 */
+ (NSString *)compareCurrentTime:(NSDate*)compareDate;

/**
 获取n个24小时之后的NSDate
 
 @param num 小时的个数
 @return 返回预订的日期
 */
+ (NSDate *)ly_dateSincleNow:(NSInteger)num;

/**
 获取明天的这个时间点的NSDate
 
 @return 返回预订的日期
 */
+ (NSDate *)ly_dateTomorrow;

/**
 获取昨天的这个时间点的NSDate
 
 @return 返回预订的日期
 */
+ (NSDate *)ly_dateYesterday;
@end
