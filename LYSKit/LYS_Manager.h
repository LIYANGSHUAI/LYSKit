//
//  LYS_Manager.h
//  LYSKit
//
//  Created by HENAN on 2017/9/24.
//  Copyright © 2017年 个人开发实用框架. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LYS_BaseObjc.h"
#import "LYS_Reachability.h"
@class LYSTupleManager;
/**
 定义一个结构体,用来存储一个特定日期的年月日时分秒
 */
typedef struct {
    NSInteger y;
    NSInteger m;
    NSInteger d;
    NSInteger h;
    NSInteger f;
    NSInteger s;
}LYDate;

/**
 创建一个时间的日期结构体

 @param y 年
 @param m 月
 @param d 日
 @param h 时
 @param f 分
 @param s 秒
 @return 返回LYDate
 */
LYDate ly_CreateDate(NSInteger y,
                     NSInteger m,
                     NSInteger d,
                     NSInteger h,
                     NSInteger f,
                     NSInteger s);

/**
 判断两个日期是否是同一天的同一时刻

 @param date1 日期一
 @param date2 日期二
 @return 比较结果
 */
bool ly_IsEqual(LYDate date1,LYDate date2);

/**
 判断是否是同一年

 @param date1 日期一
 @param date2 日期二
 @return 比较结果
 */
bool ly_SameYear(LYDate date1,LYDate date2);

/**
 判断是否是同一月

 @param date1 日期一
 @param date2 日期二
 @return 比较结果
 */
bool ly_SameMonth(LYDate date1,LYDate date2);

/**
 判断是否是同一天

 @param date1 日期一
 @param date2 日期二
 @return 比较结果
 */
bool ly_SameDay(LYDate date1,LYDate date2);

/**
 比较两个日期返回(1, 0, -1)对应(date1比date2晚,date1和date2一样,date1比date2晚),最小比较到日,如果具体到时分秒,则不能区分

 @param date1 日期一
 @param date2 日期二
 @return 比较结果
 */
NSInteger ly_CompareDate(LYDate date1,LYDate date2);

@interface LYDateManager : NSObject

/**
 获取今天的LYDate格式

 @return 返回LYDate类型
 */
+ (LYDate)ly_Today;

/**
 将某一日期转换为LYDate格式

 @param date 转换日期
 @return 返回LYDate类型
 */
+ (LYDate)ly_LYDateFromDate:(NSDate *)date;

/**
 获取给定日期是星期几

 @param date 传入日期
 @return 返回星期几
 */
+ (NSInteger)ly_WeekDayForDate:(NSDate *)date;

/**
 获取这个月有多少天

 @param date 传入日期
 @return 返回这个月有多少天
 */
+ (NSInteger)ly_DayNumForDate:(NSDate *)date;

/**
 获取这个月的第一天星期几

 @param date 传入日期
 @return 返回这个月的第一天星期几
 */
+ (NSInteger)ly_WeekDayForFirstDate:(NSDate *)date;

/**
 获取给定日期是几号

 @param date 传入日期
 @return 返回给定日期是星期几
 */
+ (NSInteger)ly_DayForDate:(NSDate *)date;

/**
 获取今天是几号

 @return 返回今天是几号
 */
+ (NSInteger)ly_DayForToday;

/**
 将LYDate转为NSDate

 @param date 传入日期
 @return 返回NSDate类型
 */
+ (NSDate *)ly_DateFromLYDate:(LYDate)date;
@end

@interface LYAPPDelegateManager : NSObject

/**
 设置window的跟视图控制器

 @param rootViewController 要设置的跟视图控制器
 */
+ (void)ly_createWindowAndSetRootViewController:(UIViewController *)rootViewController;

/**
 根据返回条件分别显示不同的视图控制器

 @param ispermit 判断条件
 @param firstViewController 如果判断条件:YES,显示这个控制器
 @param secoundViewController 如果判断条件:NO,显示这个控制器
 */
+ (void)ly_if:(BOOL(^)(void))ispermit showViewController:(UIViewController *)firstViewController elseShowViewController:(UIViewController *)secoundViewController;

/**
 设置window的跟视图控制器

 @param rootViewController 根视图控制器
 */
+ (void)ly_setWindowRootViewController:(UIViewController *)rootViewController;

/**
 设置启动动画

 @param startInterface 启动界面
 @param mainInterface 应用主界面
 @param interval 启动动画的显示时间
 @param durtion 动画消失的动画时间
 */
+ (void)ly_createWindowAndloadStartInterface:(UIViewController *)startInterface mainInterface:(UIViewController *)mainInterface delay:(NSTimeInterval)interval durtion:(NSTimeInterval)durtion;

/**
 模仿导航进入下一级页面

 @param fromVC 上一级页面
 @param toVC 下一级页面
 @param completion 完成回调
 */
+ (void)pushFrom:(UIViewController *)fromVC toViewController:(UIViewController *)toVC completion:(void(^)(void))completion;

/**
 模仿导航退回上一级页面

 @param fromVC 下一级页面
 @param toVC 上一级页面
 @param completion 完成回调
 */
+ (void)popFrom:(UIViewController *)fromVC toViewController:(UIViewController *)toVC completion:(void(^)(void))completion;
@end

@class CLLocation;

@class CLPlacemark;

@interface LYLocationManager : NSObject

/**
 获取位置信息(如果此方法调用多次,那么下次的回调函数会覆盖上次的回调,前提时此时还没有定位成功)

 @param success 成功定位回调
 @param fail 失败定位回调
 */
+ (void)ly_location:(void(^)(CLLocation *location))success
            fail:(void(^)(NSString *state))fail;

