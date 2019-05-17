//
//  LYSEncryptManager.h
//  LYSKitDemo
//
//  Created by HENAN on 2019/5/15.
//  Copyright © 2019年 liyangshuai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LYSEncryptManager : NSObject

/**
 MD5加密32位 大写
 
 @param str 明文
 @return 密文
 */
+ (NSString *)ly_MD5Encrypt32LowerWithStr:(NSString *)str;

/**
 MD5加密32位 小写

 @param str 明文
 @return 密文
 */
+ (NSString *)ly_MD5Encrypt32UpperWithStr:(NSString *)str;

/**
 MD5加密16位 大写

 @param str 明文
 @return 密文
 */
+ (NSString *)ly_MD5Encrypt16UpperWithStr:(NSString *)str;
/**
 MD5加密16位 小写
 
 @param str 明文
 @return 密文
 */
+ (NSString *)ly_MD5Encrypt16LowerWithStr:(NSString *)str;

/**
 AES_CBC_128_加密

 @param data 要加密的数据NSData类型
 @param key 密钥
 @param iv 偏移量(只有CBC模式才有偏移量)
 @return 加密之后的数据NSData类型
 */
+ (NSData *)ly_AES_CBC_128_EncryptData:(NSData *)data key:(NSString *)key iv:(NSString *)iv;

/**
 AES_CBC_128_解密
 
 @param data 要解密的数据NSData类型
 @param key 密钥
 @param iv 偏移量(只有CBC模式才有偏移量)
 @return 解密之后的数据NSData类型
 */
+ (NSData *)ly_AES_CBC_128_DecryptData:(NSData *)data key:(NSString *)key iv:(NSString *)iv;

/**
 AES_ECB_128_加密

 @param data 要加密的数据
 @param key 密钥ECB
 @return 加密之后的数据
 */
+ (NSData *)ly_AES_ECB_128_EncryptData:(NSData *)data key:(NSString *)key;

/**
 AES_ECB_128_解密
 
 @param data 要加密的数据
 @param key 密钥
 @return 加密之后的数据
 */
+ (NSData *)ly_AES_ECB_128_DecryptData:(NSData *)data key:(NSString *)key;

/**
 AES_CBC_128_加密 结果以base64编码
 
 @param str 要加密的数据
 @param key 密钥
 @param iv 偏移量(只有CBC模式才有偏移量)
 @return 加密之后的数据
 */
+ (NSString *)ly_AES_CBC_128_EncryptString:(NSString *)str key:(NSString *)key iv:(NSString *)iv;

/**
 AES_CBC_128_解密 输入参数以base64编码
 
 @param base64Str 要解密的数据
 @param key 密钥
 @param iv 偏移量(只有CBC模式才有偏移量)
 @return 解密之后的数据
 */
+ (NSString *)ly_AES_CBC_128_DecryptString:(NSString *)base64Str key:(NSString *)key iv:(NSString *)iv;

/**
 AES_ECB_128_加密 结果以base64编码

 @param str 要加密的数据
 @param key 密钥
 @return 加密之后的数据
 */
+ (NSString *)ly_AES_ECB_128_EncryptString:(NSString *)str key:(NSString *)key;

/**
 AES_ECB_128_解密 输入参数以base64编码

 @param base64Str 要解密的数据
 @param key 密钥
 @return 解密之后的数据
 */
+ (NSString *)ly_AES_ECB_128_DecryptString:(NSString *)base64Str key:(NSString *)key;

/**
 DES_CBC_128_加密

 @param data 加密的数据
 @param key 密钥
 @param iv 偏移量
 @return 加密之后的数据
 */
+ (NSData *)ly_DES_CBC_128_EncryptData:(NSData *)data key:(NSString *)key iv:(NSString *)iv;

/**
 DES_CBC_128_解密

 @param data 加密的数据
 @param key 密钥
 @param iv 偏移量
 @return 解密之后的数据
 */
+ (NSData *)ly_DES_CBC_128_DecryptData:(NSData *)data key:(NSString *)key iv:(NSString *)iv;

/**
 DES_ECB_128_加密

 @param data 加密的数据
 @param key 密钥
 @return 加密之后的数据
 */
+ (NSData *)ly_DES_ECB_128_EncryptData:(NSData *)data key:(NSString *)key;

/**
 DES_ECB_128_解密

 @param data 解密的数据
 @param key 密钥
 @return 解密之后的数据
 */
+ (NSData *)ly_DES_ECB_128_DecryptData:(NSData *)data key:(NSString *)key;

/**
 DES_CBC_128_加密 结果以base64编码

 @param str 加密的数据
 @param key 密钥
 @param iv 偏移量
 @return 加密之后的数据
 */
+ (NSString *)ly_DES_CBC_128_EncryptString:(NSString *)str key:(NSString *)key iv:(NSString *)iv;

/**
 DES_CBC_128_解密 输入参数以base64编码

 @param base64Str 解密的数据
 @param key 密钥
 @param iv 偏移量
 @return 解密之后的数据
 */
+ (NSString *)ly_DES_CBC_128_DecryptString:(NSString *)base64Str key:(NSString *)key iv:(NSString *)iv;

/**
 DES_ECB_128_加密 结果以base64编码

 @param str 加密的数据
 @param key 密钥
 @return 加密之后的数据
 */
+ (NSString *)ly_DES_ECB_128_EncryptString:(NSString *)str key:(NSString *)key;

/**
 DES_ECB_128_解密 输入参数以base64编码

 @param base64Str 解密的数据
 @param key 密钥
 @return 解密之后的数据
 */
+ (NSString *)ly_DES_ECB_128_DecryptString:(NSString *)base64Str key:(NSString *)key;

/**
 sha1加密

 @param str 加密的数据
 @return 加密之后的数据
 */
+ (NSString *)ly_sha1EncryptString:(NSString *)str;
@end
