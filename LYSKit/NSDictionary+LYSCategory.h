//
//  NSDictionary+LYSCategory.h
//  LYSKitDemo
//
//  Created by HENAN on 2018/4/20.
//  Copyright © 2018年 liyangshuai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (LYSCategory)

/**
 把字典类型转换成二进制类型
 
 @return                                     返回对应二进制数据
 */
- (NSData *)ly_toData;

/**
 把字典类型转换成字符串类型
 
 @return                                     字符串格式
 */
- (NSString *)ly_toString;

@end
