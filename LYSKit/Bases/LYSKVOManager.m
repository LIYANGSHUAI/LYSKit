//
//  LYSKVOManager.m
//  LYSKitDemo
//
//  Created by HENAN on 2017/12/5.
//  Copyright © 2017年 HENAN. All rights reserved.
//

#import "LYSKVOManager.h"

#define LYActionDict @"LYActionDict"
#import <objc/runtime.h>
@implementation LYSKVOManager

+ (void)addObserverToObject:(id)object forKeyPath:(NSString *)keyPath action:(void(^)(id oldValue,id newValue))action identifier:(NSString *)identifier
{
    NSDictionary *dict = [self associationPropertyName:LYActionDict toObject:object];
    dict = dict ? [NSMutableDictionary dictionaryWithDictionary:dict] : [NSMutableDictionary dictionary];
    if ([[dict allKeys] containsObject:keyPath])
    {
        NSMutableDictionary *identifierDict = [NSMutableDictionary dictionaryWithDictionary:[dict objectForKey:keyPath]];
        [identifierDict setObject:action forKey:identifier];
        [(NSMutableDictionary *)dict setObject:identifierDict forKey:keyPath];
    }else
    {
        [(NSMutableDictionary *)dict setObject:@{identifier:action} forKey:keyPath];
        [self addMethodForClass:[object class] fromClass:self instanceSel:@selector(observeValueForKeyPath:ofObject:change:context:)];
        [self addMethodForClass:[object class] fromClass:self instanceSel:NSSelectorFromString(@"dealloc")];
        [object addObserver:object forKeyPath:keyPath options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:nil];
    }
    [self associationPropertyName:LYActionDict value:dict toObject:object];
}

+ (void)removeObserverToObject:(id)object
                       forKeyPath:(NSString *)keyPath
                       identifier:(NSString *)identifier
{
    NSDictionary *dict = [self associationPropertyName:LYActionDict toObject:object];
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
                [self associationPropertyName:LYActionDict value:dict toObject:object];
            }else
            {
                [(NSMutableDictionary *)dict setObject:identifierDict forKey:keyPath];
                [self associationPropertyName:LYActionDict value:dict toObject:object];
            }
        }
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSString *,id> *)change
                       context:(void *)context
{
    NSDictionary *dict = [self associationPropertyName:LYActionDict toObject:object];
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
    NSDictionary *dict = [self associationPropertyName:LYActionDict toObject:self];
    if (dict) {for (NSString *keyPath in dict) {[self removeObserver:self forKeyPath:keyPath];}}
    [self associationPropertyName:LYActionDict value:@{} toObject:self];
}
+ (id)associationPropertyName:(NSString *)name
                     toObject:(id)object
{
    return objc_getAssociatedObject(object, (__bridge const void *)(name));
}
+ (BOOL)addMethodForClass:(Class)forClass
                fromClass:(Class)fromClass
              instanceSel:(SEL)instanceSel
{
    IMP sel_IMP = class_getMethodImplementation(fromClass, instanceSel);
    Method sel_Method = class_getInstanceMethod(fromClass, instanceSel);
    const char *sel_Type = method_getTypeEncoding(sel_Method);
    BOOL result = class_addMethod(forClass, instanceSel, sel_IMP, sel_Type);
    return result;
}
+ (void)associationPropertyName:(NSString *)name
                          value:(id)value
                       toObject:(id)object
{
    objc_setAssociatedObject(object, (__bridge const void *)(name), value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
@end

