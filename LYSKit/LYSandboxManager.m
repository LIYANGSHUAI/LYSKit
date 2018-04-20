//
//  LYSandboxManager.m
//  LYSKitDemo
//
//  Created by HENAN on 2018/4/20.
//  Copyright © 2018年 liyangshuai. All rights reserved.
//

#import "LYSandboxManager.h"

@implementation LYSandboxManager
+ (NSString *)ly_sandboxPathForHomeDirectory{
    return NSHomeDirectory();
}

+ (NSString *)ly_sandboxPathForDocument{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

+ (NSString *)ly_sandboxPathForLibrary{
    return [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
}

+ (NSString *)ly_sandboxPathForCaches{
    return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
}

+ (NSString *)ly_jointPathComponent:(NSString *)filePathA path:(NSString *)filePathB{
    return [filePathA stringByAppendingPathComponent:filePathB];
}

+ (NSString *)ly_jointPathExtension:(NSString *)filePathA path:(NSString *)filePathB{
    return [filePathA stringByAppendingPathExtension:filePathB];
}

+ (BOOL)ly_createDirectoryFile:(NSString *)filePath{
    NSFileManager *manager = [NSFileManager defaultManager];
    return [manager createDirectoryAtPath:filePath withIntermediateDirectories:YES attributes:nil error:nil];
}

+ (BOOL)ly_createFile:(NSString *)filePath fileContent:(NSData *)fileData;{
    NSFileManager *manager = [NSFileManager defaultManager];
    return [manager createFileAtPath:filePath contents:fileData attributes:nil];
}

+ (BOOL)ly_removeFilePath:(NSString *)filePath{
    if (![self ly_isExistAtPath:filePath]) { return NO;}
    NSFileManager *manager = [NSFileManager defaultManager];
    return [manager removeItemAtPath:filePath error:nil];
}

+ (BOOL)ly_moveFilePath:(NSString *)filePathA toFilePath:(NSString *)filePathB{
    if (![self ly_isExistAtPath:filePathA]) { return NO;}
    NSFileManager *manager = [NSFileManager defaultManager];
    return [manager moveItemAtPath:filePathA toPath:filePathB error:nil];
}

+ (BOOL)ly_copyFilePath:(NSString *)fielPathA toFilePath:(NSString *)filePathB{
    if (![self ly_isExistAtPath:fielPathA]) { return NO;}
    NSFileManager *manager = [NSFileManager defaultManager];
    return [manager copyItemAtPath:fielPathA toPath:filePathB error:nil];
}

+ (BOOL)ly_isExistAtPath:(NSString *)filePath{
    NSFileManager *manager = [NSFileManager defaultManager];
    return [manager fileExistsAtPath:filePath];
}

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

+ (NSString *)ly_fileCreateDateForFilePath:(NSString *)filePath{
    if (![self ly_isExistAtPath:filePath]) { return @"文件不存在";}
    return [NSString stringWithFormat:@"%@",[self ly_attributesForFilePath:filePath].fileCreationDate];
}

+ (BOOL)ly_writeToFilePath:(NSString *)filePath fileData:(NSData *)fileData{
    if (![self ly_isExistAtPath:filePath]) { return NO;}
    NSFileHandle *handle = [NSFileHandle fileHandleForWritingAtPath:filePath];
    [handle seekToEndOfFile];
    [handle writeData:fileData];
    [handle closeFile];
    return YES;
}

+ (NSData *)ly_readFilePath:(NSString *)filePath{
    if (![self ly_isExistAtPath:filePath]) { return nil;}
    NSFileHandle *handle = [NSFileHandle fileHandleForReadingAtPath:filePath];
    [handle seekToFileOffset:0];
    NSData *data = [handle readDataToEndOfFile];
    [handle closeFile];
    return data;
}

+ (NSData *)ly_keyedArchiver:(id<NSCopying>)obj keyPath:(NSString *)keyPath{
    NSMutableData *mData = [NSMutableData data];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:mData];
    [archiver encodeObject:obj forKey:keyPath];
    [archiver finishEncoding];
    return mData;
}

+ (id<NSCopying>)ly_keyedUnarchiverData:(NSData *)mData keyPath:(NSString *)keyPath{
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:mData];
    id<NSCopying> obj = [unarchiver decodeObjectForKey:keyPath];
    [unarchiver finishDecoding];
    return obj;
}
@end
