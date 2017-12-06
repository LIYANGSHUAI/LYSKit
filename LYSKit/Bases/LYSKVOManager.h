//
//  LYSKVOManager.h
//  LYSKitDemo
//
//  Created by HENAN on 2017/12/5.
//  Copyright © 2017年 HENAN. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LYSKVOManager : NSObject

// Add observer
+ (void)addObserverToObject:(id)object forKeyPath:(NSString *)keyPath action:(void(^)(id oldValue,id newValue))action identifier:(NSString *)identifier;

// Remove the observation function
+ (void)removeObserverToObject:(id)object forKeyPath:(NSString *)keyPath identifier:(NSString *)identifier;

@end



