//
//  LYSKVOManager.h
//  LYSKitDemo
//
//  Created by HENAN on 2018/4/20.
//  Copyright © 2018年 liyangshuai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LYSKVOManager : NSObject
/**
 添加观察者,实现原理是实现 observeValueForKeyPath: ofObject: change: context:方法,一次使用该方法进行属性监测时,不要重写这个系统方法,否则会失效
 
 @param object                              需要被观察的对象
 @param keyPath                             需要被观察的属性
 @param action                              观察属性监测事件
 @param identifier                          观察属性的标识(可用于移除)
 */
+ (void)ly_addObserverToObject:(id)object forKeyPath:(NSString *)keyPath action:(void(^)(id oldValue,id newValue))action identifier:(NSString *)identifier;

/**
 移除观察函数
 
 @param object                              被观察的对象
 @param keyPath                             被观察的属性
 @param identifier                          监测事件的标识
 */
+ (void)ly_removeObserverToObject:(id)object forKeyPath:(NSString *)keyPath identifier:(NSString *)identifier;

@end
