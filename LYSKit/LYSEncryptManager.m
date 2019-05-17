//
//  LYSEncryptManager.m
//  LYSKitDemo
//
//  Created by HENAN on 2019/5/15.
//  Copyright © 2019年 liyangshuai. All rights reserved.
//

#import "LYSEncryptManager.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCrypto.h>

@implementation LYSEncryptManager
// MD5加密
+ (NSString *)ly_MD5Encrypt32UpperWithStr:(NSString *)str
{
    if (!str) return nil;
    const char *cStr = str.UTF8String;
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (CC_LONG) strlen(cStr), result);
    NSMutableString *md5Str = [NSMutableString string];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i ++) {
        [md5Str appendFormat:@"%02X", result[i]];
    }
    return md5Str;
}
+ (NSString *)ly_MD5Encrypt32LowerWithStr:(NSString *)str
{
    if (!str) return nil;
    const char *cStr = str.UTF8String;
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (CC_LONG) strlen(cStr), result);
    NSMutableString *md5Str = [NSMutableString string];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i ++) {
        [md5Str appendFormat:@"%02x", result[i]];
    }
    return md5Str;
}
+ (NSString *)ly_MD5Encrypt16UpperWithStr:(NSString *)str
{
    NSString *md5Str = [self ly_MD5Encrypt32UpperWithStr:str];
    NSString *string;
    for (int i = 0; i < 24; i++) {
        string = [md5Str substringWithRange:NSMakeRange(8, 16)];
    }
    return string;
}
+ (NSString *)ly_MD5Encrypt16LowerWithStr:(NSString *)str
{
    NSString *md5Str = [self ly_MD5Encrypt32LowerWithStr:str];
    NSString *string;
    for (int i = 0; i < 24; i++) {
        string = [md5Str substringWithRange:NSMakeRange(8, 16)];
    }
    return string;
}
+ (NSData *)ly_AES_encryptOperation:(CCOperation)operation data:(NSData *)data key:(NSString *)key iv:(NSString *)iv opyions:(CCOptions)options
{
    // kCCKeySizeAES128是加密位数 可以替换成256位的
    char keyPtr[kCCKeySizeAES128 + 1];
    bzero(keyPtr, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    size_t bufferSize = [data length] + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    size_t numBytesEncrypted = 0;
    
    // IV
    if (iv!=nil)
    {
        char ivPtr[kCCBlockSizeAES128 + 1];
        bzero(ivPtr, sizeof(ivPtr));
        [iv getCString:ivPtr maxLength:sizeof(ivPtr) encoding:NSUTF8StringEncoding];
        // 这里设置的参数ios默认为CBC加密方式，如果需要其他加密方式如ECB，在kCCOptionPKCS7Padding这个参数后边加上kCCOptionECBMode，即kCCOptionPKCS7Padding | kCCOptionECBMode，但是记得修改上边的偏移量，因为只有CBC模式有偏移量之说
        CCCryptorStatus cryptorStatus = CCCrypt(operation, kCCAlgorithmAES128, options,
                                                keyPtr, kCCKeySizeAES128,
                                                ivPtr,
                                                [data bytes], [data length],
                                                buffer, bufferSize,
                                                &numBytesEncrypted);
        
        if (cryptorStatus == kCCSuccess)
        {
            return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
        }
    } else {
        // 这里设置的参数ios默认为CBC加密方式，如果需要其他加密方式如ECB，在kCCOptionPKCS7Padding这个参数后边加上kCCOptionECBMode，即kCCOptionPKCS7Padding | kCCOptionECBMode，但是记得修改上边的偏移量，因为只有CBC模式有偏移量之说
        CCCryptorStatus cryptorStatus = CCCrypt(operation, kCCAlgorithmAES128, options,
                                                keyPtr, kCCKeySizeAES128,
                                                NULL,
                                                [data bytes], [data length],
                                                buffer, bufferSize,
                                                &numBytesEncrypted);
        
        if (cryptorStatus == kCCSuccess)
        {
            return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
        }
    }
    free(buffer);
    return nil;
}
// AES_CBC_128_加密
+ (NSData *)ly_AES_CBC_128_EncryptData:(NSData *)data key:(NSString *)key iv:(NSString *)iv
{
    return [self ly_AES_encryptOperation:kCCEncrypt data:data key:key iv:iv opyions:kCCOptionPKCS7Padding];
}
// AES_CBC_128_解密
+ (NSData *)ly_AES_CBC_128_DecryptData:(NSData *)data key:(NSString *)key iv:(NSString *)iv
{
    return [self ly_AES_encryptOperation:kCCDecrypt data:data key:key iv:iv opyions:kCCOptionPKCS7Padding];
}
// AES_ECB_128_加密
+ (NSData *)ly_AES_ECB_128_EncryptData:(NSData *)data key:(NSString *)key
{
    return [self ly_AES_encryptOperation:kCCEncrypt data:data key:key iv:nil opyions:kCCOptionPKCS7Padding | kCCOptionECBMode];
}
// AES_ECB_128_解密
+ (NSData *)ly_AES_ECB_128_DecryptData:(NSData *)data key:(NSString *)key
{
    return [self ly_AES_encryptOperation:kCCDecrypt data:data key:key iv:nil opyions:kCCOptionPKCS7Padding | kCCOptionECBMode];
}
// AES_CBC_128_加密 结果以base64编码
+ (NSString *)ly_AES_CBC_128_EncryptString:(NSString *)str key:(NSString *)key iv:(NSString *)iv
{
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    NSData *resultData = [self ly_AES_CBC_128_EncryptData:data key:key iv:iv];
    return [resultData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
}
// AES_CBC_128_解密 输入参数以base64编码
+ (NSString *)ly_AES_CBC_128_DecryptString:(NSString *)base64Str key:(NSString *)key iv:(NSString *)iv
{
    NSData *data = [[NSData alloc] initWithBase64EncodedString:base64Str options:NSDataBase64DecodingIgnoreUnknownCharacters];
    NSData *resultData = [self ly_AES_CBC_128_DecryptData:data key:key iv:iv];
    return [[NSString alloc] initWithData:resultData encoding:NSUTF8StringEncoding];
}
// AES_ECB_128_加密 结果以base64编码
+ (NSString *)ly_AES_ECB_128_EncryptString:(NSString *)str key:(NSString *)key
{
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    NSData *resultData = [self ly_AES_ECB_128_EncryptData:data key:key];
    return [resultData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
}
// AES_ECB_128_解密 输入参数以base64编码
+ (NSString *)ly_AES_ECB_128_DecryptString:(NSString *)base64Str key:(NSString *)key
{
    NSData *data = [[NSData alloc] initWithBase64EncodedString:base64Str options:NSDataBase64DecodingIgnoreUnknownCharacters];
    NSData *resultData = [self ly_AES_ECB_128_DecryptData:data key:key];
    return [[NSString alloc] initWithData:resultData encoding:NSUTF8StringEncoding];
}
+ (NSData *)ly_DES_encryptOperation:(CCOperation)operation data:(NSData *)data key:(NSString *)key iv:(NSString *)iv opyions:(CCOptions)options
{
    // kCCKeySizeAES128是加密位数 可以替换成256位的
    char keyPtr[kCCKeySizeAES128 + 1];
    bzero(keyPtr, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    size_t bufferSize = [data length] + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    size_t numBytesEncrypted = 0;
    
    // IV
    if (iv!=nil)
    {
        char ivPtr[kCCBlockSizeAES128 + 1];
        bzero(ivPtr, sizeof(ivPtr));
        [iv getCString:ivPtr maxLength:sizeof(ivPtr) encoding:NSUTF8StringEncoding];
        // 这里设置的参数ios默认为CBC加密方式，如果需要其他加密方式如ECB，在kCCOptionPKCS7Padding这个参数后边加上kCCOptionECBMode，即kCCOptionPKCS7Padding | kCCOptionECBMode，但是记得修改上边的偏移量，因为只有CBC模式有偏移量之说
        CCCryptorStatus cryptorStatus = CCCrypt(operation, kCCAlgorithmDES, options,
                                                keyPtr, kCCKeySizeDES,
                                                ivPtr,
                                                [data bytes], [data length],
                                                buffer, bufferSize,
                                                &numBytesEncrypted);
        
        if (cryptorStatus == kCCSuccess)
        {
            return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
        }
    } else {
        // 这里设置的参数ios默认为CBC加密方式，如果需要其他加密方式如ECB，在kCCOptionPKCS7Padding这个参数后边加上kCCOptionECBMode，即kCCOptionPKCS7Padding | kCCOptionECBMode，但是记得修改上边的偏移量，因为只有CBC模式有偏移量之说
        CCCryptorStatus cryptorStatus = CCCrypt(operation, kCCAlgorithmDES, options,
                                                keyPtr, kCCKeySizeDES,
                                                NULL,
                                                [data bytes], [data length],
                                                buffer, bufferSize,
                                                &numBytesEncrypted);
        
        if (cryptorStatus == kCCSuccess)
        {
            return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
        }
    }
    free(buffer);
    return nil;
}
// DES_CBC_128_加密
+ (NSData *)ly_DES_CBC_128_EncryptData:(NSData *)data key:(NSString *)key iv:(NSString *)iv
{
    return [self ly_DES_encryptOperation:kCCEncrypt data:data key:key iv:iv opyions:kCCOptionPKCS7Padding];
}
// DES_CBC_128_解密
+ (NSData *)ly_DES_CBC_128_DecryptData:(NSData *)data key:(NSString *)key iv:(NSString *)iv
{
    return [self ly_DES_encryptOperation:kCCDecrypt data:data key:key iv:iv opyions:kCCOptionPKCS7Padding];
}
// DES_ECB_128_加密
+ (NSData *)ly_DES_ECB_128_EncryptData:(NSData *)data key:(NSString *)key
{
    return [self ly_DES_encryptOperation:kCCEncrypt data:data key:key iv:nil opyions:kCCOptionPKCS7Padding | kCCOptionECBMode];
}
// DES_ECB_128_解密
+ (NSData *)ly_DES_ECB_128_DecryptData:(NSData *)data key:(NSString *)key
{
    return [self ly_DES_encryptOperation:kCCDecrypt data:data key:key iv:nil opyions:kCCOptionPKCS7Padding | kCCOptionECBMode];
}
// DES_CBC_128_加密 结果以base64编码
+ (NSString *)ly_DES_CBC_128_EncryptString:(NSString *)str key:(NSString *)key iv:(NSString *)iv
{
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    NSData *resultData = [self ly_DES_CBC_128_EncryptData:data key:key iv:iv];
    return [resultData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
}
// DES_CBC_128_解密 输入参数以base64编码
+ (NSString *)ly_DES_CBC_128_DecryptString:(NSString *)base64Str key:(NSString *)key iv:(NSString *)iv
{
    NSData *data = [[NSData alloc] initWithBase64EncodedString:base64Str options:NSDataBase64DecodingIgnoreUnknownCharacters];
    NSData *resultData = [self ly_DES_CBC_128_DecryptData:data key:key iv:iv];
    return [[NSString alloc] initWithData:resultData encoding:NSUTF8StringEncoding];
}
// DES_ECB_128_加密 结果以base64编码
+ (NSString *)ly_DES_ECB_128_EncryptString:(NSString *)str key:(NSString *)key
{
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    NSData *resultData = [self ly_DES_ECB_128_EncryptData:data key:key];
    return [resultData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
}
// DES_ECB_128_解密 输入参数以base64编码
+ (NSString *)ly_DES_ECB_128_DecryptString:(NSString *)base64Str key:(NSString *)key
{
    NSData *data = [[NSData alloc] initWithBase64EncodedString:base64Str options:NSDataBase64DecodingIgnoreUnknownCharacters];
    NSData *resultData = [self ly_DES_ECB_128_DecryptData:data key:key];
    return [[NSString alloc] initWithData:resultData encoding:NSUTF8StringEncoding];
}
// sha1加密
+ (NSString *)ly_sha1EncryptString:(NSString *)str
{
    const char *cstr = [str cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:str.length];
    //使用对应的CC_SHA1,CC_SHA256,CC_SHA384,CC_SHA512的长度分别是20,32,48,64
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    //使用对应的CC_SHA256,CC_SHA384,CC_SHA512
    CC_SHA1(data.bytes, data.length, digest);
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
}
@end
