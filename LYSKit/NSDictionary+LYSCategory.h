//
//  NSDictionary+LYSCategory.h
//  LYSKitDemo
//
//  Created by HENAN on 2017/11/9.
//  Copyright © 2017年 HENAN. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (LYSCategory)
/**
 把字典转换成字符串格式(与NSString+LYCategory.h中ly_dictionary方法对应)
 
 @return 字符串格式
 */
- (NSString *)ly_string;

/**
 快速打印模型属性信息
 
 @param dict 字符串
 */
+ (void)ly_createPropertyCodeWithDict:(NSDictionary *)dict;
@end
