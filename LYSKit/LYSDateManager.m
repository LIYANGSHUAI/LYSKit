
//
//  LYSDateManager.m
//  LYSKitDemo
//
//  Created by HENAN on 2018/4/20.
//  Copyright © 2018年 liyangshuai. All rights reserved.
//

#import "LYSDateManager.h"

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

bool ly_IsEqual(LYDate date1,LYDate date2){
    bool result = false;
    if (date1.y == date2.y && date1.m == date2.m && date1.d == date2.d && date1.h == date2.h && date1.f == date2.f && date1.s == date2.s) {
        result = true;
    }
    return result;
}

bool ly_SameYear(LYDate date1,LYDate date2){
    bool result = false;
    if (date1.y == date2.y) {
        result = true;
    }
    return result;
}

bool ly_SameMonth(LYDate date1,LYDate date2){
    bool result = false;
    if (ly_SameYear(date1, date2) && date1.m == date2.m) {
        result = true;
    }
    return result;
}

bool ly_SameDay(LYDate date1,LYDate date2){
    bool result = false;
    if (ly_SameMonth(date1, date2) && date1.d == date2.d) {
        result = true;
    }
    return result;
}

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

+ (LYDate)ly_Today{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    LYDate LYdate;
    NSDate *date = [NSDate date];
    [formatter setDateFormat:@"yyyy"];
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

+ (LYDate)ly_LYDateFromDate:(NSDate *)date{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    LYDate LYdate;
    [formatter setDateFormat:@"yyyy"];
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

+ (NSInteger)ly_DayNumForDate:(NSDate *)date{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    [calendar setLocale:[NSLocale currentLocale]];
    [calendar setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:8]];
    NSRange range = [calendar rangeOfUnit:(NSCalendarUnitDay) inUnit:(NSCalendarUnitMonth) forDate:date];
    return range.length;
}

+ (NSInteger)ly_WeekDayForFirstDate:(NSDate *)date{
    LYDate lydate = [self ly_LYDateFromDate:date];
    lydate.d = 1;
    NSDate *firstDate = [self ly_DateFromLYDate:lydate];
    return [self ly_WeekDayForDate:firstDate];
}

+ (NSInteger)ly_DayForDate:(NSDate *)date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd"];
    return [[dateFormatter stringFromDate:date] integerValue];
}

+ (NSInteger)ly_DayForToday{
    return [self ly_DayForDate:[NSDate date]];
}

+ (NSDate *)ly_DateFromLYDate:(LYDate)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
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
