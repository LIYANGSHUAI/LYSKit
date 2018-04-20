//
//  NSString+LYSCategory.h
//  LYSKitDemo
//
//  Created by HENAN on 2018/4/20.
//  Copyright © 2018年 liyangshuai. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, LYSTelephoneNumber) {
    LYSTelephoneNumberYiDong,                                 // 移动
    LYSTelephoneNumberLiTong,                                 // 联通
    LYSTelephoneNumberGuHua,                                  // 固话
    LYSTelephoneNumberUnKnow                                  // 未知
};

@interface NSString (LYSCategory)

/**
 将字符串类型转换成NSData类型
 
 @return                                    返回NSData对象
 */
- (NSData *)ly_toData;

/**
 将字符串类型转换为字典类型
 
 @return                                    字典格式
 */
- (NSDictionary *)ly_toDictionary;

/**
 去掉字符串结尾换行和空格
 
 @return                                    返回转换后的字符串
 */
- (NSString *)ly_stringClearWhitespaceAndNewLine;

/**
 获取字符串在指定区域的预计占用Rect
 
 @param size                                指定区域
 @param attributes                          预计字符串参数
 @return                                    返回预计Rect
 */
- (CGRect)ly_rectWithSize:(CGSize)size attributes:(NSDictionary<NSString *,id> *)attributes;

/**
 获取首字母
 
 @return                                    返回字符串的首字母
 */
- (NSString *)ly_firstLatter;

/**
 获取字符串拼音
 
 @return                                    返回字符串的拼音
 */
- (NSString *)ly_toPinyin;

/**
 判断是不是手机号,以及手机号运营商名称,具体类型可查看LYSTelephoneNumber类型
 
 @return                                    返回手机号的类别
 */
- (LYSTelephoneNumber)ly_telePhoneNumBer;

/**
 用一个参照字符串,把另外一个字符串,拆分成数组
 
 @param separator                           参照字符串
 @return                                    拆分后的数组
 */
- (NSArray<NSString *> *)ly_splitWithString:(NSString *)separator;

/**
 判断一个字符串是否以另外一个字符串开头
 
 @param str                                 开头字符串
 @return                                    返回计算结果
 */
- (BOOL)ly_hasPrefix:(NSString *)str;

/**
 判断一个字符串是否以另外一个字符串结尾
 
 @param str                                 结尾字符串
 @return                                    返回计算结果
 */
- (BOOL)ly_hasSuffix:(NSString *)str;

/**
 判断一个字符串是否包含另外一个字符串

 @param str                                被包含的字符串
 @return                                   返回判断结果
 */
- (BOOL)ly_containsString:(NSString *)str;
@end
