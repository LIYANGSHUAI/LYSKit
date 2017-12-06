//
//  LYSTupleManager.h
//  LYSKitDemo
//
//  Created by HENAN on 2017/12/5.
//  Copyright © 2017年 HENAN. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 The LYSTupleManager class, which mainly mimics the group of tuples in swift, implements the effect that an object can store two arbitrary objects at the same time
 */

@class  LYSTupleManager;
typedef LYSTupleManager* LYSTuple;

@interface LYSTupleManager : NSObject

// Used for storing objects to be stored
@property (nonatomic,strong,readonly)id one;
@property (nonatomic,strong,readonly)id two;

// Creation method
- (instancetype)initWithOne:(id)one two:(id)two;
+ (instancetype)tupleWithOne:(id)one two:(id)two;
@end

