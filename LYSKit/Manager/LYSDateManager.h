//
//  LYSDateManager.h
//  LYSKitDemo
//
//  Created by HENAN on 2017/12/5.
//  Copyright © 2017年 HENAN. All rights reserved.
//

#import <Foundation/Foundation.h>

// Define a structure that is used to store a specific date to the date when the minutes and seconds
typedef struct {
    NSInteger y;
    NSInteger m;
    NSInteger d;
    NSInteger h;
    NSInteger f;
    NSInteger s;
}LYDate;

// Create a date structure for a time
LYDate ly_CreateDate(NSInteger y,
                     NSInteger m,
                     NSInteger d,
                     NSInteger h,
                     NSInteger f,
                     NSInteger s);

// Judge whether the two dates are the same time of the same day
bool ly_IsEqual(LYDate date1,LYDate date2);

// Whether it is the same year
bool ly_SameYear(LYDate date1,LYDate date2);

// Whether it is the same month
bool ly_SameMonth(LYDate date1,LYDate date2);

// Judge whether it is the same day
bool ly_SameDay(LYDate date1,LYDate date2);

// Compare two dates back to (1, 0, -1 (date1) corresponding to later than date2, date1 and date2, date1 later than date2), compared to the minimum, if the specific time second, can not be distinguished
NSInteger ly_CompareDate(LYDate date1,LYDate date2);

@interface LYSDateManager : NSObject

// Get today's LYDate format
+ (LYDate)today;

// Converting a date into a LYDate format
+ (LYDate)LYDateFromDate:(NSDate *)date;

// Getting a given date is what week
+ (NSInteger)weekDayForDate:(NSDate *)date;

// How many days are there to get this month
+ (NSInteger)dayNumForDate:(NSDate *)date;

// Get the first day of the month
+ (NSInteger)weekDayForFirstDate:(NSDate *)date;

// Get a given date is a number
+ (NSInteger)dayForDate:(NSDate *)date;

// Get the number of today
+ (NSInteger)dayForToday;

// Turn LYDate to NSDate
+ (NSDate *)dateFromLYDate:(LYDate)date;
@end

