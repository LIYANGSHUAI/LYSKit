//
//  LYSKVOManager.h
//  LYSKitDemo
//
//  Created by HENAN on 2017/11/9.
//  Copyright © 2017年 HENAN. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LYSKVOManager : NSObject
/**
 添加观察者
 
 @param object 需要被观察的对象
 @param keyPath 需要被观察的属性
 @param action 观察属性监测事件
 @param identifier 观察属性的标识(可用于移除)
 */
+ (void)ly_addObserverToObject:(id)object
                    forKeyPath:(NSString *)keyPath
                        action:(void(^)(id oldValue,id newValue))action
                    identifier:(NSString *)identifier;
/**
 移除观察函数
 
 @param object 被观察的对象
 @param keyPath 被观察的属性
 @param identifier 监测事件的标识
 */
+ (void)ly_removeObserverToObject:(id)object
                       forKeyPath:(NSString *)keyPath
                       identifier:(NSString *)identifier;
@end
