
#import <UIKit/UIKit.h>
#import <objc/runtime.h>

#pragma mark - 元组 -
#define LYSTuple(ONE,TWO) [LYSTupleManager ly_create:ONE two:TWO]

/**
 LYSTupleManager 类,主要是模仿swift中的元组类,实现一个对象可以同时存储两个任意对象的效果
 */

@class LYSTupleManager;
typedef LYSTupleManager* LYSTuple;

@interface LYSTupleManager : NSObject

// 用于存放要存储的对象
@property (nonatomic,strong,readonly)id one;
@property (nonatomic,strong,readonly)id two;

// 创建方法
+ (instancetype)ly_create:(id)one two:(id)two;

@end

@interface LYSRuntimeManager : NSObject

+ (NSArray *)ly_getPropertyListForClass:(Class)className;
+ (NSArray *)ly_getMethodListForClass:(Class)className;
+ (NSArray *)ly_getIvarListForClass:(Class)className;
+ (NSArray *)ly_getProtocolListForClass:(Class)className;

// 简单的为一个对象设置关联属性
+ (void)ly_associationPropertyName:(NSString *)name value:(id)value toObject:(id)object;
+ (id)ly_associationPropertyName:(NSString *)name toObject:(id)object;

// 移除对象的所有关联属性(慎用!这个方法一旦调用,这个对象所以的关联属性都被删除)
+ (void)ly_removeAssociationPropertyToObject:(id)object;

// 动态为一个对象添加关联属性
+ (void)ly_setAssociationPropertyName:(NSString *)name value:(id)value toObject:(id)object;
+ (void)ly_setAssociationPropertyMonitorName:(NSString *)name monitorAction:(BOOL(^)(NSString *name,id oldValue,id newValue))action toObject:(id)object identifier:(NSString *)identifier;
+ (id)ly_getAssociationPropertyName:(NSString *)name toObject:(id)object;
+ (void)ly_removeAllAssociationPropertyForObject:(id)object;
+ (void)ly_removeAssociationPropertyName:(NSString *)name toObject:(id)object;
+ (void)ly_removeAssociationPropertyName:(NSString *)name identifier:(NSString *)identifier toObject:(id)object;
+ (NSArray *)ly_getAssociationPropertyListForObject:(id)object;

// 动态的修改对象的方法
+ (BOOL)ly_replaceMethodForClass:(Class)forClass forInstanceMethod:(SEL)forInstanceMethod fromClass:(Class)fromClass fromInstanceMethod:(SEL)fromInstanceMethod;
+ (BOOL)ly_replaceMethodForClass:(Class)forClass forInstanceMethod:(SEL)forInstanceMethod fromClass:(Class)fromClass fromClassMethod:(SEL)fromClassMethod;
+ (void)ly_exchangeMethodFirstClass:(Class)firstClass firstInstanceMethod:(SEL)firstInstanceMethod secondClass:(Class)secondClass secondInstanceMethod:(SEL)secondInstanceMethod;
+ (void)ly_exchangeMethodFirstClass:(Class)firstClass firstClassMethod:(SEL)firstClassMethod secondClass:(Class)secondClass secondClassMethod:(SEL)secondClassMethod;
+ (void)ly_exchangeMethodFirstClass:(Class)firstClass firstClassMethod:(SEL)firstClassMethod secondClass:(Class)secondClass secondInstanceMethod:(SEL)secondInstanceMethod;
+ (BOOL)ly_addMethodForClass:(Class)forClass fromClass:(Class)fromClass instanceSel:(SEL)instanceSel;
+ (BOOL)ly_addMethodForClass:(Class)forClass fromClass:(Class)fromClass classSel:(SEL)classSel;

// 总上所述:这两个方法无论使用哪一个,只能为一个对象添加另一个对象实例方法,并且实例调用

@end

/*
 *-------------------------------------------------------------------------|
 *         |              串行队列             |         并行队列             |
 *-------------------------------------------------------------------------|
 *         | 主队列         | 自定义串行队列     |  全局队列 | 自定义全局队列      |
 *-------------------------------------------------------------------------|
 * 同步任务 | 线程死锁       | 在主线程顺序完成    | 在主线程顺序完成|在主线程顺序完成 |
 *-------------------------------------------------------------------------|
 * 异步任务 |主线程中顺序完成 | 在子线程顺序完成    | 在子线程乱序完成|在子线程乱序完成  |
 *-------------------------------------------------------------------------|
 */

typedef void(^LYSGCDAction)(void);
typedef void(^LYSGCDActionQueue)(dispatch_queue_t queue);

@interface LYSGCDManager : NSObject

// 获取系统串行队列
+ (dispatch_queue_t)ly_systemSerialQueue;
+ (dispatch_queue_t)ly_systemParallelQueue;
+ (dispatch_queue_t)ly_createSerialQueue;
+ (dispatch_queue_t)ly_createParallelQueue;

