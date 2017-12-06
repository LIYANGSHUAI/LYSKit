//
//  LYSKeyedArchiverManager.h
//  LYSKitDemo
//
//  Created by HENAN on 2017/12/5.
//  Copyright © 2017年 HENAN. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LYSKeyedArchiverManager : NSObject

/**
 给一个类添加NSCoding协议
 
 @param objcClass 需要被添加协议的类
 */
+ (void)ly_addNSCodingProtocolForClass:(Class)objcClass;
@end
