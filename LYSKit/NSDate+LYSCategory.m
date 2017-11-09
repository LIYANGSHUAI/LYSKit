//
//  NSDate+LYSCategory.m
//  LYSKitDemo
//
//  Created by HENAN on 2017/11/9.
//  Copyright © 2017年 HENAN. All rights reserved.
//

#import "NSDate+LYSCategory.h"

@implementation NSDate (LYSCategory)
// 获取给定时间的字符串格式
+ (NSString *)ly_stringWithDate:(NSDate *)date
                      formatter:(NSString *)formatStr
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = formatStr;
    return [formatter stringFromDate:date];
}
// 获取当前时间的字符串格式
+ (NSString *)ly_stringWithCurrentDateFormatter:(NSString *)formatStr
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = formatStr;
    return [formatter stringFromDate:[NSDate date]];
}
// 获取当前时间的字符串格式
- (NSString *)ly_stringWithFormatter:(NSString *)formatStr
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = formatStr;
    return [formatter stringFromDate:self];
}
// 字符串转日期
+ (NSDate *)ly_dateWithStr:(NSString *)dateStr
                 formatter:(NSString *)formatStr
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:formatStr];
    return [formatter dateFromString:dateStr];
}
// 指定时间和当前时间比较
+ (NSString *)compareCurrentTime:(NSDate*)compareDate
{
    NSTimeInterval timeInterval = [compareDate timeIntervalSinceNow];
    timeInterval = -timeInterval;
    NSInteger time = round(timeInterval);
    long temp = 0;
    if (time < 60) {
        NSString *result = @"刚刚";
        return result;
    }
    else if((temp = timeInterval/60) <60){
        NSString *result = [NSString stringWithFormat:@"%ld分前",temp];
        return result;
    }
    else if((temp = temp/60) <24){
        NSString *result = [NSString stringWithFormat:@"%ld小前",temp];
        return result;
    }
    else if((temp = temp/24) <30){
        NSString *result = [NSString stringWithFormat:@"%ld天前",temp];
        return result;
    }
    else if((temp = temp/30) <12){
        NSString *result = [NSString stringWithFormat:@"%ld月前",temp];
        return result;
    }
    else{
        temp = temp/12;
        NSString *result = [NSString stringWithFormat:@"%ld年前",temp];
        return result;
    }
    return  nil;
}
// 获取n个24小时之后的NSDate
+ (NSDate *)ly_dateSincleNow:(NSInteger)num
{
    return [NSDate dateWithTimeIntervalSinceNow:24 * 3600 * num];
}
// 获取明天的这个时间点的NSDate
+ (NSDate *)ly_dateTomorrow
{
    return [self ly_dateSincleNow:1];
}
// 获取昨天的这个时间点的NSDate
+ (NSDate *)ly_dateYesterday
{
    return [self ly_dateSincleNow:-1];
}
@end
