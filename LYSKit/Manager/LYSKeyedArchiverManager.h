//
//  LYSKeyedArchiverManager.h
//  LYSKitDemo
//
//  Created by HENAN on 2017/12/5.
//  Copyright © 2017年 HENAN. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LYSKeyedArchiverManager : NSObject

// Adding a NSCoding protocol to a class
+ (void)addNSCodingProtocolForClass:(Class)objcClass;
@end
