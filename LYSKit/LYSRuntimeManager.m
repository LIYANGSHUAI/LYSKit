//
//  LYSRuntimeManager.m
//  LYSKitDemo
//
//  Created by HENAN on 2018/4/20.
//  Copyright © 2018年 liyangshuai. All rights reserved.
//

#import "LYSRuntimeManager.h"
#import <objc/runtime.h>

#define LYPropertyChangeActionDict @"AssociationProperty_with_MonitorAction"
#define LYPropertyDict @"AssociationProperty"

@implementation LYSRuntimeManager
+ (NSArray *)ly_getPropertyListForClass:(Class)className
{
    unsigned int count;
    NSMutableArray *mAry = [NSMutableArray array];
    objc_property_t *list = class_copyPropertyList(className, &count);
    for (unsigned int i = 0; i < count; i++)
    {
        const char *name = property_getName(list[i]);
        [mAry addObject:[NSString stringWithUTF8String:name]];
    }
    return [NSArray arrayWithArray:mAry];
}

+ (NSArray *)ly_getMethodListForClass:(Class)className
{
    unsigned int count;
    NSMutableArray *mAry = [NSMutableArray array];
    Method *list = class_copyMethodList(className, &count);
    for (unsigned int i = 0; i < count; i++)
    {
        Method method = list[i];
        SEL sel = method_getName(method);
        NSString *selStr = NSStringFromSelector(sel);
        [mAry addObject:selStr];
    }
    return [NSArray arrayWithArray:mAry];
}

+ (NSArray *)ly_getIvarListForClass:(Class)className
{
    unsigned int count;
    NSMutableArray *mAry = [NSMutableArray array];
    Ivar *list = class_copyIvarList(className, &count);
    for (unsigned int i = 0; i < count; i++)
    {
        Ivar myIvar = list[i];
        const char *ivarName = ivar_getName(myIvar);
        [mAry addObject:[NSString stringWithUTF8String:ivarName]];
    }
    return [NSArray arrayWithArray:mAry];
}

+ (NSArray *)ly_getProtocolListForClass:(Class)className
{
    unsigned int count;
    NSMutableArray *mAry = [NSMutableArray array];
    __unsafe_unretained Protocol **list = class_copyProtocolList(className, &count);
    for (unsigned int i = 0; i < count; i++)
    {
        Protocol *myProtocal = list[i];
        const char *protocolName = protocol_getName(myProtocal);
        [mAry addObject: [NSString stringWithUTF8String:protocolName]];
    }
    return [NSArray arrayWithArray:mAry];
}

