//
//  LYSKVOManager.m
//  LYSKitDemo
//
//  Created by HENAN on 2017/12/5.
//  Copyright © 2017年 HENAN. All rights reserved.
//

#import "LYSKVOManager.h"
#import "LYSRuntimeManager.h"

#define LYActionDict @"LYActionDict"

@implementation LYSKVOManager

+ (void)addObserverToObject:(id)object forKeyPath:(NSString *)keyPath action:(void(^)(id oldValue,id newValue))action identifier:(NSString *)identifier
{
    NSDictionary *dict = [LYSRuntimeManager associationPropertyName:LYActionDict toObject:object];
    dict = dict ? [NSMutableDictionary dictionaryWithDictionary:dict] : [NSMutableDictionary dictionary];
    if ([[dict allKeys] containsObject:keyPath])
    {
        NSMutableDictionary *identifierDict = [NSMutableDictionary dictionaryWithDictionary:[dict objectForKey:keyPath]];
        [identifierDict setObject:action forKey:identifier];
        [(NSMutableDictionary *)dict setObject:identifierDict forKey:keyPath];
    }else
    {
        [(NSMutableDictionary *)dict setObject:@{identifier:action} forKey:keyPath];
        [LYSRuntimeManager addMethodForClass:[object class] fromClass:self instanceSel:@selector(observeValueForKeyPath:ofObject:change:context:)];
        [LYSRuntimeManager addMethodForClass:[object class] fromClass:self instanceSel:NSSelectorFromString(@"dealloc")];
        [object addObserver:object forKeyPath:keyPath options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:nil];
    }
    [LYSRuntimeManager associationPropertyName:LYActionDict value:dict toObject:object];
}

+ (void)removeObserverToObject:(id)object
                       forKeyPath:(NSString *)keyPath
                       identifier:(NSString *)identifier
{
    NSDictionary *dict = [LYSRuntimeManager associationPropertyName:LYActionDict toObject:object];
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
                [LYSRuntimeManager associationPropertyName:LYActionDict value:dict toObject:object];
            }else
            {
                [(NSMutableDictionary *)dict setObject:identifierDict forKey:keyPath];
                [LYSRuntimeManager associationPropertyName:LYActionDict value:dict toObject:object];
            }
        }
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSString *,id> *)change
                       context:(void *)context
{
    NSDictionary *dict = [LYSRuntimeManager associationPropertyName:LYActionDict toObject:object];
    if (dict && [[dict allKeys] containsObject:keyPath])
    {
        for (NSString *identifier in [dict objectForKey:keyPath])
        {
            void(^action)(id oldValue,id newValue) = [dict objectForKey:keyPath][identifier];
            action(change[@"old"],change[@"new"]);
        }
    }
}

- (void)dealloc
{
    NSDictionary *dict = [LYSRuntimeManager associationPropertyName:LYActionDict toObject:self];
    if (dict) {for (NSString *keyPath in dict) {[self removeObserver:self forKeyPath:keyPath];}}
    [LYSRuntimeManager associationPropertyName:LYActionDict value:@{} toObject:self];
}

@end

