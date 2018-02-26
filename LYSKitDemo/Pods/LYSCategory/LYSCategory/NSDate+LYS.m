//
//  NSDate+LYS.m
//  LYSKit
//
//  Created by HENAN on 2018/2/26.
//  Copyright © 2018年 liyangshuai. All rights reserved.
//

#import "NSDate+LYS.h"

@implementation NSDate (LYS)

- (NSString *)ly_stringWithCurrentDateFormatter:(NSString *)formatter
{
    return [NSDate ly_stringWithCurrentDateFormatter:formatter];
}

- (NSString *)ly_stringWithDate:(NSDate *)date formatter:(NSString *)formatter
{
    return [NSDate ly_stringWithDate:date formatter:formatter];
}

+ (NSString *)ly_stringWithCurrentDateFormatter:(NSString *)formatter
{
    return [self ly_stringWithDate:[NSDate date] formatter:formatter];
}

+ (NSString *)ly_stringWithDate:(NSDate *)date formatter:(NSString *)formatter
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formatter];
    return [dateFormatter stringFromDate:date];
}

+ (NSString *)ly_compareCurrentTimeWithDate:(NSDate *)date
{
    NSTimeInterval timeInterval = - [date timeIntervalSinceNow];
    NSInteger time = round(timeInterval);
    long temp = 0;
    NSString *result = nil;
    if (time < 60)
    {
        result = @"刚刚";
    }else
        if((temp = timeInterval / 60) <60)
        {
            result = [NSString stringWithFormat:@"%ld分前",temp];
        }else
            if((temp = temp / 60) <24)
            {
                result = [NSString stringWithFormat:@"%ld小前",temp];
            }else
                if((temp = temp / 24) <30)
                {
                    result = [NSString stringWithFormat:@"%ld天前",temp];
                }else
                    if((temp = temp / 30) <12)
                    {
                        result = [NSString stringWithFormat:@"%ld月前",temp];
                    }else
                    {
                        result = [NSString stringWithFormat:@"%ld年前",temp / 12];
                    }
    return  result;
}

+ (NSDate *)ly_dateTomorrow
{
    return [self ly_dateWithNumberSincleNow:1];
}

+ (NSDate *)ly_dateYesterday
{
    return [self ly_dateWithNumberSincleNow:-1];
}

+ (NSDate *)ly_dateWithNumberSincleNow:(NSInteger)num
{
    return [NSDate dateWithTimeIntervalSinceNow:24 * 3600 * num];
}

@end
