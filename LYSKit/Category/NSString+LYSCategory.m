//
//  NSString+LYSCategory.m
//  LYSKitDemo
//
//  Created by HENAN on 2017/12/6.
//  Copyright © 2017年 HENAN. All rights reserved.
//

#import "NSString+LYSCategory.h"

@implementation NSString (LYSCategory)

/**
 转换成NSData 类型

 @return 返回对应的NSData 数据
 */
- (NSData *)toData{return [self dataUsingEncoding:NSUTF8StringEncoding];}
- (NSDictionary *)toDictionary
{
    return [NSJSONSerialization JSONObjectWithData:[self toData] options:(NSJSONReadingAllowFragments) error:nil];
}
- (NSString *)toPinyin
{
    // 转成了可变字符串
    NSMutableString *str = [NSMutableString stringWithString:self];
    // 先转换为带声调的拼音
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformMandarinLatin,NO);
    // 再转换为不带声调的拼音
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformStripDiacritics,NO);
    return str;
}
- (NSString *)clearWhitespaceAndNewLine
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}
- (CGRect)rectWithSize:(CGSize)size
            attributes:(NSDictionary<NSString *,id> *)attributes
{
    return [self boundingRectWithSize:size
                              options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attributes
                              context:nil];
}
- (LYSTelephoneNumber)computeTelePhoneNumber
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     * 中国移动：China Mobile
     * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     * 中国联通：China Unicom
     * 130,131,132,152,155,156,185,186
     */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     * 中国电信：China Telecom
     * 133,1349,153,180,189
     */
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
     * 大陆地区固话及小灵通
     * 区号：010,020,021,022,023,024,025,027,028,029
     * 号码：七位或八位
     */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    LYSTelephoneNumber result = LYSTelephoneNumberUnKnown;
    
    if (([regextestmobile evaluateWithObject:self] == YES)
        || ([regextestcm evaluateWithObject:self] == YES)
        || ([regextestct evaluateWithObject:self] == YES)
        || ([regextestcu evaluateWithObject:self] == YES))
    {
        if([regextestcm evaluateWithObject:self] == YES) {
            result = LYSTelephoneNumberYIDONG;
        } else if([regextestct evaluateWithObject:self] == YES) {
            result = LYSTelephoneNumberLIANTONG;
        } else if ([regextestcu evaluateWithObject:self] == YES) {
            result = LYSTelephoneNumberGUHUA;
        } else {
            result = LYSTelephoneNumberUnKnown;
        }
    }
    else
    {
        result = LYSTelephoneNumberUnKnown;
    }
    return result;
}
@end
