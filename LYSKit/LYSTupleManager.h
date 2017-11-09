//
//  LYSTupleManager.h
//  LYSKitDemo
//
//  Created by HENAN on 2017/11/9.
//  Copyright © 2017年 HENAN. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LYSTupleManager;
typedef LYSTupleManager* LYSTuple;
@interface LYSTupleManager : NSObject
// 对象一
@property (nonatomic,strong)id one;
// 对象二
@property (nonatomic,strong)id two;
// 创建方法
+ (instancetype)ly_create:(id)one two:(id)two;
@end
