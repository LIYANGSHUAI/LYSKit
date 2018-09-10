//
//  NSString+LYSCategory.m
//  LYSKitDemo
//
//  Created by HENAN on 2018/4/20.
//  Copyright © 2018年 liyangshuai. All rights reserved.
//

#import "NSString+LYSCategory.h"

#define ISLATER_8 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

@implementation NSString (LYSCategory)

- (NSData *)ly_toData
{
    return [self dataUsingEncoding:NSUTF8StringEncoding];
}

- (NSDictionary *)ly_toDictionary
{
    return [NSJSONSerialization JSONObjectWithData:[self ly_toData] options:(NSJSONReadingAllowFragments) error:nil];
}

- (NSDictionary *)ly_toArray
{
    return [NSJSONSerialization JSONObjectWithData:[self ly_toData] options:(NSJSONReadingAllowFragments) error:nil];
}

- (NSString *)ly_stringClearWhitespaceAndNewLine
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (CGRect)ly_rectWithSize:(CGSize)size attributes:(NSDictionary<NSString *,id> *)attributes
{
    return [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attributes context:nil];
}

- (NSString *)ly_firstLatter
{
    return [self substringToIndex:1];
}

- (NSString *)ly_toPinyin
{
    //转成了可变字符串
    NSMutableString *str = [NSMutableString stringWithString:self];
    //先转换为带声调的拼音
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformMandarinLatin,NO);
    //再转换为不带声调的拼音
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformStripDiacritics,NO);
    return str;
}

- (LYSTelephoneNumber)ly_telePhoneNumBer
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189
     22         */
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    LYSTelephoneNumber result = LYSTelephoneNumberUnKnow;
    
    if (([regextestmobile evaluateWithObject:self] == YES)
        || ([regextestcm evaluateWithObject:self] == YES)
        || ([regextestct evaluateWithObject:self] == YES)
        || ([regextestcu evaluateWithObject:self] == YES))
    {
        if([regextestcm evaluateWithObject:self] == YES)
        {
            result = LYSTelephoneNumberYiDong;
        } else
            if([regextestct evaluateWithObject:self] == YES)
            {
                result = LYSTelephoneNumberLiTong;
            } else
                if ([regextestcu evaluateWithObject:self] == YES)
                {
                    result = LYSTelephoneNumberGuHua;
                } else
                {
                    result = LYSTelephoneNumberUnKnow;
                }
    }
    else
    {
        result = LYSTelephoneNumberUnKnow;
    }
    return result;
}

- (NSArray<NSString *> *)ly_splitWithString:(NSString *)separator{
    return [self componentsSeparatedByString:separator];
}

- (BOOL)ly_hasPrefix:(NSString *)str{
    return [self hasPrefix:str];
}

- (BOOL)ly_hasSuffix:(NSString *)str{
    return [self hasSuffix:str];
}

- (BOOL)ly_containsString:(NSString *)str {
    if (ISLATER_8) {
        return [self containsString:str];
    } else {
        return [self rangeOfString:str].length > 0;
    }
}
@end
