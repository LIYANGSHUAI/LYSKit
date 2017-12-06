//
//  NSDate+LYSCategory.m
//  LYSKitDemo
//
//  Created by HENAN on 2017/12/6.
//  Copyright © 2017年 HENAN. All rights reserved.
//

#import "NSDate+LYSCategory.h"

@implementation NSDate (LYSCategory)
+ (NSString *)stringWithDate:(NSDate *)date
                      formatter:(NSString *)formatStr
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = formatStr;
    return [formatter stringFromDate:date];
}
- (NSString *)stringWithFormatter:(NSString *)formatStr
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = formatStr;
    return [formatter stringFromDate:self];
}
+ (NSDate *)dateWithStr:(NSString *)dateStr
                 formatter:(NSString *)formatStr
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:formatStr];
    return [formatter dateFromString:dateStr];
}
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
@end
