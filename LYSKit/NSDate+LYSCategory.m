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
    NSInteger time = round(timeInterval);
    long temp = 0;
    NSString *result = nil;
    if (time >= 0) {
        if ((temp = time) < 60)
        {
            result = @"刚刚";
        } else
            if((temp = temp / 60) <60)
            {
                result = FORMAT(@"%ld分前",temp);
            } else
                if((temp = temp / 60) <24)
                {
                    result = FORMAT(@"%ld小时前",temp);
                } else
                    if((temp = temp / 24) <30)
                    {
                        result = FORMAT(@"%ld天前",temp);
                    } else
                        if((temp = temp / 30) <12)
                        {
                            result = FORMAT(@"%ld个月前",temp);
                        } else
                        {
                            result = FORMAT(@"%ld年前",temp / 12);
                        }
    } else {
        time = -time;
        if ((temp = time) < 60)
        {
            result = FORMAT(@"%ld秒后",temp);
        } else
            if((temp = temp / 60) <60)
            {
                result = FORMAT(@"%ld分后",temp);
            } else
                if((temp = temp / 60) <24)
                {
                    result = FORMAT(@"%ld小时后",temp);
                } else
                    if((temp = temp / 24) <30)
                    {
                        result = FORMAT(@"%ld天后",temp);
                    } else
                        if((temp = temp / 30) <12)
                        {
                            result = FORMAT(@"%ld个月后",temp);
                        } else
                        {
                            result = FORMAT(@"%ld年后",temp / 12);
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
@end
