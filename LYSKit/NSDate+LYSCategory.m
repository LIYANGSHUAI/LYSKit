//
//  NSDate+LYSCategory.m
//  LYSKitDemo
//
//  Created by HENAN on 2018/4/20.
//  Copyright © 2018年 liyangshuai. All rights reserved.
//

#import "NSDate+LYSCategory.h"

NSString *const lyDateFormatterOptionStandardDateFormatBar = @"yyyy-MM-dd HH:mm:ss";
NSString *const lyDateFormatterOptionStandardDateFormatSlash = @"yyyy/MM/dd HH:mm:ss";
NSString *const lyDateFormatterOptionGregorianCalendarBar = @"yyyy-MM-dd";
NSString *const lyDateFormatterOptionGregorianCalendarSlash = @"yyyy/MM/dd";
NSString *const lyDateFormatterOptionTime = @"HH:mm:ss";

#define FORMATTER(A) \
({\
NSDateFormatter *formatter = [[NSDateFormatter alloc] init];\
formatter.dateFormat = A;\
formatter;\
})

#define FORMAT(...) [NSString stringWithFormat:__VA_ARGS__]

#define ISKINDOFCLASS(A,B) [A isKindOfClass:NSClassFromString(B)]

@implementation NSDate (LYSCategory)

+ (NSString *)ly_stringWithDate:(NSDate *)date formatter:(lyDateFormatterOption)formatStr
{
    return [FORMATTER(formatStr) stringFromDate:date];
}

+ (NSString *)ly_stringWithCurrentDateFormatter:(lyDateFormatterOption)formatStr
{
    return [FORMATTER(formatStr) stringFromDate:[NSDate date]];
}

- (NSString *)ly_stringWithFormatter:(lyDateFormatterOption)formatStr
{
    return [FORMATTER(formatStr) stringFromDate:self];
}

+ (NSDate *)ly_dateWithString:(NSString *)dateStr formatter:(lyDateFormatterOption)formatStr
{
    return [FORMATTER(formatStr) dateFromString:dateStr];
}

+ (NSString *)ly_compareCurrentTime:(NSDate *)compareDate
{
    NSTimeInterval timeInterval = -[compareDate timeIntervalSinceNow];
    double time = round(timeInterval);
    long temp = 0;
    NSString *result = nil;
    if (time >= 0) {
        if ((temp = time) < 60)
        {
            result = @"刚刚";
        } else
        if((temp = temp / 60) <60)
        {
            result = FORMAT(@"%ld分前",[@(temp) longValue]);
        } else
        if((temp = temp / 60) <24)
        {
            result = FORMAT(@"%ld小时前",[@(temp) longValue]);
        } else
        if((temp = temp / 24) <30)
        {
            result = FORMAT(@"%ld天前",[@(temp) longValue]);
        } else
        if((temp = temp / 30) <12)
        {
            result = FORMAT(@"%ld个月前",[@(temp) longValue]);
        } else
        {
            result = FORMAT(@"%ld年前",[@(temp / 12) longValue]);
        }
    } else {
        time = -time;
        if ((temp = time) < 60)
        {
            result = FORMAT(@"%ld秒后",[@(temp) longValue]);
        } else
        if((temp = temp / 60) <60)
        {
            result = FORMAT(@"%ld分后",[@(temp) longValue]);
        } else
        if((temp = temp / 60) <24)
        {
            result = FORMAT(@"%ld小时后",[@(temp) longValue]);
        } else
        if((temp = temp / 24) <30)
        {
            result = FORMAT(@"%ld天后",[@(temp) longValue]);
        } else
        if((temp = temp / 30) <12)
        {
            result = FORMAT(@"%ld个月后",[@(temp) longValue]);
        } else
        {
            result = FORMAT(@"%ld年后",[@(temp / 12) longValue]);
        }
    }
    return  result;
}

+ (NSDate *)ly_dateSincleNow:(NSTimeInterval)timeInterval
{
    return [NSDate dateWithTimeIntervalSinceNow:timeInterval];
}

+ (NSDate *)ly_dateTomorrow
{
    return [self ly_dateSincleNow:24 * 3600];
}

