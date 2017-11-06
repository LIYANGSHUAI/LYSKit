//
//  LYS_BaseObjc.h
//  LYSKit
//
//  Created by HENAN on 2017/9/22.
//  Copyright © 2017年 个人开发实用框架. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LYRuntimeManager : NSObject
/**
 获取对象的属性列表

 @param className 要获取属性列表的对象的class
 @return 对象class的属性列表数组
 */
+ (NSArray *)ly_getPropertyListForClass:(Class)className;
/**
 获取对象的方法列表

 @param className 要获取方法列表的对象的class
 @return 对象class的方法列表数组
 */
+ (NSArray *)ly_getMethodListForClass:(Class)className;
/**
 获取成员变量列表

 @param className 要获取成员变量列表的对象的class
 @return 对象class的成员变量列表数组
 */
+ (NSArray *)ly_getIvarListForClass:(Class)className;
/**
 获取协议列表

 @param className 要获取协议列表的对象的class
 @return 对象class的协议列表数组
 */
+ (NSArray *)ly_getProtocolListForClass:(Class)className;
/**
 简单的为一个对象添加关联属性

 @param name 属性的名称
 @param value 属性的值
 @param object 所要关联的对象
 */
+ (void)ly_associationPropertyName:(NSString *)name
                             value:(id)value
                          toObject:(id)object;
/**
 简单的获取一个对象的关联属性

 @param name 属性的名称
 @param object 被关联的对象
 @return 关联属性的值
 */
+ (id)ly_associationPropertyName:(NSString *)name
                        toObject:(id)object;
/**
 移除对象的所有关联属性(慎用!这个方法一旦调用,这个对象所以的关联属性都被删除)

 @param object 需要被移除对象的关联属性
 */
+ (void)ly_removeAssociationPropertyToObject:(id)object;
/**
 添加关联对象

 @param name 要添加的属性名称
 @param value 要添加的属性的值
 @param object 需要关联的对象
 */
+ (void)ly_setAssociationPropertyName:(NSString *)name
                                value:(id)value
                             toObject:(id)object;
/**
 监测关联对象变化回调

 @param name 要监测的属性名
 @param action 监测的事件
 @param object 监测的对象
 @param identifier 监测事件的唯一标识(如果两个事件的标识一样,则后者会替代前者,不能为nil,可用于监测事件的删除)
 */
+ (void)ly_setAssociationPropertyMonitorName:(NSString *)name
                               monitorAction:(BOOL(^)(NSString *name,id oldValue,id newValue))action
                                    toObject:(id)object
                                  identifier:(NSString *)identifier;
/**
 获取关联对象值

 @param name 获取关联对象的属性
 @param object 要获取属性值的对象
 @return 返回关联属性值
 */
+ (id)ly_getAssociationPropertyName:(NSString *)name
                           toObject:(id)object;
/**
 移除关联对象

 @param object 所要移除的关联属性的对象
 */
+ (void)ly_removeAllAssociationPropertyForObject:(id)object;
/**
 移除某一关联属性

 @param name 移除关联对象的属性
 @param object 关联的对象
 */
+ (void)ly_removeAssociationPropertyName:(NSString *)name
                                toObject:(id)object;
/**
 移除某一关联属性的关联监测方法

 @param name 要移除的关联对象的属性
 @param identifier 要移除监测方法的唯一标识
 @param object 关联的对象
 */
+ (void)ly_removeAssociationPropertyName:(NSString *)name
                              identifier:(NSString *)identifier
                                toObject:(id)object;
/**
 获取对象的所有关联对象列表

 @param object 要获取关联属性的对象
 @return 返回对象的所有关联对象列表
 */
+ (NSArray *)ly_getAssociationPropertyListForObject:(id)object;
/**
 用一个实例方法实现部分去替换或者创建被替换对象的实例方法(默认的实例对象才会被被替换,类对象默认是不存在的,就会去创建一个和被替换方法名一样的实例方法)

 @param forClass 需要被替换方法的对象
 @param forInstanceMethod 需要被替换的方法(只能替换实例方法)
 @param fromClass 来替换的方法所在的对象
 @param fromInstanceMethod 用来替换的方法
 @return 返回替换操作是否成功,YES为成功,NO方法不存在
 */
+ (BOOL)ly_replaceMethodForClass:(Class)forClass
               forInstanceMethod:(SEL)forInstanceMethod
                       fromClass:(Class)fromClass
              fromInstanceMethod:(SEL)fromInstanceMethod;
