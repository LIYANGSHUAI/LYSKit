//
//  LYSRuntimeManager.h
//  LYSKitDemo
//
//  Created by HENAN on 2018/4/20.
//  Copyright © 2018年 liyangshuai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LYSRuntimeManager : NSObject

/**
 获取对象的property属性列表,其中包括传入类的扩展中设置的属性
 
 @param className                           要获取属性列表的对象的class
 @return                                    对象class的属性列表数组
 */
+ (NSArray *)ly_getPropertyListForClass:(Class)className;

/**
 获取对象的Method方法列表
 
 @param className                           要获取方法列表的对象的class
 @return                                    对象class的方法列表数组
 */
+ (NSArray *)ly_getMethodListForClass:(Class)className;

/**
 获取Ivar成员变量列表
 
 @param className                           要获取成员变量列表的对象的class
 @return                                    对象class的成员变量列表数组
 */
+ (NSArray *)ly_getIvarListForClass:(Class)className;

/**
 获取Protocol协议列表
 
 @param className                           要获取协议列表的对象的class
 @return                                    对象class的协议列表数组
 */
+ (NSArray *)ly_getProtocolListForClass:(Class)className;

/**
 简单的为一个对象添加关联属性
 
 @param name                                属性的名称
 @param value                               属性的值
 @param object                              所要关联的对象
 */
+ (void)ly_associationPropertyName:(NSString *)name value:(id)value toObject:(id)object;

/**
 简单的获取一个对象的关联属性
 
 @param name                                属性的名称
 @param object                              被关联的对象
 @return                                    关联属性的值
 */
+ (id)ly_associationPropertyName:(NSString *)name toObject:(id)object;

/**
 移除对象的所有关联属性(慎用!这个方法一旦调用,这个对象所以的关联属性都被删除)
 
 @param object                              需要被移除对象的关联属性
 */
+ (void)ly_removeAssociationPropertyToObject:(id)object;

/**
 添加关联对象(这个方法用于给关联对象设置可监控的属性时)
 
 @param name                                要添加的属性名称
 @param value                               要添加的属性的值
 @param object                              需要关联的对象
 */
+ (void)ly_setAssociationPropertyName:(NSString *)name value:(id)value toObject:(id)object;

/**
 监测关联对象属性变化回调
 
 @param name                                要监测的属性名
 @param action                              监测的事件
 @param object                              监测的对象
 @param identifier                          监测事件的唯一标识(如果两个事件的标识一样,则后者会替代前者,不能为nil,可用于监测事件的删除)
 */
+ (void)ly_setAssociationPropertyMonitorName:(NSString *)name monitorAction:(BOOL(^)(NSString *name,id oldValue,id newValue))action toObject:(id)object identifier:(NSString *)identifier;

/**
 获取关联对象值(这个方法用于获取可监控关联对象的属性)
 
 @param name                                获取关联对象的属性
 @param object                              要获取属性值的对象
 @return                                    返回关联属性值
 */
+ (id)ly_getAssociationPropertyName:(NSString *)name toObject:(id)object;

/**
 移除关联对象(这个方法用于可监控关联对象的属性的移除)
 
 @param object                              所要移除的关联属性的对象
 */
+ (void)ly_removeAllAssociationPropertyForObject:(id)object;

/**
 移除某一关联属性(这个方法用于可监控关联对象的属性的移除)
 
 @param name                                移除关联对象的属性
 @param object                              关联的对象
 */
+ (void)ly_removeAssociationPropertyName:(NSString *)name toObject:(id)object;

/**
 移除某一关联属性的关联监测方法(这个方法用于可监控关联对象的属性的移除)
 
 @param name                                要移除的关联对象的属性
 @param identifier                          要移除监测方法的唯一标识
 @param object                              关联的对象
 */
+ (void)ly_removeAssociationPropertyName:(NSString *)name identifier:(NSString *)identifier toObject:(id)object;

/**
 获取对象的所有关联对象列表(这个方法用于可监控关联对象的属性的移除)
 
 @param object                              要获取关联属性的对象
 @return                                    返回对象的所有关联对象列表
 */
+ (NSArray *)ly_getAssociationPropertyListForObject:(id)object;

