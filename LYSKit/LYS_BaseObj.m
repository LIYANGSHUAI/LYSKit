//
//  LYS_BaseObj.m
//  LYSKitDemo
//
//  Created by HENAN on 2017/11/9.
//  Copyright © 2017年 HENAN. All rights reserved.
//

#import "LYS_BaseObj.h"

@implementation LYSTupleManager

+ (instancetype)ly_create:(id)one two:(id)two
{
    LYSTupleManager *tuple = [[LYSTupleManager alloc] init];
    tuple.one = one;
    tuple.two = two;
    return tuple;
}

@end

#import <objc/runtime.h>
#define LYPropertyChangeActionDict @"AssociationProperty_with_MonitorAction"
#define LYPropertyDict @"AssociationProperty"

@implementation LYSRuntimeManager
#pragma mark - 获取对象的属性列表 -
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
#pragma mark - 获取对象的方法列表 -
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
#pragma mark - 获取成员变量列表 -
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
#pragma mark - 获取协议列表 -
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
#pragma mark - 简单的为一个对象添加关联属性 -
+ (void)ly_associationPropertyName:(NSString *)name
                             value:(id)value
                          toObject:(id)object
{
    objc_setAssociatedObject(object, (__bridge const void *)(name), value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark - 简单的获取一个对象的关联属性 -
+ (id)ly_associationPropertyName:(NSString *)name
                        toObject:(id)object
{
    return objc_getAssociatedObject(object, (__bridge const void *)(name));
}
#pragma mark - 移除对象的所有关联属性 -
+ (void)ly_removeAssociationPropertyToObject:(id)object
{
    objc_removeAssociatedObjects(object);
}
#pragma mark - 添加关联对象 -
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
#pragma mark - 监测关联对象变化回调 -
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
#pragma mark - 获取关联对象 -
+ (id)ly_getAssociationPropertyName:(NSString *)name
                           toObject:(id)object
{
    NSDictionary *dict = objc_getAssociatedObject(object, LYPropertyDict);
    if (!dict) {return nil;}
    if (![[dict allKeys] containsObject:name]) {return nil;}
    return [dict objectForKey:name];
}
#pragma mark - 移除关联对象 -
+ (void)ly_removeAllAssociationPropertyForObject:(id)object
{
    objc_setAssociatedObject(object, LYPropertyDict, @{}, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(object, LYPropertyChangeActionDict, @{}, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark - 移除某一关联属性 -
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
#pragma mark - 移除某一关联属性的关联监测方法 -
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
#pragma mark - 获取对象的所有关联对象列表 -
+ (NSArray *)ly_getAssociationPropertyListForObject:(id)object
{
    NSDictionary *dict = objc_getAssociatedObject(object, LYPropertyDict);
    return dict ? [dict allKeys] : nil;
}
#pragma mark - 用实例方法替换某一对象的Instance方法的实现 -
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
#pragma mark - 用类方法替换某一对象的Instance方法的实现 -
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
#pragma mark - 交换两个对象的某一Instance方法 -
+ (void)ly_exchangeMethodFirstClass:(Class)firstClass
                firstInstanceMethod:(SEL)firstInstanceMethod
                        secondClass:(Class)secondClass
               secondInstanceMethod:(SEL)secondInstanceMethod
{
    Method firstSel_Method = class_getInstanceMethod(firstClass, firstInstanceMethod);
    Method secondSel_Method = class_getInstanceMethod(secondClass, secondInstanceMethod);
    method_exchangeImplementations(firstSel_Method, secondSel_Method);
}
#pragma mark - 交换两个对象的某一class方法 -
+ (void)ly_exchangeMethodFirstClass:(Class)firstClass
                   firstClassMethod:(SEL)firstClassMethod
                        secondClass:(Class)secondClass
                  secondClassMethod:(SEL)secondClassMethod
{
    Method firstSel_Method = class_getClassMethod(firstClass, firstClassMethod);
    Method secondSel_Method = class_getClassMethod(secondClass, secondClassMethod);
    method_exchangeImplementations(firstSel_Method, secondSel_Method);
}
#pragma mark - 交换第一个对象的类方法和第二个对象的实例方法 -
+ (void)ly_exchangeMethodFirstClass:(Class)firstClass
                   firstClassMethod:(SEL)firstClassMethod
                        secondClass:(Class)secondClass
               secondInstanceMethod:(SEL)secondInstanceMethod
{
    Method classMethod = class_getClassMethod(firstClass, firstClassMethod);
    Method instanceMethod = class_getInstanceMethod(secondClass, secondInstanceMethod);
    method_exchangeImplementations(classMethod, instanceMethod);
}
#pragma mark - 给某一对象添加实例方法 -
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
#pragma mark - 给某一对象添加类方法 -
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

@implementation LYSGCDManager

// 获取系统串行队列
+ (dispatch_queue_t)ly_systemSerialQueue
{
    return dispatch_get_main_queue();
}

// 获取系统并行队列
+ (dispatch_queue_t)ly_systemParallelQueue
{
    return dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
}

// 获取自定义的串行队列
+ (dispatch_queue_t)ly_createSerialQueue
{
    return dispatch_queue_create("GCD", DISPATCH_QUEUE_SERIAL);
}

// 获取自定义的并行队列
+ (dispatch_queue_t)ly_createParallelQueue
{
    return dispatch_queue_create("GCD", DISPATCH_QUEUE_CONCURRENT);
}

// 在系统串行队列添加异步任务
+ (void)ly_addAsync_InSystemSerialQueue:(LYSGCDAction)action
{
    dispatch_async([self ly_systemSerialQueue], ^{if (action){ action(); }});
}

// 在系统并行队列添加异步任务
+ (void)ly_addAsync_InSystemParallelQueue:(LYSGCDAction)action
{
    dispatch_async([self ly_systemParallelQueue], ^{if (action){ action();}});
}

// 在系统并行队列添加同步任务
+ (void)ly_addSync_InSystemParallelQueue:(LYSGCDAction)action
{
    dispatch_sync([self ly_systemParallelQueue], ^{if (action){ action();}});
}

// 在自定义的串行队列添加异步任务
+ (void)ly_addAsync:(LYSGCDAction)action queue:(dispatch_queue_t)queue
{
    dispatch_async(queue, ^{if (action){ action();}});
}

// 在自定义的串行队列添加同步任务
+ (void)ly_addSync:(LYSGCDAction)action queue:(dispatch_queue_t)queue
{
    dispatch_sync(queue, ^{if (action){ action();}});
}

// 障碍任务
+ (void)ly_add_Barrier_Async:(LYSGCDActionQueue)firstAction
               barrierAction:(LYSGCDAction)actionBarrier
                  lastAction:(LYSGCDAction)completeAction
{
    dispatch_queue_t queue = [self ly_createParallelQueue];
    if (firstAction){ firstAction(queue);}
    dispatch_barrier_async(queue, ^{
        if (actionBarrier){ actionBarrier();}
    });
    dispatch_async(queue, ^{
        if (completeAction){completeAction();}
    });
}

// 添加障碍任务
+ (void)ly_add_Barrier_AsyncAction:(LYSGCDAction)firstAction queue:(dispatch_queue_t)queue
{
    [self ly_addAsync:firstAction queue:queue];
}

// 延迟任务
+ (void)ly_addAfter:(NSTimeInterval)interval action:(LYSGCDAction)action
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(interval * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (action){ action(); }
    });
}

// 重复任务
+ (void)ly_addRepeat:(NSInteger)num action:(LYSGCDAction)action
{
    dispatch_apply(num, [self ly_systemParallelQueue], ^(size_t a) {if (action){ action(); }});
}

// 一次任务
+ (void)ly_addOnceAction:(LYSGCDAction)action{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (action){ action(); }
    });
}

// 等待任务
+ (void)ly_add_Group_AsyncAction:(void(^)(dispatch_group_t group,dispatch_queue_t queue))firstAction notifyAction:(LYSGCDAction)action
{
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
+ (void)ly_add_Group_AsyncAction:(LYSGCDAction)firstAction group:(dispatch_group_t)group queue:(dispatch_queue_t)queue
{
    dispatch_group_async(group, queue, ^{
        if (firstAction) {
            firstAction();
        }
    });
}

@end

#define LYActionDict @"LYActionDict"

@implementation LYSKVOManager

#pragma mark - 添加观察者 -
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
#pragma mark - 移除观察函数 -
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

@implementation LYSKeyedArchiverManager
// 给一个类添加NSCoding协议
+ (void)ly_addNSCodingProtocolForClass:(Class)objcClass
{
    class_addProtocol(objcClass, @protocol(NSCoding));
    [self ly_addMethod:@selector(encodeWithCoder:) toTarget:objcClass];
    [self ly_addMethod:@selector(initWithCoder:) toTarget:objcClass];
}
// 实现NSCoding协议
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [[LYSRuntimeManager ly_getPropertyListForClass:[self class]] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [aCoder encodeObject:[self valueForKey:obj] forKey:(NSString *)obj];
    }];
}
// 实现NSCoding协议
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        [[LYSRuntimeManager ly_getPropertyListForClass:[self class]] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [self setValue:[aDecoder decodeObjectForKey:obj] forKey:obj];
        }];
    }
    return self;
}
// 给某一类动态添加方法
+ (void)ly_addMethod:(SEL)sel toTarget:(id)object
{
    IMP sel_IMP = class_getMethodImplementation([self class], sel);
    Method sel_Method = class_getInstanceMethod([self class], sel);
    const char *sel_Type = method_getTypeEncoding(sel_Method);
    class_addMethod([object class], sel, sel_IMP, sel_Type);
}
@end

