//
//  LYS_BaseObjc.m
//  LYSKit
//
//  Created by HENAN on 2017/9/22.
//  Copyright © 2017年 个人开发实用框架. All rights reserved.
//

#import "LYS_BaseObjc.h"
#import <objc/runtime.h>
#define LYPropertyChangeActionDict @"AssociationProperty_with_MonitorAction"
#define LYPropertyDict @"AssociationProperty"
@implementation LYRuntimeManager
// 获取对象的属性列表
+ (NSArray *)ly_getPropertyListForClass:(Class)className{
    unsigned int count;
    NSMutableArray *propertyListAry = [NSMutableArray array];
    //获取属性列表
    objc_property_t *propertyList = class_copyPropertyList(className, &count);
    for (unsigned int i = 0; i < count; i++) {
        const char *propertyName = property_getName(propertyList[i]);
        [propertyListAry addObject:[NSString stringWithUTF8String:propertyName]];
    }
    return [NSArray arrayWithArray:propertyListAry];
}
// 获取对象的方法列表
+ (NSArray *)ly_getMethodListForClass:(Class)className{
    unsigned int count;
    NSMutableArray *methodListAry = [NSMutableArray array];
    //获取方法列表
    Method *methodList = class_copyMethodList(className, &count);
    for (unsigned int i = 0; i < count; i++) {
        Method method = methodList[i];
        SEL sel = method_getName(method);
        NSString *selStr = NSStringFromSelector(sel);
        [methodListAry addObject:selStr];
    }
    return [NSArray arrayWithArray:methodListAry];
}
// 获取成员变量列表
+ (NSArray *)ly_getIvarListForClass:(Class)className{
    unsigned int count;
    NSMutableArray *ivarListAry = [NSMutableArray array];
    //获取成员变量列表
    Ivar *ivarList = class_copyIvarList(className, &count);
    for (unsigned int i = 0; i < count; i++) {
        Ivar myIvar = ivarList[i];
        const char *ivarName = ivar_getName(myIvar);
        [ivarListAry addObject:[NSString stringWithUTF8String:ivarName]];
    }
    return [NSArray arrayWithArray:ivarListAry];
}
// 获取协议列表
+ (NSArray *)ly_getProtocolListForClass:(Class)className{
    unsigned int count;
    NSMutableArray *protocolListAry = [NSMutableArray array];
    //获取协议列表
    __unsafe_unretained Protocol **protocolList = class_copyProtocolList(className, &count);
    for (unsigned int i = 0; i < count; i++) {
        Protocol *myProtocal = protocolList[i];
        const char *protocolName = protocol_getName(myProtocal);
        [protocolListAry addObject: [NSString stringWithUTF8String:protocolName]];
    }
    return [NSArray arrayWithArray:protocolListAry];
}
// 简单的为一个对象添加关联属性
+ (void)ly_associationPropertyName:(NSString *)name value:(id)value toObject:(id)object{
    objc_setAssociatedObject(object, (__bridge const void *)(name), value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
// 简单的获取一个对象的关联属性
+ (id)ly_associationPropertyName:(NSString *)name toObject:(id)object{
    return objc_getAssociatedObject(object, (__bridge const void *)(name));
}
// 移除对象的所有关联属性
+ (void)ly_removeAssociationPropertyToObject:(id)object{
    objc_removeAssociatedObjects(object);
}
// 添加关联对象
+ (void)ly_setAssociationPropertyName:(NSString *)name
                                value:(id)value
                             toObject:(id)object{
    BOOL isCanChange = YES;
    NSDictionary *changeActionDict = objc_getAssociatedObject(object, LYPropertyChangeActionDict);
    NSString *tempAction = [NSString stringWithFormat:@"%@ChangeAction",name];
    if (changeActionDict && [[changeActionDict allKeys] containsObject:tempAction]) {
        id oldValue = [self ly_getAssociationPropertyName:name toObject:object];
        id newValue = value;
        for (NSString *identifier in [changeActionDict objectForKey:tempAction]) {
            BOOL(^action)(NSString *name,id oldValue,id newValue) = (BOOL(^)(NSString *name,id oldValue,id newValue))[changeActionDict objectForKey:tempAction][identifier];
            if (!action(name,oldValue,newValue)) {
                isCanChange = NO;
            }
        }
    }
    if (isCanChange) {
        NSDictionary *propertyDict = objc_getAssociatedObject(object, LYPropertyDict);
        if (!propertyDict) {
            propertyDict = [NSMutableDictionary dictionary];
        }else {
            propertyDict = [NSMutableDictionary dictionaryWithDictionary:propertyDict];
        }
        [((NSMutableDictionary *)propertyDict) setObject:value forKey:name];
        objc_setAssociatedObject(object, LYPropertyDict, propertyDict, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}
// 监测关联对象变化回调
+ (void)ly_setAssociationPropertyMonitorName:(NSString *)name
                               monitorAction:(BOOL(^)(NSString *name,id oldValue,id newValue))action
                                    toObject:(id)object
                                  identifier:(NSString *)identifier{
    if (!identifier){return;}
    NSDictionary *dict = objc_getAssociatedObject(object, LYPropertyChangeActionDict);
    if (!dict) {
        dict = [NSMutableDictionary dictionary];
    }else {
        dict = [NSMutableDictionary dictionaryWithDictionary:dict];
    }
    NSString *tempAction = [NSString stringWithFormat:@"%@ChangeAction",name];
    if ([[dict allKeys] containsObject:tempAction]) {
        NSMutableDictionary *actionDict = [NSMutableDictionary dictionaryWithDictionary:[dict objectForKey:tempAction]];
        [actionDict setObject:action forKey:identifier];
        [((NSMutableDictionary *)dict) setObject:actionDict forKey:tempAction];
    }else{
        [((NSMutableDictionary *)dict) setObject:@{identifier:action} forKey:tempAction];
    }
    objc_setAssociatedObject(object, LYPropertyChangeActionDict, dict, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
// 获取关联对象
+ (id)ly_getAssociationPropertyName:(NSString *)name
                           toObject:(id)object{
    NSDictionary *dict = objc_getAssociatedObject(object, LYPropertyDict);
    if (!dict) {return nil;}
    if (![[dict allKeys] containsObject:name]) {return nil;}
    return [dict objectForKey:name];
}
// 移除关联对象
+ (void)ly_removeAllAssociationPropertyForObject:(id)object{
    objc_setAssociatedObject(object, LYPropertyDict, @{}, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(object, LYPropertyChangeActionDict, @{}, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
// 移除某一关联属性
+ (void)ly_removeAssociationPropertyName:(NSString *)name
                                toObject:(id)object{
    NSDictionary *propertyDict = objc_getAssociatedObject(object, LYPropertyDict);
    if (!propertyDict) {return;}
    propertyDict = [NSMutableDictionary dictionaryWithDictionary:propertyDict];
    if ([[propertyDict allKeys] containsObject:name]) {
        [(NSMutableDictionary *)propertyDict removeObjectForKey:name];
        objc_setAssociatedObject(object, LYPropertyDict, propertyDict, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    NSDictionary *changeActionDict = objc_getAssociatedObject(object, LYPropertyChangeActionDict);
    NSString *tempAction = [NSString stringWithFormat:@"%@ChangeAction",name];
    if (!changeActionDict) {return;}
    changeActionDict = [NSMutableDictionary dictionaryWithDictionary:changeActionDict];
    if ([[changeActionDict allKeys] containsObject:tempAction]) {
        [(NSMutableDictionary *)changeActionDict removeObjectForKey:tempAction];
        objc_setAssociatedObject(object, LYPropertyChangeActionDict, changeActionDict, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}
// 移除某一关联属性的关联监测方法
+ (void)ly_removeAssociationPropertyName:(NSString *)name
                              identifier:(NSString *)identifier
                                toObject:(id)object{
    NSDictionary *changeActionDict = objc_getAssociatedObject(object, LYPropertyChangeActionDict);
    NSString *tempAction = [NSString stringWithFormat:@"%@ChangeAction",name];
    if (!changeActionDict) {return;}
    changeActionDict = [NSMutableDictionary dictionaryWithDictionary:changeActionDict];
    if ([[changeActionDict allKeys] containsObject:tempAction]) {
        NSMutableDictionary *actionDict = [NSMutableDictionary dictionaryWithDictionary:[changeActionDict objectForKey:tempAction]];
        if ([[actionDict allKeys] containsObject:identifier]) {
            [actionDict removeObjectForKey:identifier];
            [(NSMutableDictionary *)changeActionDict setObject:actionDict forKey:tempAction];
        }
        objc_setAssociatedObject(object, LYPropertyChangeActionDict, changeActionDict, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}
// 获取对象的所有关联对象列表
+ (NSArray *)ly_getAssociationPropertyListForObject:(id)object{
    NSDictionary *dict = objc_getAssociatedObject(object, LYPropertyDict);
    return dict ? [dict allKeys] : nil;
}
// 用实例方法替换某一对象的Instance方法的实现
+ (BOOL)ly_replaceMethodForClass:(Class)forClass
               forInstanceMethod:(SEL)forInstanceMethod
                       fromClass:(Class)fromClass
              fromInstanceMethod:(SEL)fromInstanceMethod{
    Method replaceSel_Method = class_getInstanceMethod(fromClass, fromInstanceMethod);
    const char *replaceSel_Type = method_getTypeEncoding(replaceSel_Method);
    IMP resultSel = class_replaceMethod(forClass, forInstanceMethod, method_getImplementation(replaceSel_Method) , replaceSel_Type);
    return resultSel ? YES : NO;
}
// 用类方法替换某一对象的Instance方法的实现
+ (BOOL)ly_replaceMethodForClass:(Class)forClass
               forInstanceMethod:(SEL)forInstanceMethod
                       fromClass:(Class)fromClass
                 fromClassMethod:(SEL)fromClassMethod{
    Method replaceSel_Method = class_getClassMethod(fromClass, fromClassMethod);
    const char *replaceSel_Type = method_getTypeEncoding(replaceSel_Method);
    IMP resultSel = class_replaceMethod(forClass, forInstanceMethod, method_getImplementation(replaceSel_Method) , replaceSel_Type);
    return resultSel ? YES : NO;
}
// 交换两个对象的某一Instance方法
+ (void)ly_exchangeMethodFirstClass:(Class)firstClass
                firstInstanceMethod:(SEL)firstInstanceMethod
                        secondClass:(Class)secondClass
               secondInstanceMethod:(SEL)secondInstanceMethod{
    Method firstSel_Method = class_getInstanceMethod(firstClass, firstInstanceMethod);
    Method secondSel_Method = class_getInstanceMethod(secondClass, secondInstanceMethod);
    method_exchangeImplementations(firstSel_Method, secondSel_Method);
}
// 交换两个对象的某一class方法
+ (void)ly_exchangeMethodFirstClass:(Class)firstClass
                   firstClassMethod:(SEL)firstClassMethod
                        secondClass:(Class)secondClass
                  secondClassMethod:(SEL)secondClassMethod{
    Method firstSel_Method = class_getClassMethod(firstClass, firstClassMethod);
    Method secondSel_Method = class_getClassMethod(secondClass, secondClassMethod);
    method_exchangeImplementations(firstSel_Method, secondSel_Method);
}
// 交换第一个对象的类方法和第二个对象的实例方法
+ (void)ly_exchangeMethodFirstClass:(Class)firstClass
                   firstClassMethod:(SEL)firstClassMethod
                        secondClass:(Class)secondClass
               secondInstanceMethod:(SEL)secondInstanceMethod{
    Method classMethod = class_getClassMethod(firstClass, firstClassMethod);
    Method instanceMethod = class_getInstanceMethod(secondClass, secondInstanceMethod);
    method_exchangeImplementations(classMethod, instanceMethod);
}
// 给某一对象添加实例方法
+ (BOOL)ly_addMethodForClass:(Class)forClass
                   fromClass:(Class)fromClass
                 instanceSel:(SEL)instanceSel{
    IMP sel_IMP = class_getMethodImplementation(fromClass, instanceSel);
    Method sel_Method = class_getInstanceMethod(fromClass, instanceSel);
    const char *sel_Type = method_getTypeEncoding(sel_Method);
    BOOL result = class_addMethod(forClass, instanceSel, sel_IMP, sel_Type);
    return result;
}
// 给某一对象添加类方法
+ (BOOL)ly_addMethodForClass:(Class)forClass
                   fromClass:(Class)fromClass
                    classSel:(SEL)classSel{
    IMP sel_IMP = class_getMethodImplementation(fromClass, classSel);
    Method sel_Method = class_getClassMethod(fromClass, classSel);
    const char *sel_Type = method_getTypeEncoding(sel_Method);
    BOOL result = class_addMethod(forClass, classSel, sel_IMP, sel_Type);
    return result;
}
@end

#define LYActionDict @"LYActionDict"
@implementation LYKVOManager
// 添加观察者
+ (void)ly_addObserverToObject:(id)object forKeyPath:(NSString *)keyPath action:(void(^)(id oldValue,id newValue))action identifier:(NSString *)identifier{
    NSDictionary *dict = [LYRuntimeManager ly_associationPropertyName:LYActionDict toObject:object];
    dict = dict ? [NSMutableDictionary dictionaryWithDictionary:dict] : [NSMutableDictionary dictionary];
    if ([[dict allKeys] containsObject:keyPath]) {
        NSMutableDictionary *identifierDict = [NSMutableDictionary dictionaryWithDictionary:[dict objectForKey:keyPath]];
        [identifierDict setObject:action forKey:identifier];
        [(NSMutableDictionary *)dict setObject:identifierDict forKey:keyPath];
    }else{
        [(NSMutableDictionary *)dict setObject:@{identifier:action} forKey:keyPath];
        [LYRuntimeManager ly_addMethodForClass:[object class] fromClass:self instanceSel:@selector(observeValueForKeyPath:ofObject:change:context:)];
        [LYRuntimeManager ly_addMethodForClass:[object class] fromClass:self instanceSel:NSSelectorFromString(@"dealloc")];
        [object addObserver:object forKeyPath:keyPath options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:nil];
    }
    [LYRuntimeManager ly_associationPropertyName:LYActionDict value:dict toObject:object];
}
// 移除观察函数
+ (void)ly_removeObserverToObject:(id)object forKeyPath:(NSString *)keyPath identifier:(NSString *)identifier{
    NSDictionary *dict = [LYRuntimeManager ly_associationPropertyName:LYActionDict toObject:object];
    dict = dict ? [NSMutableDictionary dictionaryWithDictionary:dict] : [NSMutableDictionary dictionary];
    if ([[dict allKeys] containsObject:keyPath]) {
        NSMutableDictionary *identifierDict = [NSMutableDictionary dictionaryWithDictionary:[dict objectForKey:keyPath]];
        if ([[identifierDict allKeys] containsObject:identifier]) {
            [identifierDict removeObjectForKey:identifier];
            [(NSMutableDictionary *)dict setObject:identifierDict forKey:keyPath];
            [LYRuntimeManager ly_associationPropertyName:LYActionDict value:dict toObject:object];
        }
    }
}
// 观察者处理函数
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    NSDictionary *dict = [LYRuntimeManager ly_associationPropertyName:LYActionDict toObject:object];
    if (dict && [[dict allKeys] containsObject:keyPath]) {
        for (NSString *identifier in [dict objectForKey:keyPath]) {
            void(^action)(id oldValue,id newValue) = [dict objectForKey:keyPath][identifier];
            action(change[@"old"],change[@"new"]);
        }
    }
}
// 对象释放时,移除观察者
- (void)dealloc{
    NSDictionary *dict = [LYRuntimeManager ly_associationPropertyName:LYActionDict toObject:self];
    if (dict) {for (NSString *keyPath in dict) {[self removeObserver:self forKeyPath:keyPath];}}
    [LYRuntimeManager ly_removeAssociationPropertyToObject:self];
}
@end
@implementation LYGCDManager
// 获取系统串行队列
+ (dispatch_queue_t)ly_systemSerialQueue{
    return dispatch_get_main_queue();
}
// 获取系统并行队列
+ (dispatch_queue_t)ly_systemParallelQueue{
    return dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
}
// 获取自定义的串行队列
+ (dispatch_queue_t)ly_customSerialQueue{
    return dispatch_queue_create("GCD", DISPATCH_QUEUE_SERIAL);
}
// 获取自定义的并行队列
+ (dispatch_queue_t)ly_customParallelQueue{
    return dispatch_queue_create("GCD", DISPATCH_QUEUE_CONCURRENT);
}
// 在系统串行队列添加异步任务
+ (void)ly_addAsync_InSystemSerialQueue:(void(^)(void))action{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (action){ action(); }
    });
}
// 在系统并行队列添加异步任务
+ (void)ly_addAsync_InSystemParallelQueue:(void(^)(void))action{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        if (action){ action(); }
    });
}
// 在系统并行队列添加同步任务
+ (void)ly_addSync_InSystemParallelQueue:(void(^)(void))action{
    dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        if (action){ action(); }
    });
}
// 在自定义的串行队列添加异步任务
+ (void)ly_addAsync:(void(^)(void))action inCustomSerialQueue:(dispatch_queue_t)queue{
    dispatch_async(queue, ^{
        if (action){ action(); }
    });
}
// 在自定义的串行队列添加同步任务
+ (void)ly_addSync:(void(^)(void))action inCustomSerialQueue:(dispatch_queue_t)queue{
    dispatch_sync(queue, ^{
        if (action){ action(); }
    });
}
// 在自定义的并行队列添加异步任务
+ (void)ly_addAsync:(void(^)(void))action inCustomParallelQueue:(dispatch_queue_t)queue{
    dispatch_async(queue, ^{
        if (action){ action(); }
    });
}
// 在自定义的并行队列添加同步任务
+ (void)ly_addSync:(void(^)(void))action inCustomParallelQueue:(dispatch_queue_t)queue{
    dispatch_sync(queue, ^{
        if (action){ action(); }
    });
}
// 障碍任务
+ (void)ly_add_Barrier_Async:(void(^)(dispatch_queue_t queue))firstAction barrierAction:(void(^)(void))actionBarrier lastAction:(void(^)(void))completeAction{
    dispatch_queue_t queue = [self ly_customParallelQueue];
    if (firstAction){ firstAction(queue);}
    dispatch_barrier_async(queue, ^{
        if (actionBarrier){ actionBarrier();}
    });
    dispatch_async(queue, ^{
        if (completeAction){completeAction();}
    });
}
// 添加障碍任务
+ (void)ly_add_Barrier_AsyncAction:(void(^)(void))firstAction queue:(dispatch_queue_t)queue{
    [self ly_addAsync:firstAction inCustomParallelQueue:queue];
}
// 延迟任务
+ (void)ly_addAfter:(NSTimeInterval)interval action:(void(^)(void))action{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(interval * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (action){ action(); }
    });
}
// 重复任务
+ (void)ly_addRepeat:(NSInteger)num action:(void(^)(void))action{
    dispatch_apply(num, [self ly_systemParallelQueue], ^(size_t a) {
        if (action){ action(); }
    });
}
// 一次任务
+ (void)ly_addOnceAction:(void(^)(void))action{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (action){ action(); }
    });
}
// 等待任务
+ (void)ly_add_Group_AsyncAction:(void(^)(dispatch_group_t group,dispatch_queue_t queue))firstAction notifyAction:(void(^)(void))action{
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_queue_create("GCD", DISPATCH_QUEUE_CONCURRENT);
    if (firstAction){ firstAction(group,queue);}
    dispatch_group_notify(group, queue, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            if (action){ action(); }
        });
    });
}
// 添加等待任务
+ (void)ly_add_Group_AsyncAction:(void(^)(void))firstAction group:(dispatch_group_t)group queue:(dispatch_queue_t)queue{
    dispatch_group_async(group, queue, ^{
        if (firstAction) {
            firstAction();
        }
    });
}
@end

@implementation LYSTupleManager
+ (instancetype)create:(id)one two:(id)two{
    LYSTupleManager *tuple = [[LYSTupleManager alloc] init];
    tuple.one = one;
    tuple.two = two;
    return tuple;
}
@end
