//
//  NSDate+LYS.h
//  LYSKit
//
//  Created by HENAN on 2018/2/26.
//  Copyright © 2018年 liyangshuai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (LYS)

- (NSString *)ly_stringWithCurrentDateFormatter:(NSString *)formatter;
- (NSString *)ly_stringWithDate:(NSDate *)date formatter:(NSString *)formatter;

+ (NSString *)ly_stringWithCurrentDateFormatter:(NSString *)formatter;
+ (NSString *)ly_stringWithDate:(NSDate *)date formatter:(NSString *)formatter;

+ (NSString *)ly_compareCurrentTimeWithDate:(NSDate *)date;

+ (NSDate *)ly_dateTomorrow;
+ (NSDate *)ly_dateYesterday;

+ (NSDate *)ly_dateWithNumberSincleNow:(NSInteger)num;

@end
