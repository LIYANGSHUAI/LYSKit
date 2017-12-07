//
//  NSString+LYSCategory.h
//  LYSKitDemo
//
//  Created by HENAN on 2017/12/6.
//  Copyright © 2017年 HENAN. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, LYSTelephoneNumber)
{
    LYSTelephoneNumberUnKnown,              // weizhi
    LYSTelephoneNumberYIDONG,               // yidong
    LYSTelephoneNumberLIANTONG,             // liantong
    LYSTelephoneNumberGUHUA,                // guhua
};

@interface NSString (LYSCategory)

// Conversion to NSData type
- (NSData *)toData;

// Convert into a dictionary
- (NSDictionary *)toDictionary;

// Get string Pinyin
- (NSString *)toPinyin;
    
// Remove the newline and space
- (NSString *)clearWhitespaceAndNewLine;

// Get the rect of the string in the specified area
- (CGRect)rectWithSize:(CGSize)size attributes:(NSDictionary<NSString *,id> *)attributes;

// Judge whether it is a cell phone number
- (LYSTelephoneNumber)computeTelePhoneNumber;

@end