+ (NSDate *)ly_dateYesterday
{
    return [self ly_dateSincleNow:-24 * 3600];
}
- (NSDate *)ly_monthBeginDate
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday |
    NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    // 话说在真机上需要设置区域，才能正确获取本地日期，天朝代码:zh_CN
    calendar.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    NSDateComponents *comps = [calendar components:unitFlags fromDate:self];
    [comps setDay:1];
    [comps setHour:0];
    [comps setMinute:0];
    [comps setSecond:0];
    return [calendar dateFromComponents:comps];
}
- (NSDate *)ly_monthEndDate
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday |
    NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    // 话说在真机上需要设置区域，才能正确获取本地日期，天朝代码:zh_CN
    calendar.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    NSDateComponents *comps = [calendar components:unitFlags fromDate:self];
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:self];
    [comps setDay:range.length];
    [comps setHour:23];
    [comps setMinute:59];
    [comps setSecond:59];
    return [calendar dateFromComponents:comps];
}
- (NSDate *)ly_yearBeginDate
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday |
    NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    // 话说在真机上需要设置区域，才能正确获取本地日期，天朝代码:zh_CN
    calendar.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    NSDateComponents *comps = [calendar components:unitFlags fromDate:self];
    [comps setMonth:1];
    [comps setDay:1];
    [comps setHour:0];
    [comps setMinute:0];
    [comps setSecond:0];
    return [calendar dateFromComponents:comps];
}
- (NSDate *)ly_yearEndDate
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday |
    NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    // 话说在真机上需要设置区域，才能正确获取本地日期，天朝代码:zh_CN
    calendar.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    NSDateComponents *comps = [calendar components:unitFlags fromDate:self];
    [comps setMonth:12];
    [comps setDay:1];
    [comps setHour:0];
    [comps setMinute:0];
    [comps setSecond:0];
    NSDate *date = [calendar dateFromComponents:comps];
    return [date ly_monthEndDate];
}
- (NSDate *)ly_dayBeginDate
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday |
    NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    // 话说在真机上需要设置区域，才能正确获取本地日期，天朝代码:zh_CN
    calendar.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    NSDateComponents *comps = [calendar components:unitFlags fromDate:self];
    [comps setHour:0];
    [comps setMinute:0];
    [comps setSecond:0];
    return [calendar dateFromComponents:comps];
}
- (NSDate *)ly_dayEndDate
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday |
    NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    // 话说在真机上需要设置区域，才能正确获取本地日期，天朝代码:zh_CN
    calendar.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    NSDateComponents *comps = [calendar components:unitFlags fromDate:self];
    [comps setHour:23];
    [comps setMinute:59];
    [comps setSecond:59];
    return [calendar dateFromComponents:comps];
}
- (NSDate *)ly_weakDayBeginDateCrossMonth:(BOOL)crossMonth
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    // 话说在真机上需要设置区域，才能正确获取本地日期，天朝代码:zh_CN
    calendar.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    NSInteger weakDay = [calendar component:(NSCalendarUnitWeekday) fromDate:self];
    NSInteger index = 0;
    switch (weakDay) {
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
    NSInteger day = [calendar component:(NSCalendarUnitDay) fromDate:self];
    if (day < index) {
        if (crossMonth) {
            return [[self ly_dayBeginDate] dateByAddingTimeInterval:-24*3600*(index-1)];
        } else {
            return [self ly_monthBeginDate];
        }
    }
    else if (day == index)
    {
        return [self ly_monthBeginDate];
    }
    else {
        return [[self ly_dayBeginDate] dateByAddingTimeInterval:-24*3600*(index-1)];
    }
}
- (NSDate *)ly_weakDayEndDateCrossMonth:(BOOL)crossMonth
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    // 话说在真机上需要设置区域，才能正确获取本地日期，天朝代码:zh_CN
    calendar.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    NSInteger weakDay = [calendar component:(NSCalendarUnitWeekday) fromDate:self];
    NSInteger index = 0;
    switch (weakDay) {
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
    NSInteger day = [calendar component:(NSCalendarUnitDay) fromDate:self];
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:self];
    if ((range.length - day) < (7 -  index)) {
        if (crossMonth) {
            return [[[self ly_dayEndDate] dateByAddingTimeInterval:24*3600*(7-index)] ly_dayEndDate];
        } else {
            return [self ly_monthEndDate];
        }
    }
    else if ((range.length - day) == (7 -  index)) {
        return [self ly_monthEndDate];
    }
    else {
        return [[self ly_dayEndDate] dateByAddingTimeInterval:24*3600*(7-index)];
    }
}
@end
