//
//  LYSCodeManager.h
//  LYSKitDemo
//
//  Created by HENAN on 2018/10/10.
//  Copyright © 2018年 liyangshuai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LYSCodeManager : NSObject

/**
 传入字典类型,打印出模型公开属性

 @param dict 字典模型
 @return 返回公开属性字符串
 */
+ (NSMutableString *)ly_matchingPropertyWithDict:(NSDictionary *)dict;
@end
