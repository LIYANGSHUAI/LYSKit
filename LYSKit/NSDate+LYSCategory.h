//
//  NSDate+LYSCategory.h
//  LYSKitDemo
//
//  Created by HENAN on 2018/4/20.
//  Copyright © 2018年 liyangshuai. All rights reserved.
//

#import <Foundation/Foundation.h>

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

// 获取当前日期对象
#define LYSCurrentDate [NSDate date]

typedef NSString * lyDateFormatterOption;

// yyyy-MM-dd HH:mm:ss
extern NSString *const lyDateFormatterOptionStandardDateFormatBar;
// yyyy/MM/dd HH:mm:ss
extern NSString *const lyDateFormatterOptionStandardDateFormatSlash;
// yyyy-MM-dd
extern NSString *const lyDateFormatterOptionGregorianCalendarBar;
// yyyy/MM/dd
extern NSString *const lyDateFormatterOptionGregorianCalendarSlash;
// HH:mm:ss
extern NSString *const lyDateFormatterOptionTime;

@interface NSDate (LYSCategory)

/**
 将传入的日期转换成对应格式的字符串,(框架默认提供了lyDateFormatterOption选项可供选择)
 
 @param date                                待转换的日期
 @param formatStr                           需要转换成的格式
 @return                                    最终转换后的字符串
 */
+ (NSString *)ly_stringWithDate:(NSDate *)date formatter:(lyDateFormatterOption)formatStr;

/**
 类方法,将当前日期转换成对应格式的字符串,(框架默认提供了lyDateFormatterOption选项可供选择)
 
 @param formatStr                           需要转换成的格式
 @return                                    最终转换后的字符串
 */
+ (NSString *)ly_stringWithCurrentDateFormatter:(lyDateFormatterOption)formatStr;

/**
 实例方法,将当前日期转换成对应格式的字符串,(框架默认提供了lyDateFormatterOption选项可供选择)
 
 @param formatStr                           需要转换成的格式
 @return                                    最终转换后的字符串
 */
- (NSString *)ly_stringWithFormatter:(lyDateFormatterOption)formatStr;

/**
 将传入固定格式的日期字符串转成对应的NSDate对象,(此时,要保证日期字符串格式和传入对应的格式一致,同时框架默认提供了lyDateFormatterOption选项可供选择))
 
 @param dateStr                             时间字符串形式
 @param formatStr                           时间格式
 @return                                    返回对应的时间对象
 */
+ (NSDate *)ly_dateWithString:(NSString *)dateStr formatter:(lyDateFormatterOption)formatStr;

/**
 将传入的NSDate对象和当前时间的NSDate比较,获取比较结果,(例如:刚刚,几分钟前,几小时前,几天前...)
 
 @param compareDate                         和当前时间做比较的时间
 @return                                    返回比较的结果
 */
+ (NSString *)ly_compareCurrentTime:(NSDate *)compareDate;

/**
 获取间隔给定时间戳的NSDate对象,(如果需要几消失或者几天的时间戳,例如: 2 * 60 * 3600...),默认是可以加单位的,如果单位为负,则返回距离当前时间之前的NSDate对象
 
 @param timeInterval                        间隔秒数
 @return                                    返回预订的日期
 */
+ (NSDate *)ly_dateSincleNow:(NSTimeInterval)timeInterval;

/**
 获取明天的这个时间点的NSDate,对 ly_dateSincleNow方法的扩展
 
 @return                                    返回预订的日期
 */
+ (NSDate *)ly_dateTomorrow;

/**
 获取昨天的这个时间点的NSDate,对 ly_dateSincleNow方法的扩展
 
 @return                                    返回预订的日期
 */
+ (NSDate *)ly_dateYesterday;

@end
