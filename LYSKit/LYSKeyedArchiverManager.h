//
//  LYSKeyedArchiverManager.h
//  LYSKitDemo
//
//  Created by HENAN on 2018/4/20.
//  Copyright © 2018年 liyangshuai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LYSKeyedArchiverManager : NSObject

/**
 给一个类添加NSCoding协议
 
 @param objcClass                           需要被添加协议的类
 */
+ (void)ly_addNSCodingProtocolForClass:(Class)objcClass;
@end
