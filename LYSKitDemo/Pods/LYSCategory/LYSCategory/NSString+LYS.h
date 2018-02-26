//
//  NSString+LYS.h
//  LYSKit
//
//  Created by HENAN on 2018/2/26.
//  Copyright © 2018年 liyangshuai. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark - 常用手机运营商枚举值 区分电话号码类型-

typedef NS_ENUM(NSUInteger, LYSTelephoneNumber) {
    LYSTelephoneNumberYiDong,                                 // 移动
    LYSTelephoneNumberLiTong,                                 // 联通
    LYSTelephoneNumberGuHua,                                  // 固话
    LYSTelephoneNumberUnKnow                                  // 未知
};

@interface NSString (LYS)

- (NSData *)ly_toData;
- (NSDictionary *)ly_toDictionary;

- (NSString *)ly_stringClearWhitespaceAndNewLine;
- (CGRect)ly_rectWithSize:(CGSize)size attributes:(NSDictionary<NSString *,id> *)attributes;

- (NSString *)ly_firstLatter;
- (NSString *)ly_toPinyin;

- (LYSTelephoneNumber)ly_telePhoneNumBer;

- (NSArray<NSString *> *)ly_splitWithString:(NSString *)separator;

- (BOOL)ly_hasPrefix:(NSString *)str;
- (BOOL)ly_hasSuffix:(NSString *)str;
@end
