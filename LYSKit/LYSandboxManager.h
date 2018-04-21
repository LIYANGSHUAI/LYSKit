//
//  LYSandboxManager.h
//  LYSKitDemo
//
//  Created by HENAN on 2018/4/20.
//  Copyright © 2018年 liyangshuai. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 * --- Documents 使用该路径放置关键数据，也就是不能通过App重新生成的数据。该路径可通过配置实现iTunes共享文件。可被iTunes备份。（现在保存在该路径下的文件还需要考虑iCloud同步),如数据库文件，或程序中浏览到的文件数据。如果进行备份会将此文件夹中的文件包括其中
 * --- Library 该路径下一般保存着用户配置文件。可创建子文件夹。可以用来放置您希望被备份但不希望被用户看到的数据。该路径下的文件夹，除Caches以外，都会被iTunes备份
 *     -- Caches 存放缓存文件，iTunes不会备份此目录，此目录下文件不会在应用退出删除
 *     -- Preferences 存储应用的默认设置及状态信息
 * --- tmp 提供一个即时创建临时文件的地方
 */

@interface LYSandboxManager : NSObject

/**
 获取沙盒路径
 
 @return                                    返回沙盒路径
 */
+ (NSString *)ly_sandboxPathForHomeDirectory;

/**
 获取沙盒Documents路径
 
 @return                                    返回路径字符串
 */
+ (NSString *)ly_sandboxPathForDocument;

/**
 获取沙盒Library
 
 @return                                    返回路径字符串
 */
+ (NSString *)ly_sandboxPathForLibrary;

/**
 获取沙盒Caches路径
 
 @return                                    返回路径字符串
 */
+ (NSString *)ly_sandboxPathForCaches;

/**
 拼接路径(以"/"拼接)
 
 @param filePathA                           用于拼接的路径字符串
 @param filePathB                           用于拼接的路径
 @return                                    返回拼接后的路径
 */
+ (NSString *)ly_jointPathComponent:(NSString *)filePathA path:(NSString *)filePathB;

/**
 拼接路径(以"."拼接)
 
 @param filePathA                           用于拼接的路径字符串
 @param filePathB                           用于拼接的路径
 @return                                    返回拼接后的路径
 */
+ (NSString *)ly_jointPathExtension:(NSString *)filePathA path:(NSString *)filePathB;

/**
 创建目录
 
 @param filePath                            目录路径
 @return                                    返回是否创建成功
 */
+ (BOOL)ly_createDirectoryFile:(NSString *)filePath;

/**
 创建文件
 
 @param filePath                            目录文件
 @param fileData                            文件内容
 @return                                    返回是否创建成功
 */
+ (BOOL)ly_createFile:(NSString *)filePath fileContent:(NSData *)fileData;

/**
 移除文件
 
 @param filePath                            需要移除的文件
 @return                                    返回是否移除成功
 */
+ (BOOL)ly_removeFilePath:(NSString *)filePath;

/**
 移动文件
 
 @param filePathA                           需要被移动的文件
 @param filePathB                           要移动到的文件
 @return                                    返回是否移动成功
 */
+ (BOOL)ly_moveFilePath:(NSString *)filePathA toFilePath:(NSString *)filePathB;

/**
 复制文件
 
 @param fielPathA                           需要被复制的文件
 @param filePathB                           要复制到的文件
 @return                                    返回是否复制成功
 */
+ (BOOL)ly_copyFilePath:(NSString *)fielPathA toFilePath:(NSString *)filePathB;

/**
 判断文件是否存在
 
 @param filePath                            文件路径
 @return                                    返回是否存在
 */
+ (BOOL)ly_isExistAtPath:(NSString *)filePath;

/**
 获取文件属性
 
 @param filePath                            文件路径
 @return                                    返回文件属性信息
 */
+ (NSDictionary *)ly_attributesForFilePath:(NSString *)filePath;

/**
 获取文件大小
 
 @param filePath                            文件路径
 @return                                    返回文件信息
 */
+ (NSString *)ly_fileSizeForFilePath:(NSString *)filePath;

/**
 获取文件创建时间

 @param filePath                             文件路径
 @return                                     返回时间字符串
 */
+ (NSString *)ly_fileCreateDateForFilePath:(NSString *)filePath;

/**
 对文件进行写入操作
 
 @param filePath                            需要写入的文件
 @param fileData                            需要写入的内容
 @return                                    返回是否操作成功
 */
+ (BOOL)ly_writeToFilePath:(NSString *)filePath fileData:(NSData *)fileData;

/**
 对文件进行读操作,获取文件内容
 
 @param filePath                            文件路径
 @return                                    返回文件内容数据
 */
+ (NSData *)ly_readFilePath:(NSString *)filePath;

/**
 归档文件
 
 @param obj                                 文件对象
 @param keyPath                             文件的标识
 @return                                    文件数据
 */
+ (NSData *)ly_keyedArchiver:(id<NSCopying>)obj keyPath:(NSString *)keyPath;

/**
 反归档文件
 
 @param mData                               文件数据
 @param keyPath                             文件的标识
 @return                                    文件对象
 */
+ (id<NSCopying>)ly_keyedUnarchiverData:(NSData *)mData keyPath:(NSString *)keyPath;
@end