/**
 用一个类方法实现部分去替换或者创建被替换对象的实例方法(默认的实例对象才会被被替换,类对象默认是不存在的,就会去创建一个和被替换方法名一样的实例方法)

 @param forClass 需要被替换方法的对象
 @param forInstanceMethod 需要被替换的方法(只能替换实例方法)
 @param fromClass 用来替换的方法所在的对象
 @param fromClassMethod 用来替换的方法
 @return 返回替换操作是否成功,YES为成功,NO方法不存在
 */
+ (BOOL)ly_replaceMethodForClass:(Class)forClass
               forInstanceMethod:(SEL)forInstanceMethod
                       fromClass:(Class)fromClass
                 fromClassMethod:(SEL)fromClassMethod;
/**
 交换两个对象的某一Instance方法

 @param firstClass 需要被替换方法的对象
 @param firstInstanceMethod 需要被交换的方法
 @param secondClass 需要被替换方法的对象
 @param secondInstanceMethod 需要被交换的方法
 */
+ (void)ly_exchangeMethodFirstClass:(Class)firstClass
                firstInstanceMethod:(SEL)firstInstanceMethod
                        secondClass:(Class)secondClass
               secondInstanceMethod:(SEL)secondInstanceMethod;
/**
 交换某一对象的某一Class方法

 @param firstClass 需要被替换方法的对象
 @param firstClassMethod 需要被交换的方法
 @param secondClass 需要被替换方法的对象
 @param secondClassMethod 需要被交换的方法
 */
+ (void)ly_exchangeMethodFirstClass:(Class)firstClass
                   firstClassMethod:(SEL)firstClassMethod
                        secondClass:(Class)secondClass
                  secondClassMethod:(SEL)secondClassMethod;
/**
 交换第一个对象的类方法和第二个对象的实例方法

 @param firstClass 需要被替换方法的对象
 @param firstClassMethod 需要被交换的方法
 @param secondClass 需要被替换方法的对象
 @param secondInstanceMethod 需要被交换的方法
 */
+ (void)ly_exchangeMethodFirstClass:(Class)firstClass
                   firstClassMethod:(SEL)firstClassMethod
                        secondClass:(Class)secondClass
               secondInstanceMethod:(SEL)secondInstanceMethod;
/**
 给某一对象添加实例方法

 // 问题1:如果给一个对象添加另外一个对象里面的类方法,是可以添加成功的,但是这个对象不管是类调用还是实例调用都无法调用
 // 问题2:如果给一个对象添加另外一个对象里面的实例方法,是可以添加成功的,这个对象类调用是无法调用的,但是实例调用确实可以调用的
 
 @param forClass 需要添加方法的对象
 @param fromClass 方法所在的对象
 @param instanceSel 需要添加的方法
 @return 返回添加操作是否成功
 */
+ (BOOL)ly_addMethodForClass:(Class)forClass
                   fromClass:(Class)fromClass
                 instanceSel:(SEL)instanceSel;
/**
 给某一对象添加类方法

 // 问题1:如果给一个对象添加另外一个对象里面的类方法,是可以添加成功的,但是这个对象不管是类调用还是实例调用都无法调用
 // 问题2:如果给一个对象添加另外一个对象里面的实例方法,是可以添加成功的,这个对象类调用是无法调用的,但是实例调用确实可以调用的
 
 @param forClass 需要添加方法的对象
 @param fromClass 方法所在的对象
 @param classSel 需要添加的方法
 @return 返回添加操作是否成功
 */
+ (BOOL)ly_addMethodForClass:(Class)forClass
                   fromClass:(Class)fromClass
                    classSel:(SEL)classSel;
// 总上所述:这两个方法无论使用哪一个,只能为一个对象添加另一个对象实例方法,并且实例调用
@end


@interface LYKVOManager : NSObject
/**
 添加观察者

 @param object 需要被观察的对象
 @param keyPath 需要被观察的属性
 @param action 观察属性监测事件
 @param identifier 观察属性的标识(可用于移除)
 */
+ (void)ly_addObserverToObject:(id)object forKeyPath:(NSString *)keyPath action:(void(^)(id oldValue,id newValue))action identifier:(NSString *)identifier;
/**
 移除观察函数

 @param object 被观察的对象
 @param keyPath 被观察的属性
 @param identifier 监测事件的标识
 */
+ (void)ly_removeObserverToObject:(id)object forKeyPath:(NSString *)keyPath identifier:(NSString *)identifier;
@end

