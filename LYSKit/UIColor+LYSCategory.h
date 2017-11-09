//
//  UIColor+LYSCategory.h
//  LYSKitDemo
//
//  Created by HENAN on 2017/11/9.
//  Copyright © 2017年 HENAN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (LYSCategory)

/**
 十六进制转color

 @param hexStr 颜色十六进制
 @return 对应的color
 */
+ (UIColor *)ly_hex:(NSString *)hexStr;
@end
