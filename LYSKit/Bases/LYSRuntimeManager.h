//
//  LYSRuntimeManager.h
//  LYSKitDemo
//
//  Created by HENAN on 2017/12/5.
//  Copyright © 2017年 HENAN. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LYSRuntimeManager : NSObject

// Get the list of property properties of the object, which includes the attributes set in the extension of the incoming class
+ (NSArray *)getPropertyListForClass:(Class)className;

// The list of Method methods for getting objects
+ (NSArray *)getMethodListForClass:(Class)className;

// Get a list of Ivar member variables
+ (NSArray *)getIvarListForClass:(Class)className;

// Get a list of Protocol protocols
+ (NSArray *)getProtocolListForClass:(Class)className;

// Simply add Association attributes for an object
+ (void)associationPropertyName:(NSString *)name value:(id)value toObject:(id)object;

// Simply get the associated attributes of an object
+ (id)associationPropertyName:(NSString *)name toObject:(id)object;

// Remove all associated attributes of an object (cautiously! Once this method is called, the object's associated attributes are deleted)
+ (void)removeAssociationPropertyToObject:(id)object;

// Add associated objects
+ (void)setAssociationPropertyName:(NSString *)name value:(id)value toObject:(id)object;

// Monitoring the changing callback of associated objects
+ (void)setAssociationPropertyMonitorName:(NSString *)name monitorAction:(BOOL(^)(NSString *name,id oldValue,id newValue))action toObject:(id)object identifier:(NSString *)identifier;

// Getting the associated object value
+ (id)getAssociationPropertyName:(NSString *)name toObject:(id)object;

// Removing associated objects
+ (void)removeAllAssociationPropertyForObject:(id)object;

// Remove an associated attribute
+ (void)removeAssociationPropertyName:(NSString *)name toObject:(id)object;

// An association monitoring method to remove an associated attribute
+ (void)removeAssociationPropertyName:(NSString *)name identifier:(NSString *)identifier toObject:(id)object;

// Get the list of all associated objects of the object
+ (NSArray *)getAssociationPropertyListForObject:(id)object;

// An instance method is used to implement partial replacement or create instance method of the replaced object (the default instance object will be replaced, and the class object does not exist by default, then it will create an instance method that is the same as the replacement method name).
+ (BOOL)replaceMethodForClass:(Class)forClass forInstanceMethod:(SEL)forInstanceMethod fromClass:(Class)fromClass fromInstanceMethod:(SEL)fromInstanceMethod;

// A class method is used to implement partial replacement or create instance method of the replaced object (the default instance object will be replaced, and the class object does not exist by default, it will create an instance method that is the same as the replacement method name).
+ (BOOL)replaceMethodForClass:(Class)forClass forInstanceMethod:(SEL)forInstanceMethod fromClass:(Class)fromClass fromClassMethod:(SEL)fromClassMethod;

// A Instance method for exchanging two objects
+ (void)exchangeMethodFirstClass:(Class)firstClass firstInstanceMethod:(SEL)firstInstanceMethod secondClass:(Class)secondClass secondInstanceMethod:(SEL)secondInstanceMethod;

// A Class method for exchanging a certain object
+ (void)exchangeMethodFirstClass:(Class)firstClass firstClassMethod:(SEL)firstClassMethod secondClass:(Class)secondClass secondClassMethod:(SEL)secondClassMethod;

// The class method of exchanging the first object and the instance method of second objects
+ (void)exchangeMethodFirstClass:(Class)firstClass firstClassMethod:(SEL)firstClassMethod secondClass:(Class)secondClass secondInstanceMethod:(SEL)secondInstanceMethod;

// Add an instance to an object
// question 1: if an object to add another object inside the class, can be added successfully, but this object is no matter call or an instance call can call
// question 2: if an object to add another instance method object, can be added successfully, the object class call is unable to call, but can call the call instance
+ (BOOL)addMethodForClass:(Class)forClass fromClass:(Class)fromClass instanceSel:(SEL)instanceSel;

// Add class methods to an object
// question 1: if an object to add another object inside the class, can be added successfully, but this object is no matter call or an instance call can call
// question 2: if an object to add another instance method object, can be added successfully, the object class call is unable to call, but can call the call instance
+ (BOOL)addMethodForClass:(Class)forClass fromClass:(Class)fromClass classSel:(SEL)classSel;

// As a whole, the two methods, regardless of which one, can only add another object instance method for one object, and the instance call

@end
