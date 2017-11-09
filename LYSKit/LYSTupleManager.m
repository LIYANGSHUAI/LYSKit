//
//  LYSTupleManager.m
//  LYSKitDemo
//
//  Created by HENAN on 2017/11/9.
//  Copyright © 2017年 HENAN. All rights reserved.
//

#import "LYSTupleManager.h"

@implementation LYSTupleManager
+ (instancetype)ly_create:(id)one two:(id)two
{
    LYSTupleManager *tuple = [[LYSTupleManager alloc] init];
    tuple.one = one;
    tuple.two = two;
    return tuple;
}
@end
