//
//  NSString+LYSCategory.h
//  LYSKitDemo
//
//  Created by HENAN on 2017/11/9.
//  Copyright © 2017年 HENAN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSString (LYSCategory)
/**
 转换成NSData类型
 
 @return 返回NSData对象
 */
- (NSData *)ly_NSData;

/**
 字符串转换为字典(与NSDictionary+LYCategory.h中ly_string方法对应)
 
 @return 字典格式
 */
- (NSDictionary *)ly_dictionary;

/**
 去掉字符串结尾换行和空格
 
 @return 返回转换后的字符串
 */
- (NSString *)ly_stringClearWhitespaceAndNewLine;

/**
 获取字符串在指定区域的预计占用Rect
 
 @param size 指定区域
 @param attributes 预计字符串参数
 @return 返回预计Rect
 */
- (CGRect)ly_rectWithSize:(CGSize)size
               attributes:(NSDictionary<NSString *,id> *)attributes;

/**
 获取首字母
 
 @return 返回字符串的首字母
 */
- (NSString *)ly_firstLatter;

/**
 获取字符串拼音
 
 @return 返回字符串的拼音
 */
- (NSString *)ly_firstCharactor;

/**
 判断是不是手机号
 
 @return 返回手机号的类别
 */
- (NSString *)ly_telePhoneNumBer;

@end
