//
//  LYSKeyedArchiverManager.m
//  LYSKitDemo
//
//  Created by HENAN on 2017/12/5.
//  Copyright © 2017年 HENAN. All rights reserved.
//

#import "LYSKeyedArchiverManager.h"
#import <objc/runtime.h>
@implementation LYSKeyedArchiverManager
// 给一个类添加NSCoding协议
+ (void)addNSCodingProtocolForClass:(Class)objcClass
{
    class_addProtocol(objcClass, @protocol(NSCoding));
    [self addMethod:@selector(encodeWithCoder:) toTarget:objcClass];
    [self addMethod:@selector(initWithCoder:) toTarget:objcClass];
}
// 实现NSCoding协议
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [[self getPropertyListForClass:[self class]] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [aCoder encodeObject:[self valueForKey:obj] forKey:(NSString *)obj];
    }];
}
// 实现NSCoding协议
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        [[self getPropertyListForClass:[self class]] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [self setValue:[aDecoder decodeObjectForKey:obj] forKey:obj];
        }];
    }
    return self;
}
// 给某一类动态添加方法
+ (void)addMethod:(SEL)sel toTarget:(id)object
{
    IMP sel_IMP = class_getMethodImplementation([self class], sel);
    Method sel_Method = class_getInstanceMethod([self class], sel);
    const char *sel_Type = method_getTypeEncoding(sel_Method);
    class_addMethod([object class], sel, sel_IMP, sel_Type);
}
- (NSArray *)getPropertyListForClass:(Class)className
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
@end