// 添加异步任务
+ (void)ly_addAsync_InSystemSerialQueue:(LYSGCDAction)action;
+ (void)ly_addAsync_InSystemParallelQueue:(LYSGCDAction)action;

// 添加同步任务
+ (void)ly_addSync_InSystemParallelQueue:(LYSGCDAction)action;

+ (void)ly_addAsync:(LYSGCDAction)action queue:(dispatch_queue_t)queue;
+ (void)ly_addSync:(LYSGCDAction)action queue:(dispatch_queue_t)queue;

// 障碍任务
+ (void)ly_add_Barrier_Async:(LYSGCDActionQueue)firstAction barrierAction:(LYSGCDAction)actionBarrier lastAction:(LYSGCDAction)completeAction;
+ (void)ly_add_Barrier_AsyncAction:(LYSGCDAction)firstAction queue:(dispatch_queue_t)queue;

+ (void)ly_addAfter:(NSTimeInterval)interval action:(LYSGCDAction)action;
+ (void)ly_addRepeat:(NSInteger)num action:(LYSGCDAction)action;
+ (void)ly_addOnceAction:(LYSGCDAction)action;

// 等待任务
+ (void)ly_add_Group_AsyncAction:(void(^)(dispatch_group_t group,dispatch_queue_t queue))firstAction notifyAction:(LYSGCDAction)action;
+ (void)ly_add_Group_AsyncAction:(LYSGCDAction)firstAction group:(dispatch_group_t)group queue:(dispatch_queue_t)queue;

@end

@interface LYSKVOManager : NSObject

// 利用KVO实现属性监听
+ (void)ly_addObserverToObject:(id)object forKeyPath:(NSString *)keyPath action:(void(^)(id oldValue,id newValue))action identifier:(NSString *)identifier;
+ (void)ly_removeObserverToObject:(id)object forKeyPath:(NSString *)keyPath identifier:(NSString *)identifier;

@end

@interface LYSKeyedArchiverManager : NSObject

// 给一个类添加NSCoding协议
+ (void)ly_addNSCodingProtocolForClass:(Class)objcClass;

@end

/*
 * --- Documents 使用该路径放置关键数据，也就是不能通过App重新生成的数据。该路径可通过配置实现iTunes共享文件。可被iTunes备份。（现在保存在该路径下的文件还需要考虑iCloud同步),如数据库文件，或程序中浏览到的文件数据。如果进行备份会将此文件夹中的文件包括其中
 * --- Library 该路径下一般保存着用户配置文件。可创建子文件夹。可以用来放置您希望被备份但不希望被用户看到的数据。该路径下的文件夹，除Caches以外，都会被iTunes备份
 *     -- Caches 存放缓存文件，iTunes不会备份此目录，此目录下文件不会在应用退出删除
 *     -- Preferences 存储应用的默认设置及状态信息
 * --- tmp 提供一个即时创建临时文件的地方
 */

@interface LYSandboxManager : NSObject

// 获取沙盒路径
+ (NSString *)ly_sandboxPathForHomeDirectory;

+ (NSString *)ly_sandboxPathForDocument;
+ (NSString *)ly_sandboxPathForLibrary;
+ (NSString *)ly_sandboxPathForCaches;

// 拼接路径
+ (NSString *)ly_jointPathComponent:(NSString *)filePathA path:(NSString *)filePathB;
+ (NSString *)ly_jointPathExtension:(NSString *)filePathA path:(NSString *)filePathB;

// 创建目录
+ (BOOL)ly_createDirectoryFile:(NSString *)filePath;

// 创建文件
+ (BOOL)ly_createFile:(NSString *)filePath fileContent:(NSData *)fileData;


+ (BOOL)ly_removeFilePath:(NSString *)filePath;
+ (BOOL)ly_moveFilePath:(NSString *)filePathA toFilePath:(NSString *)filePathB;
+ (BOOL)ly_copyFilePath:(NSString *)fielPathA toFilePath:(NSString *)filePathB;

// 判断文件是否存在
+ (BOOL)ly_isExistAtPath:(NSString *)filePath;

// 获取文件属性
+ (NSDictionary *)ly_attributesForFilePath:(NSString *)filePath;

// 获取文件大小
+ (NSString *)ly_fileCreateDateForFilePath:(NSString *)filePath;

// 对文件进行写入操作
+ (BOOL)ly_writeToFilePath:(NSString *)filePath fileData:(NSData *)fileData;

// 对文件进行读操作
+ (NSData *)ly_readFilePath:(NSString *)filePath;

// 归档文件
+ (NSData *)ly_keyedArchiver:(id<NSCopying>)obj keyPath:(NSString *)keyPath;
+ (id<NSCopying>)ly_keyedUnarchiverData:(NSData *)mData keyPath:(NSString *)keyPath;
@end