@implementation LYSandboxManager
// 获取沙盒路径
+ (NSString *)ly_sandboxPathForHomeDirectory{
    return NSHomeDirectory();
}
// 获取沙盒Documents路径
+ (NSString *)ly_sandboxPathForDocument{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}
// 获取沙盒Library
+ (NSString *)ly_sandboxPathForLibrary{
    return [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
}
// 获取沙盒Caches路径
+ (NSString *)ly_sandboxPathForCaches{
    return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
}
// 拼接路径(以"/"拼接)
+ (NSString *)ly_jointPathComponent:(NSString *)filePathA path:(NSString *)filePathB{
    return [filePathA stringByAppendingPathComponent:filePathB];
}
// 拼接路径(以"."拼接)
+ (NSString *)ly_jointPathExtension:(NSString *)filePathA path:(NSString *)filePathB{
    return [filePathA stringByAppendingPathExtension:filePathB];
}
// 创建文件夹
+ (BOOL)ly_createDirectoryFile:(NSString *)filePath{
    NSFileManager *manager = [NSFileManager defaultManager];
    return [manager createDirectoryAtPath:filePath withIntermediateDirectories:YES attributes:nil error:nil];
}
// 创建文件
+ (BOOL)ly_createFile:(NSString *)filePath fileContent:(NSData *)fileData;{
    NSFileManager *manager = [NSFileManager defaultManager];
    return [manager createFileAtPath:filePath contents:fileData attributes:nil];
}
// 移除文件
+ (BOOL)ly_removeFilePath:(NSString *)filePath{
    if (![self ly_isExistAtPath:filePath]) { return NO;}
    NSFileManager *manager = [NSFileManager defaultManager];
    return [manager removeItemAtPath:filePath error:nil];
}
// 移动文件
+ (BOOL)ly_moveFilePath:(NSString *)filePathA toFilePath:(NSString *)filePathB{
    if (![self ly_isExistAtPath:filePathA]) { return NO;}
    NSFileManager *manager = [NSFileManager defaultManager];
    return [manager moveItemAtPath:filePathA toPath:filePathB error:nil];
}
// 赋值文件
+ (BOOL)ly_copyFilePath:(NSString *)fielPathA toFilePath:(NSString *)filePathB{
    if (![self ly_isExistAtPath:fielPathA]) { return NO;}
    NSFileManager *manager = [NSFileManager defaultManager];
    return [manager copyItemAtPath:fielPathA toPath:filePathB error:nil];
}
// 判断是否存在
+ (BOOL)ly_isExistAtPath:(NSString *)filePath{
    NSFileManager *manager = [NSFileManager defaultManager];
    return [manager fileExistsAtPath:filePath];
}
// 获取文件属性
+ (NSDictionary *)ly_attributesForFilePath:(NSString *)filePath{
    if (![self ly_isExistAtPath:filePath]) { return nil;}
    NSFileManager *manager = [NSFileManager defaultManager];
    return [manager attributesOfItemAtPath:filePath error:nil];
}
// 获取文件大小
+ (NSString *)ly_fileSizeForFilePath:(NSString *)filePath{
    if (![self ly_isExistAtPath:filePath]) { return @"文件不存在";}
    return [NSString stringWithFormat:@"%.2fKB",[self ly_attributesForFilePath:filePath].fileSize / 1024.0];
}
// 获取文件时间
+ (NSString *)ly_fileCreateDateForFilePath:(NSString *)filePath{
    if (![self ly_isExistAtPath:filePath]) { return @"文件不存在";}
    return [NSString stringWithFormat:@"%@",[self ly_attributesForFilePath:filePath].fileCreationDate];
}
// 对文件进行写入操作
+ (BOOL)ly_writeToFilePath:(NSString *)filePath fileData:(NSData *)fileData{
    if (![self ly_isExistAtPath:filePath]) { return NO;}
    NSFileHandle *handle = [NSFileHandle fileHandleForWritingAtPath:filePath];
    [handle seekToEndOfFile];
    [handle writeData:fileData];
    [handle closeFile];
    return YES;
}
// 对文件进行读操作
+ (NSData *)ly_readFilePath:(NSString *)filePath{
    if (![self ly_isExistAtPath:filePath]) { return nil;}
    NSFileHandle *handle = [NSFileHandle fileHandleForReadingAtPath:filePath];
    [handle seekToFileOffset:0];
    NSData *data = [handle readDataToEndOfFile];
    [handle closeFile];
    return data;
}
// 归档文件
+ (NSData *)ly_keyedArchiver:(id<NSCopying>)obj keyPath:(NSString *)keyPath{
    NSMutableData *mData = [NSMutableData data];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:mData];
    [archiver encodeObject:obj forKey:keyPath];
    [archiver finishEncoding];
    return mData;
}
// 反归档文件
+ (id<NSCopying>)ly_keyedUnarchiverData:(NSData *)mData keyPath:(NSString *)keyPath{
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:mData];
    id<NSCopying> obj = [unarchiver decodeObjectForKey:keyPath];
    [unarchiver finishDecoding];
    return obj;
}
@end

