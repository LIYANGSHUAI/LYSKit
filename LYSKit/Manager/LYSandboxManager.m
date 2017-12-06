//
//  LYSandboxManager.m
//  LYSKitDemo
//
//  Created by HENAN on 2017/12/5.
//  Copyright © 2017年 HENAN. All rights reserved.
//

#import "LYSandboxManager.h"

@implementation LYSandboxManager
// 获取沙盒路径
+ (NSString *)sandboxPathForHomeDirectory
{
    return NSHomeDirectory();
}
// 获取沙盒Documents路径
+ (NSString *)sandboxPathForDocument
{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}
// 获取沙盒Library
+ (NSString *)sandboxPathForLibrary
{
    return [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
}
// 获取沙盒Caches路径
+ (NSString *)sandboxPathForCaches
{
    return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
}
// 拼接路径(以"/"拼接)
+ (NSString *)jointPathComponent:(NSString *)filePathA path:(NSString *)filePathB
{
    return [filePathA stringByAppendingPathComponent:filePathB];
}
// 拼接路径(以"."拼接)
+ (NSString *)jointPathExtension:(NSString *)filePathA path:(NSString *)filePathB
{
    return [filePathA stringByAppendingPathExtension:filePathB];
}
// 创建文件夹
+ (BOOL)createDirectoryFile:(NSString *)filePath
{
    NSFileManager *manager = [NSFileManager defaultManager];
    return [manager createDirectoryAtPath:filePath withIntermediateDirectories:YES attributes:nil error:nil];
}
// 创建文件
+ (BOOL)createFile:(NSString *)filePath fileContent:(NSData *)fileData
{
    NSFileManager *manager = [NSFileManager defaultManager];
    return [manager createFileAtPath:filePath contents:fileData attributes:nil];
}
// 移除文件
+ (BOOL)removeFilePath:(NSString *)filePath
{
    if (![self isExistAtPath:filePath]) { return NO;}
    NSFileManager *manager = [NSFileManager defaultManager];
    return [manager removeItemAtPath:filePath error:nil];
}
// 移动文件
+ (BOOL)moveFilePath:(NSString *)filePathA toFilePath:(NSString *)filePathB
{
    if (![self isExistAtPath:filePathA]) { return NO;}
    NSFileManager *manager = [NSFileManager defaultManager];
    return [manager moveItemAtPath:filePathA toPath:filePathB error:nil];
}
// 赋值文件
+ (BOOL)copyFilePath:(NSString *)fielPathA toFilePath:(NSString *)filePathB
{
    if (![self isExistAtPath:fielPathA]) { return NO;}
    NSFileManager *manager = [NSFileManager defaultManager];
    return [manager copyItemAtPath:fielPathA toPath:filePathB error:nil];
}
// 判断是否存在
+ (BOOL)isExistAtPath:(NSString *)filePath
{
    NSFileManager *manager = [NSFileManager defaultManager];
    return [manager fileExistsAtPath:filePath];
}
// 获取文件属性
+ (NSDictionary *)attributesForFilePath:(NSString *)filePath
{
    if (![self isExistAtPath:filePath]) { return nil;}
    NSFileManager *manager = [NSFileManager defaultManager];
    return [manager attributesOfItemAtPath:filePath error:nil];
}
// 获取文件大小
+ (NSString *)fileSizeForFilePath:(NSString *)filePath
{
    if (![self isExistAtPath:filePath]) { return @"文件不存在";}
    return [NSString stringWithFormat:@"%.2fKB",[self attributesForFilePath:filePath].fileSize / 1024.0];
}
// 获取文件时间
+ (NSString *)fileCreateDateForFilePath:(NSString *)filePath
{
    if (![self isExistAtPath:filePath]) { return @"文件不存在";}
    return [NSString stringWithFormat:@"%@",[self attributesForFilePath:filePath].fileCreationDate];
}
// 对文件进行写入操作
+ (BOOL)writeToFilePath:(NSString *)filePath fileData:(NSData *)fileData
{
    if (![self isExistAtPath:filePath]) { return NO;}
    NSFileHandle *handle = [NSFileHandle fileHandleForWritingAtPath:filePath];
    [handle seekToEndOfFile];
    [handle writeData:fileData];
    [handle closeFile];
    return YES;
}
// 对文件进行读操作
+ (NSData *)readFilePath:(NSString *)filePath
{
    if (![self isExistAtPath:filePath]) { return nil;}
    NSFileHandle *handle = [NSFileHandle fileHandleForReadingAtPath:filePath];
    [handle seekToFileOffset:0];
    NSData *data = [handle readDataToEndOfFile];
    [handle closeFile];
    return data;
}
// 归档文件
+ (NSData *)keyedArchiver:(id<NSCopying>)obj key:(NSString *)key
{
    NSMutableData *mData = [NSMutableData data];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:mData];
    [archiver encodeObject:obj forKey:key];
    [archiver finishEncoding];
    return mData;
}
// 反归档文件
+ (id<NSCopying>)keyedUnarchiverData:(NSData *)mData key:(NSString *)key
{
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:mData];
    id<NSCopying> obj = [unarchiver decodeObjectForKey:key];
    [unarchiver finishDecoding];
    return obj;
}
@end