/**
 用一个实例方法实现部分去替换或者创建被替换对象的实例方法(默认的实例对象才会被被替换,类对象默认是不存在的,就会去创建一个和被替换方法名一样的实例方法)
 
 @param forClass                            需要被替换方法的对象
 @param forInstanceMethod                   需要被替换的方法(只能替换实例方法)
 @param fromClass                           来替换的方法所在的对象
 @param fromInstanceMethod                  用来替换的方法
 @return                                    返回替换操作是否成功,YES为成功,NO方法不存在
 */
+ (BOOL)ly_replaceMethodForClass:(Class)forClass forInstanceMethod:(SEL)forInstanceMethod fromClass:(Class)fromClass fromInstanceMethod:(SEL)fromInstanceMethod;

/**
 用一个类方法实现部分去替换或者创建被替换对象的实例方法(默认的实例对象才会被被替换,类对象默认是不存在的,就会去创建一个和被替换方法名一样的实例方法)
 
 @param forClass                            需要被替换方法的对象
 @param forInstanceMethod                   需要被替换的方法(只能替换实例方法)
 @param fromClass                           用来替换的方法所在的对象
 @param fromClassMethod                     用来替换的方法
 @return                                    返回替换操作是否成功,YES为成功,NO方法不存在
 */
+ (BOOL)ly_replaceMethodForClass:(Class)forClass forInstanceMethod:(SEL)forInstanceMethod fromClass:(Class)fromClass fromClassMethod:(SEL)fromClassMethod;

/**
 交换两个对象的某一Instance方法
 
 @param firstClass                          需要被替换方法的对象
 @param firstInstanceMethod                 需要被交换的方法
 @param secondClass                         需要被替换方法的对象
 @param secondInstanceMethod                需要被交换的方法
 */
+ (void)ly_exchangeMethodFirstClass:(Class)firstClass firstInstanceMethod:(SEL)firstInstanceMethod secondClass:(Class)secondClass secondInstanceMethod:(SEL)secondInstanceMethod;

/**
 交换某一对象的某一Class方法
 
 @param firstClass                          需要被替换方法的对象
 @param firstClassMethod                    需要被交换的方法
 @param secondClass                         需要被替换方法的对象
 @param secondClassMethod                   需要被交换的方法
 */
+ (void)ly_exchangeMethodFirstClass:(Class)firstClass firstClassMethod:(SEL)firstClassMethod secondClass:(Class)secondClass secondClassMethod:(SEL)secondClassMethod;

/**
 交换第一个对象的类方法和第二个对象的实例方法
 
 @param firstClass                          需要被替换方法的对象
 @param firstClassMethod                    需要被交换的方法
 @param secondClass                         需要被替换方法的对象
 @param secondInstanceMethod                需要被交换的方法
 */
+ (void)ly_exchangeMethodFirstClass:(Class)firstClass firstClassMethod:(SEL)firstClassMethod secondClass:(Class)secondClass secondInstanceMethod:(SEL)secondInstanceMethod;

/**
 给某一对象添加实例方法
 
 // 问题1:如果给一个对象添加另外一个对象里面的类方法,是可以添加成功的,但是这个对象不管是类调用还是实例调用都无法调用
 // 问题2:如果给一个对象添加另外一个对象里面的实例方法,是可以添加成功的,这个对象类调用是无法调用的,但是实例调用确实可以调用的
 
 @param forClass                            需要添加方法的对象
 @param fromClass                           方法所在的对象
 @param instanceSel                         需要添加的方法
 @return                                    返回添加操作是否成功
 */
+ (BOOL)ly_addMethodForClass:(Class)forClass fromClass:(Class)fromClass instanceSel:(SEL)instanceSel;

/**
 给某一对象添加类方法
 
 // 问题1:如果给一个对象添加另外一个对象里面的类方法,是可以添加成功的,但是这个对象不管是类调用还是实例调用都无法调用
 // 问题2:如果给一个对象添加另外一个对象里面的实例方法,是可以添加成功的,这个对象类调用是无法调用的,但是实例调用确实可以调用的
 
 @param forClass                            需要添加方法的对象
 @param fromClass                           方法所在的对象
 @param classSel                            需要添加的方法
 @return                                    返回添加操作是否成功
 */
+ (BOOL)ly_addMethodForClass:(Class)forClass fromClass:(Class)fromClass classSel:(SEL)classSel;

// 总上所述:这两个方法无论使用哪一个,只能为一个对象添加另一个对象实例方法,并且实例调用

@end
