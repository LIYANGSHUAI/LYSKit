//
//  LYSKVOManager.m
//  LYSKitDemo
//
//  Created by HENAN on 2018/4/20.
//  Copyright © 2018年 liyangshuai. All rights reserved.
//

#import "LYSKVOManager.h"
#define LYActionDict @"LYActionDict"
#import "LYSRuntimeManager.h"
@implementation LYSKVOManager

+ (void)ly_addObserverToObject:(id)object
                    forKeyPath:(NSString *)keyPath
                        action:(void(^)(id oldValue,id newValue))action
                    identifier:(NSString *)identifier
{
    NSDictionary *dict = [LYSRuntimeManager ly_associationPropertyName:LYActionDict toObject:object];
    dict = dict ? [NSMutableDictionary dictionaryWithDictionary:dict] : [NSMutableDictionary dictionary];
    if ([[dict allKeys] containsObject:keyPath])
    {
        NSMutableDictionary *identifierDict = [NSMutableDictionary dictionaryWithDictionary:[dict objectForKey:keyPath]];
        [identifierDict setObject:action forKey:identifier];
        [(NSMutableDictionary *)dict setObject:identifierDict forKey:keyPath];
    }else
    {
        [(NSMutableDictionary *)dict setObject:@{identifier:action} forKey:keyPath];
        [LYSRuntimeManager ly_addMethodForClass:[object class] fromClass:self instanceSel:@selector(observeValueForKeyPath:ofObject:change:context:)];
        [LYSRuntimeManager ly_addMethodForClass:[object class] fromClass:self instanceSel:NSSelectorFromString(@"dealloc")];
        [object addObserver:object forKeyPath:keyPath options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:nil];
    }
    [LYSRuntimeManager ly_associationPropertyName:LYActionDict value:dict toObject:object];
}

+ (void)ly_removeObserverToObject:(id)object
                       forKeyPath:(NSString *)keyPath
                       identifier:(NSString *)identifier
{
    NSDictionary *dict = [LYSRuntimeManager ly_associationPropertyName:LYActionDict toObject:object];
    dict = dict ? [NSMutableDictionary dictionaryWithDictionary:dict] : [NSMutableDictionary dictionary];
    if ([[dict allKeys] containsObject:keyPath])
    {
        NSMutableDictionary *identifierDict = [NSMutableDictionary dictionaryWithDictionary:[dict objectForKey:keyPath]];
        if ([[identifierDict allKeys] containsObject:identifier])
        {
            [identifierDict removeObjectForKey:identifier];
            if ([identifierDict count] == 0)
            {
                [object removeObserver:object forKeyPath:keyPath];
                [(NSMutableDictionary *)dict removeObjectForKey:keyPath];
                [LYSRuntimeManager ly_associationPropertyName:LYActionDict value:dict toObject:object];
            }else
            {
                [(NSMutableDictionary *)dict setObject:identifierDict forKey:keyPath];
                [LYSRuntimeManager ly_associationPropertyName:LYActionDict value:dict toObject:object];
            }
        }
    }
}
#pragma mark - 观察者处理函数 -
- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSString *,id> *)change
                       context:(void *)context
{
    NSDictionary *dict = [LYSRuntimeManager ly_associationPropertyName:LYActionDict toObject:object];
    if (dict && [[dict allKeys] containsObject:keyPath])
    {
        for (NSString *identifier in [dict objectForKey:keyPath])
        {
            void(^action)(id oldValue,id newValue) = [dict objectForKey:keyPath][identifier];
            action(change[@"old"],change[@"new"]);
        }
    }
}
#pragma mark - 对象释放时,移除观察者 -
- (void)dealloc
{
    NSDictionary *dict = [LYSRuntimeManager ly_associationPropertyName:LYActionDict toObject:self];
    if (dict) {for (NSString *keyPath in dict) {[self removeObserver:self forKeyPath:keyPath];}}
    [LYSRuntimeManager ly_associationPropertyName:LYActionDict value:@{} toObject:self];
}

@end
