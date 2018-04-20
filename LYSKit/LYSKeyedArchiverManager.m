//
//  LYSKeyedArchiverManager.m
//  LYSKitDemo
//
//  Created by HENAN on 2018/4/20.
//  Copyright © 2018年 liyangshuai. All rights reserved.
//

#import "LYSKeyedArchiverManager.h"
#import <objc/runtime.h>
#import "LYSRuntimeManager.h"
@implementation LYSKeyedArchiverManager
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
