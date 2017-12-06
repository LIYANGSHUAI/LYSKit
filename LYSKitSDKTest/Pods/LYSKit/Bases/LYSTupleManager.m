//
//  LYSTupleManager.m
//  LYSKitDemo
//
//  Created by HENAN on 2017/12/5.
//  Copyright © 2017年 HENAN. All rights reserved.
//

#import "LYSTupleManager.h"

@implementation LYSTupleManager

{
    id _tempOne;
    id _tempTwo;
}

- (instancetype)initWithOne:(id)one two:(id)two
{
    if (self = [super init]) {
        _tempOne = one;
        _tempTwo = two;
    }
    return self;
}

- (id)one
{
    return _tempOne;
}

- (id)two
{
    return _tempTwo;
}

+ (instancetype)tupleWithOne:(id)one two:(id)two
{
    return [[LYSTupleManager alloc] initWithOne:one two:two];
}

@end