/**
 对定位信息进行反编码

 @param location 定位信息
 @param success 反编码成功回调
 */
+ (void)ly_geocoder:(CLLocation *)location
         success:(void(^)(CLPlacemark *placemark))success;
@end

@interface LYSystemManager : NSObject

/**
 获取设备型号信息

 @return 返回型号
 */
+ (LYSTuple)deviceString;

/**
 注册网络监听

 @param action 监听回调事件
 @param reachability 网络监听对象
 */
+ (void)ly_notifitionReachability:(void(^)(LYS_Reachability *reachability))action reachability:(LYS_Reachability *)reachability promptly:(BOOL)promptly;

/**
 移除网络监听

 @param reachability 网络监听对象
 */
+ (void)ly_stopNotifitionReachability:(LYS_Reachability *)reachability;
@end

////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////

@interface LYSandboxManager : NSObject
/*
 * --- Documents 使用该路径放置关键数据，也就是不能通过App重新生成的数据。该路径可通过配置实现iTunes共享文件。可被iTunes备份。（现在保存在该路径下的文件还需要考虑iCloud同步),如数据库文件，或程序中浏览到的文件数据。如果进行备份会将此文件夹中的文件包括其中
 * --- Library 该路径下一般保存着用户配置文件。可创建子文件夹。可以用来放置您希望被备份但不希望被用户看到的数据。该路径下的文件夹，除Caches以外，都会被iTunes备份
 *     -- Caches 存放缓存文件，iTunes不会备份此目录，此目录下文件不会在应用退出删除
 *     -- Preferences 存储应用的默认设置及状态信息
 * --- tmp 提供一个即时创建临时文件的地方
 */

/**
 获取沙盒路径
 
 @return 返回沙盒路径
 */
+ (NSString *)ly_sandboxPathForHomeDirectory;

/**
 获取沙盒Documents路径
 
 @return 返回路径字符串
 */
+ (NSString *)ly_sandboxPathForDocument;

/**
 获取沙盒Library
 
 @return 返回路径字符串
 */
+ (NSString *)ly_sandboxPathForLibrary;

/**
 获取沙盒Caches路径
 
 @return 返回路径字符串
 */
+ (NSString *)ly_sandboxPathForCaches;

/**
 拼接路径(以"/"拼接)
 
 @param filePathA 用于拼接的路径字符串
 @param filePathB 用于拼接的路径
 @return 返回拼接后的路径
 */
+ (NSString *)ly_jointPathComponent:(NSString *)filePathA path:(NSString *)filePathB;

/**
 拼接路径(以"."拼接)
 
 @param filePathA 用于拼接的路径字符串
 @param filePathB 用于拼接的路径
 @return 返回拼接后的路径
 */
+ (NSString *)ly_jointPathExtension:(NSString *)filePathA path:(NSString *)filePathB;

/**
 创建目录
 
 @param filePath 目录路径
 @return 返回是否创建成功
 */
+ (BOOL)ly_createDirectoryFile:(NSString *)filePath;

/**
 创建文件
 
 @param filePath 目录文件
 @param fileData 文件内容
 @return 返回是否创建成功
 */
+ (BOOL)ly_createFile:(NSString *)filePath fileContent:(NSData *)fileData;

/**
 移除文件
 
 @param filePath 需要移除的文件
 @return 返回是否移除成功
 */
+ (BOOL)ly_removeFilePath:(NSString *)filePath;

/**
 移动文件
 
 @param filePathA 需要被移动的文件
 @param filePathB 要移动到的文件
 @return 返回是否移动成功
 */
+ (BOOL)ly_moveFilePath:(NSString *)filePathA toFilePath:(NSString *)filePathB;

/**
 复制文件
 
 @param fielPathA 需要被复制的文件
 @param filePathB 要复制到的文件
 @return 返回是否复制成功
 */
+ (BOOL)ly_copyFilePath:(NSString *)fielPathA toFilePath:(NSString *)filePathB;

/**
 判断文件是否存在
 
 @param filePath 文件路径
 @return 返回是否存在
 */
+ (BOOL)ly_isExistAtPath:(NSString *)filePath;

/**
 获取文件属性
 
 @param filePath 文件路径
 @return 返回文件属性信息
 */
+ (NSDictionary *)ly_attributesForFilePath:(NSString *)filePath;

/**
 获取文件大小
 
 @param filePath 文件路径
 @return 返回文件信息
 */
+ (NSString *)ly_fileCreateDateForFilePath:(NSString *)filePath;

/**
 对文件进行写入操作
 
 @param filePath 需要写入的文件
 @param fileData 需要写入的内容
 @return 返回是否操作成功
 */
+ (BOOL)ly_writeToFilePath:(NSString *)filePath fileData:(NSData *)fileData;

/**
 对文件进行读操作,获取文件内容
 
 @param filePath 文件路径
 @return 返回文件内容数据
 */
+ (NSData *)ly_readFilePath:(NSString *)filePath;

/**
 归档文件
 
 @param obj 文件对象
 @param keyPath 文件的标识
 @return 文件数据
 */
+ (NSData *)ly_keyedArchiver:(id<NSCopying>)obj keyPath:(NSString *)keyPath;

/**
 反归档文件
 
 @param mData 文件数据
 @param keyPath 文件的标识
 @return 文件对象
 */
+ (id<NSCopying>)ly_keyedUnarchiverData:(NSData *)mData keyPath:(NSString *)keyPath;
@end

@interface LYKeyedArchiverManager : NSObject

/**
 给一个类添加NSCoding协议
 
 @param objcClass 需要被添加协议的类
 */
+ (void)ly_addNSCodingProtocolForClass:(Class)objcClass;
@end