+ (void)ly_associationPropertyName:(NSString *)name
                             value:(id)value
                          toObject:(id)object
{
    objc_setAssociatedObject(object, (__bridge const void *)(name), value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (id)ly_associationPropertyName:(NSString *)name
                        toObject:(id)object
{
    return objc_getAssociatedObject(object, (__bridge const void *)(name));
}

+ (void)ly_removeAssociationPropertyToObject:(id)object
{
    objc_removeAssociatedObjects(object);
}

+ (void)ly_setAssociationPropertyName:(NSString *)name
                                value:(id)value
                             toObject:(id)object
{
    BOOL isCanChange = YES;
    NSDictionary *changeActionDict = objc_getAssociatedObject(object, LYPropertyChangeActionDict);
    NSString *tempAction = [NSString stringWithFormat:@"%@ChangeAction",name];
    if (changeActionDict && [[changeActionDict allKeys] containsObject:tempAction])
    {
        id oldValue = [self ly_getAssociationPropertyName:name toObject:object];
        id newValue = value;
        for (NSString *identifier in [changeActionDict objectForKey:tempAction])
        {
            BOOL(^action)(NSString *name,id oldValue,id newValue) = (BOOL(^)(NSString *name,id oldValue,id newValue))[changeActionDict objectForKey:tempAction][identifier];
            if (!action(name,oldValue,newValue))
            {
                isCanChange = NO;
            }
        }
    }
    if (isCanChange)
    {
        NSDictionary *propertyDict = objc_getAssociatedObject(object, LYPropertyDict);
        if (!propertyDict)
        {
            propertyDict = [NSMutableDictionary dictionary];
        }else
        {
            propertyDict = [NSMutableDictionary dictionaryWithDictionary:propertyDict];
        }
        [((NSMutableDictionary *)propertyDict) setObject:value forKey:name];
        objc_setAssociatedObject(object, LYPropertyDict, propertyDict, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

+ (void)ly_setAssociationPropertyMonitorName:(NSString *)name
                               monitorAction:(BOOL(^)(NSString *name,id oldValue,id newValue))action
                                    toObject:(id)object
                                  identifier:(NSString *)identifier
{
    if (!identifier){return;}
    NSDictionary *dict = objc_getAssociatedObject(object, LYPropertyChangeActionDict);
    if (!dict)
    {
        dict = [NSMutableDictionary dictionary];
    }else
    {
        dict = [NSMutableDictionary dictionaryWithDictionary:dict];
    }
    NSString *tempAction = [NSString stringWithFormat:@"%@ChangeAction",name];
    if ([[dict allKeys] containsObject:tempAction])
    {
        NSMutableDictionary *actionDict = [NSMutableDictionary dictionaryWithDictionary:[dict objectForKey:tempAction]];
        [actionDict setObject:action forKey:identifier];
        [((NSMutableDictionary *)dict) setObject:actionDict forKey:tempAction];
    }else
    {
        [((NSMutableDictionary *)dict) setObject:@{identifier:action} forKey:tempAction];
    }
    objc_setAssociatedObject(object, LYPropertyChangeActionDict, dict, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (id)ly_getAssociationPropertyName:(NSString *)name
                           toObject:(id)object
{
    NSDictionary *dict = objc_getAssociatedObject(object, LYPropertyDict);
    if (!dict) {return nil;}
    if (![[dict allKeys] containsObject:name]) {return nil;}
    return [dict objectForKey:name];
}

+ (void)ly_removeAllAssociationPropertyForObject:(id)object
{
    objc_setAssociatedObject(object, LYPropertyDict, @{}, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(object, LYPropertyChangeActionDict, @{}, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (void)ly_removeAssociationPropertyName:(NSString *)name
                                toObject:(id)object
{
    NSDictionary *propertyDict = objc_getAssociatedObject(object, LYPropertyDict);
    if (!propertyDict) {return;}
    propertyDict = [NSMutableDictionary dictionaryWithDictionary:propertyDict];
    if ([[propertyDict allKeys] containsObject:name])
    {
        [(NSMutableDictionary *)propertyDict removeObjectForKey:name];
        objc_setAssociatedObject(object, LYPropertyDict, propertyDict, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    NSDictionary *changeActionDict = objc_getAssociatedObject(object, LYPropertyChangeActionDict);
    NSString *tempAction = [NSString stringWithFormat:@"%@ChangeAction",name];
    if (!changeActionDict) {return;}
    changeActionDict = [NSMutableDictionary dictionaryWithDictionary:changeActionDict];
    if ([[changeActionDict allKeys] containsObject:tempAction])
    {
        [(NSMutableDictionary *)changeActionDict removeObjectForKey:tempAction];
        objc_setAssociatedObject(object, LYPropertyChangeActionDict, changeActionDict, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

+ (void)ly_removeAssociationPropertyName:(NSString *)name
                              identifier:(NSString *)identifier
                                toObject:(id)object
{
    NSDictionary *changeActionDict = objc_getAssociatedObject(object, LYPropertyChangeActionDict);
    NSString *tempAction = [NSString stringWithFormat:@"%@ChangeAction",name];
    if (!changeActionDict) {return;}
    changeActionDict = [NSMutableDictionary dictionaryWithDictionary:changeActionDict];
    if ([[changeActionDict allKeys] containsObject:tempAction])
    {
        NSMutableDictionary *actionDict = [NSMutableDictionary dictionaryWithDictionary:[changeActionDict objectForKey:tempAction]];
        if ([[actionDict allKeys] containsObject:identifier])
        {
            [actionDict removeObjectForKey:identifier];
            [(NSMutableDictionary *)changeActionDict setObject:actionDict forKey:tempAction];
        }
        objc_setAssociatedObject(object, LYPropertyChangeActionDict, changeActionDict, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

+ (NSArray *)ly_getAssociationPropertyListForObject:(id)object
{
    NSDictionary *dict = objc_getAssociatedObject(object, LYPropertyDict);
    return dict ? [dict allKeys] : nil;
}

+ (BOOL)ly_replaceMethodForClass:(Class)forClass
               forInstanceMethod:(SEL)forInstanceMethod
                       fromClass:(Class)fromClass
              fromInstanceMethod:(SEL)fromInstanceMethod
{
    Method replaceSel_Method = class_getInstanceMethod(fromClass, fromInstanceMethod);
    const char *replaceSel_Type = method_getTypeEncoding(replaceSel_Method);
    IMP resultSel = class_replaceMethod(forClass, forInstanceMethod, method_getImplementation(replaceSel_Method) , replaceSel_Type);
    return resultSel ? YES : NO;
}

+ (BOOL)ly_replaceMethodForClass:(Class)forClass
               forInstanceMethod:(SEL)forInstanceMethod
                       fromClass:(Class)fromClass
                 fromClassMethod:(SEL)fromClassMethod
{
    Method replaceSel_Method = class_getClassMethod(fromClass, fromClassMethod);
    const char *replaceSel_Type = method_getTypeEncoding(replaceSel_Method);
    IMP resultSel = class_replaceMethod(forClass, forInstanceMethod, method_getImplementation(replaceSel_Method) , replaceSel_Type);
    return resultSel ? YES : NO;
}

+ (void)ly_exchangeMethodFirstClass:(Class)firstClass
                firstInstanceMethod:(SEL)firstInstanceMethod
                        secondClass:(Class)secondClass
               secondInstanceMethod:(SEL)secondInstanceMethod
{
    Method firstSel_Method = class_getInstanceMethod(firstClass, firstInstanceMethod);
    Method secondSel_Method = class_getInstanceMethod(secondClass, secondInstanceMethod);
    method_exchangeImplementations(firstSel_Method, secondSel_Method);
}

+ (void)ly_exchangeMethodFirstClass:(Class)firstClass
                   firstClassMethod:(SEL)firstClassMethod
                        secondClass:(Class)secondClass
                  secondClassMethod:(SEL)secondClassMethod
{
    Method firstSel_Method = class_getClassMethod(firstClass, firstClassMethod);
    Method secondSel_Method = class_getClassMethod(secondClass, secondClassMethod);
    method_exchangeImplementations(firstSel_Method, secondSel_Method);
}

+ (void)ly_exchangeMethodFirstClass:(Class)firstClass
                   firstClassMethod:(SEL)firstClassMethod
                        secondClass:(Class)secondClass
               secondInstanceMethod:(SEL)secondInstanceMethod
{
    Method classMethod = class_getClassMethod(firstClass, firstClassMethod);
    Method instanceMethod = class_getInstanceMethod(secondClass, secondInstanceMethod);
    method_exchangeImplementations(classMethod, instanceMethod);
}

+ (BOOL)ly_addMethodForClass:(Class)forClass
                   fromClass:(Class)fromClass
                 instanceSel:(SEL)instanceSel
{
    IMP sel_IMP = class_getMethodImplementation(fromClass, instanceSel);
    Method sel_Method = class_getInstanceMethod(fromClass, instanceSel);
    const char *sel_Type = method_getTypeEncoding(sel_Method);
    BOOL result = class_addMethod(forClass, instanceSel, sel_IMP, sel_Type);
    return result;
}

+ (BOOL)ly_addMethodForClass:(Class)forClass
                   fromClass:(Class)fromClass
                    classSel:(SEL)classSel
{
    IMP sel_IMP = class_getMethodImplementation(fromClass, classSel);
    Method sel_Method = class_getClassMethod(fromClass, classSel);
    const char *sel_Type = method_getTypeEncoding(sel_Method);
    BOOL result = class_addMethod(forClass, classSel, sel_IMP, sel_Type);
    return result;
}

@end
