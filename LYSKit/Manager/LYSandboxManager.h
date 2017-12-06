//
//  LYSandboxManager.h
//  LYSKitDemo
//
//  Created by HENAN on 2017/12/5.
//  Copyright © 2017年 HENAN. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LYSandboxManager : NSObject
/*
 * --- Documents 使用该路径放置关键数据，也就是不能通过App重新生成的数据。该路径可通过配置实现iTunes共享文件。可被iTunes备份。（现在保存在该路径下的文件还需要考虑iCloud同步),如数据库文件，或程序中浏览到的文件数据。如果进行备份会将此文件夹中的文件包括其中
 * --- Library 该路径下一般保存着用户配置文件。可创建子文件夹。可以用来放置您希望被备份但不希望被用户看到的数据。该路径下的文件夹，除Caches以外，都会被iTunes备份
 *     -- Caches 存放缓存文件，iTunes不会备份此目录，此目录下文件不会在应用退出删除
 *     -- Preferences 存储应用的默认设置及状态信息
 * --- tmp 提供一个即时创建临时文件的地方
 */

// Get the sandbox path
+ (NSString *)sandboxPathForHomeDirectory;

// Get the sandbox Documents path
+ (NSString *)sandboxPathForDocument;

// Get the sandbox Library
+ (NSString *)sandboxPathForLibrary;

// Get the sandbox Caches path
+ (NSString *)sandboxPathForCaches;

// Splicing path ("/" splicing)
+ (NSString *)jointPathComponent:(NSString *)filePathA path:(NSString *)filePathB;

// Splicing path (in "." splicing)
+ (NSString *)jointPathExtension:(NSString *)filePathA path:(NSString *)filePathB;

// Create a directory
+ (BOOL)createDirectoryFile:(NSString *)filePath;

// create a file
+ (BOOL)createFile:(NSString *)filePath fileContent:(NSData *)fileData;

// remove file
+ (BOOL)removeFilePath:(NSString *)filePath;

// move file
+ (BOOL)moveFilePath:(NSString *)filePathA toFilePath:(NSString *)filePathB;

// Copy file
+ (BOOL)copyFilePath:(NSString *)fielPathA toFilePath:(NSString *)filePathB;

// Whether the judgment file exists
+ (BOOL)isExistAtPath:(NSString *)filePath;

// Obtain file properties
+ (NSDictionary *)attributesForFilePath:(NSString *)filePath;

// Get the file size
+ (NSString *)fileCreateDateForFilePath:(NSString *)filePath;

// Write a file to a file
+ (BOOL)writeToFilePath:(NSString *)filePath fileData:(NSData *)fileData;

// Read the file to get the content of the file
+ (NSData *)readFilePath:(NSString *)filePath;

// Archival documents
+ (NSData *)keyedArchiver:(id<NSCopying>)obj key:(NSString *)key;

// Anti archiving document
+ (id<NSCopying>)keyedUnarchiverData:(NSData *)mData key:(NSString *)key;
@end
