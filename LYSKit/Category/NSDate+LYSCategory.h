//
//  NSDate+LYSCategory.h
//  LYSKitDemo
//
//  Created by HENAN on 2017/12/6.
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

// Class method to get a given date string display
+ (NSString *)stringWithDate:(NSDate *)date
                      formatter:(NSString *)formatStr;
- (NSString *)stringWithFormatter:(NSString *)formatStr;

// String date
+ (NSDate *)dateWithStr:(NSString *)dateStr
                 formatter:(NSString *)formatStr;

// The comparison between the specified time and the current time
+ (NSString *)compareCurrentTime:(NSDate*)compareDate;
@end