@interface LYGCDManager : NSObject
/*
 *-------------------------------------------------------------------------|
 *         |              串行队列             |         并行队列             |
 *-------------------------------------------------------------------------|
 *         | 主队列         | 自定义串行队列     |  全局队列 | 自定义全局队列     |
 *-------------------------------------------------------------------------|
 * 同步任务 | 线程死锁       | 在主线程顺序完成    | 在主线程顺序完成|在主线程顺序完成|
 *-------------------------------------------------------------------------|
 * 异步任务 |主线程中顺序完成 | 在子线程顺序完成    | 在子线程乱序完成|在子线程乱序完成|
 *-------------------------------------------------------------------------|
 */

/**
 获取系统串行队列

 @return 返回系统串行队列
 */
+ (dispatch_queue_t)ly_systemSerialQueue;

/**
 获取系统并行队列

 @return 返回系统并行队列
 */
+ (dispatch_queue_t)ly_systemParallelQueue;

/**
 获取自定义的串行队列

 @return 返回自定义的串行队列
 */
+ (dispatch_queue_t)ly_customSerialQueue;

/**
 获取自定义的并行队列

 @return 返回自定义的并行队列
 */
+ (dispatch_queue_t)ly_customParallelQueue;

/**
 在系统串行队列添加异步任务

 @param action 异步任务
 */
+ (void)ly_addAsync_InSystemSerialQueue:(void(^)(void))action;

/**
 在系统并行队列添加异步任务

 @param action 添加的异步任务
 */
+ (void)ly_addAsync_InSystemParallelQueue:(void(^)(void))action;

/**
 在系统并行队列添加同步任务

 @param action 添加的同步任务
 */
+ (void)ly_addSync_InSystemParallelQueue:(void(^)(void))action;

/**
 在自定义的并行队列添加异步任务

 @param action 添加的异步任务
 @param queue 自定义的串行队列
 */
+ (void)ly_addAsync:(void(^)(void))action inCustomSerialQueue:(dispatch_queue_t)queue;

/**
 在自定义的并行队列添加同步任务

 @param action 添加的同步任务
 @param queue 自定义的串行队列
 */
+ (void)ly_addSync:(void(^)(void))action inCustomSerialQueue:(dispatch_queue_t)queue;

/**
 在自定义的并行队列添加异步任务

 @param action 添加的异步任务
 @param queue 自定义的全局队列
 */
+ (void)ly_addAsync:(void(^)(void))action inCustomParallelQueue:(dispatch_queue_t)queue;

/**
 在自定义的并行队列添加同步任务

 @param action 添加的同步任务
 @param queue 自定义的全局队列
 */
+ (void)ly_addSync:(void(^)(void))action inCustomParallelQueue:(dispatch_queue_t)queue;

/**
 障碍任务

 @param firstAction 先完成的任务,ly_add_Barrier_AsyncAction: queue:调用此方法进行添加
 @param actionBarrier 障碍任务
 @param completeAction 最后完成的任务
 */
+ (void)ly_add_Barrier_Async:(void(^)(dispatch_queue_t queue))firstAction barrierAction:(void(^)(void))actionBarrier lastAction:(void(^)(void))completeAction;

/**
 添加障碍任务,配合上面的方法

 @param firstAction 任务
 @param queue 队列
 */
+ (void)ly_add_Barrier_AsyncAction:(void(^)(void))firstAction queue:(dispatch_queue_t)queue;

/**
 延迟任务

 @param interval 延迟的时间
 @param action 延迟事件
 */
+ (void)ly_addAfter:(NSTimeInterval)interval action:(void(^)(void))action;

/**
 重复任务

 @param num 重复的次数
 @param action 重复的事件
 */
+ (void)ly_addRepeat:(NSInteger)num action:(void(^)(void))action;

/**
 一次任务

 @param action 执行的任务
 */
+ (void)ly_addOnceAction:(void(^)(void))action;

/**
 等待任务ly_add_Group_AsyncAction: group: queue:调用此方法进行添加

 @param firstAction 先执行的任务
 @param action 其他任务完成后执行的任务
 */
+ (void)ly_add_Group_AsyncAction:(void(^)(dispatch_group_t group,dispatch_queue_t queue))firstAction notifyAction:(void(^)(void))action;

/**
 添加等待任务,配合上面方法

 @param firstAction 任务体
 */
+ (void)ly_add_Group_AsyncAction:(void(^)(void))firstAction group:(dispatch_group_t)group queue:(dispatch_queue_t)queue;
@end

@interface LYSTupleManager : NSObject
// 对象一
@property (nonatomic,strong)id one;
// 对象二
@property (nonatomic,strong)id two;
// 创建方法
+ (instancetype)create:(id)one two:(id)two;
@end
typedef LYSTupleManager* LYSTuple;

