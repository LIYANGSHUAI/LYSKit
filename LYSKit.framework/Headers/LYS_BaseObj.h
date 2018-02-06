
#import <UIKit/UIKit.h>
#import <objc/runtime.h>

#pragma mark - 元组 -
#define LYSTuple(ONE,TWO) [LYSTupleManager ly_create:ONE two:TWO]

// LYSTupleManager 类,主要是模仿swift中的元组类,实现一个对象可以同时存储两个任意对象的效果

@class LYSTupleManager;

typedef LYSTupleManager* LYSTuple;

@interface LYSTupleManager : NSObject

// 用于存放要存储的对象
@property (nonatomic,strong,readonly)id one;
@property (nonatomic,strong,readonly)id two;

/**
 创建方法
 
 @param one                                 对象一
 @param two                                 对象二
 @return                                    模拟元组对象
 */
+ (instancetype)ly_create:(id)one two:(id)two;

@end

@interface LYSRuntimeManager : NSObject

/**
 获取对象的property属性列表,其中包括传入类的扩展中设置的属性
 
 @param className                           要获取属性列表的对象的class
 @return                                    对象class的属性列表数组
 */
+ (NSArray *)ly_getPropertyListForClass:(Class)className;

/**
 获取对象的Method方法列表
 
 @param className                           要获取方法列表的对象的class
 @return                                    对象class的方法列表数组
 */
+ (NSArray *)ly_getMethodListForClass:(Class)className;

/**
 获取Ivar成员变量列表
 
 @param className                           要获取成员变量列表的对象的class
 @return                                    对象class的成员变量列表数组
 */
+ (NSArray *)ly_getIvarListForClass:(Class)className;

/**
 获取Protocol协议列表
 
 @param className                           要获取协议列表的对象的class
 @return                                    对象class的协议列表数组
 */
+ (NSArray *)ly_getProtocolListForClass:(Class)className;

/**
 简单的为一个对象添加关联属性
 
 @param name                                属性的名称
 @param value                               属性的值
 @param object                              所要关联的对象
 */
+ (void)ly_associationPropertyName:(NSString *)name value:(id)value toObject:(id)object;

/**
 简单的获取一个对象的关联属性
 
 @param name                                属性的名称
 @param object                              被关联的对象
 @return                                    关联属性的值
 */
+ (id)ly_associationPropertyName:(NSString *)name toObject:(id)object;

/**
 移除对象的所有关联属性(慎用!这个方法一旦调用,这个对象所以的关联属性都被删除)
 
 @param object                              需要被移除对象的关联属性
 */
+ (void)ly_removeAssociationPropertyToObject:(id)object;

/**
 添加关联对象(这个方法用于给关联对象设置可监控的属性时)
 
 @param name                                要添加的属性名称
 @param value                               要添加的属性的值
 @param object                              需要关联的对象
 */
+ (void)ly_setAssociationPropertyName:(NSString *)name value:(id)value toObject:(id)object;

/**
 监测关联对象属性变化回调
 
 @param name                                要监测的属性名
 @param action                              监测的事件
 @param object                              监测的对象
 @param identifier                          监测事件的唯一标识(如果两个事件的标识一样,则后者会替代前者,不能为nil,可用于监测事件的删除)
 */
+ (void)ly_setAssociationPropertyMonitorName:(NSString *)name monitorAction:(BOOL(^)(NSString *name,id oldValue,id newValue))action toObject:(id)object identifier:(NSString *)identifier;

/**
 获取关联对象值(这个方法用于获取可监控关联对象的属性)
 
 @param name                                获取关联对象的属性
 @param object                              要获取属性值的对象
 @return                                    返回关联属性值
 */
+ (id)ly_getAssociationPropertyName:(NSString *)name toObject:(id)object;

/**
 移除关联对象(这个方法用于可监控关联对象的属性的移除)
 
 @param object                              所要移除的关联属性的对象
 */
+ (void)ly_removeAllAssociationPropertyForObject:(id)object;

/**
 移除某一关联属性(这个方法用于可监控关联对象的属性的移除)
 
 @param name                                移除关联对象的属性
 @param object                              关联的对象
 */
+ (void)ly_removeAssociationPropertyName:(NSString *)name toObject:(id)object;

/**
 移除某一关联属性的关联监测方法(这个方法用于可监控关联对象的属性的移除)
 
 @param name                                要移除的关联对象的属性
 @param identifier                          要移除监测方法的唯一标识
 @param object                              关联的对象
 */
+ (void)ly_removeAssociationPropertyName:(NSString *)name identifier:(NSString *)identifier toObject:(id)object;

/**
 获取对象的所有关联对象列表(这个方法用于可监控关联对象的属性的移除)
 
 @param object                              要获取关联属性的对象
 @return                                    返回对象的所有关联对象列表
 */
+ (NSArray *)ly_getAssociationPropertyListForObject:(id)object;

/**
 用一个实例方法实现部分去替换或者创建被替换对象的实例方法(默认的实例对象才会被被替换,类对象默认是不存在的,就会去创建一个和被替换方法名一样的实例方法)
 
 @param forClass                            需要被替换方法的对象
 @param forInstanceMethod                   需要被替换的方法(只能替换实例方法)
 @param fromClass                           来替换的方法所在的对象
 @param fromInstanceMethod                  用来替换的方法
 @return                                    返回替换操作是否成功,YES为成功,NO方法不存在
 */
+ (BOOL)ly_replaceMethodForClass:(Class)forClass forInstanceMethod:(SEL)forInstanceMethod fromClass:(Class)fromClass fromInstanceMethod:(SEL)fromInstanceMethod;

/**
 用一个类方法实现部分去替换或者创建被替换对象的实例方法(默认的实例对象才会被被替换,类对象默认是不存在的,就会去创建一个和被替换方法名一样的实例方法)
 
 @param forClass                            需要被替换方法的对象
 @param forInstanceMethod                   需要被替换的方法(只能替换实例方法)
 @param fromClass                           用来替换的方法所在的对象
 @param fromClassMethod                     用来替换的方法
 @return                                    返回替换操作是否成功,YES为成功,NO方法不存在
 */
+ (BOOL)ly_replaceMethodForClass:(Class)forClass forInstanceMethod:(SEL)forInstanceMethod fromClass:(Class)fromClass fromClassMethod:(SEL)fromClassMethod;

/**
 交换两个对象的某一Instance方法
 
 @param firstClass                          需要被替换方法的对象
 @param firstInstanceMethod                 需要被交换的方法
 @param secondClass                         需要被替换方法的对象
 @param secondInstanceMethod                需要被交换的方法
 */
+ (void)ly_exchangeMethodFirstClass:(Class)firstClass firstInstanceMethod:(SEL)firstInstanceMethod secondClass:(Class)secondClass secondInstanceMethod:(SEL)secondInstanceMethod;

/**
 交换某一对象的某一Class方法
 
 @param firstClass                          需要被替换方法的对象
 @param firstClassMethod                    需要被交换的方法
 @param secondClass                         需要被替换方法的对象
 @param secondClassMethod                   需要被交换的方法
 */
+ (void)ly_exchangeMethodFirstClass:(Class)firstClass firstClassMethod:(SEL)firstClassMethod secondClass:(Class)secondClass secondClassMethod:(SEL)secondClassMethod;

/**
 交换第一个对象的类方法和第二个对象的实例方法
 
 @param firstClass                          需要被替换方法的对象
 @param firstClassMethod                    需要被交换的方法
 @param secondClass                         需要被替换方法的对象
 @param secondInstanceMethod                需要被交换的方法
 */
+ (void)ly_exchangeMethodFirstClass:(Class)firstClass firstClassMethod:(SEL)firstClassMethod secondClass:(Class)secondClass secondInstanceMethod:(SEL)secondInstanceMethod;

/**
 给某一对象添加实例方法
 
 // 问题1:如果给一个对象添加另外一个对象里面的类方法,是可以添加成功的,但是这个对象不管是类调用还是实例调用都无法调用
 // 问题2:如果给一个对象添加另外一个对象里面的实例方法,是可以添加成功的,这个对象类调用是无法调用的,但是实例调用确实可以调用的
 
 @param forClass                            需要添加方法的对象
 @param fromClass                           方法所在的对象
 @param instanceSel                         需要添加的方法
 @return                                    返回添加操作是否成功
 */
+ (BOOL)ly_addMethodForClass:(Class)forClass fromClass:(Class)fromClass instanceSel:(SEL)instanceSel;

/**
 给某一对象添加类方法
 
 // 问题1:如果给一个对象添加另外一个对象里面的类方法,是可以添加成功的,但是这个对象不管是类调用还是实例调用都无法调用
 // 问题2:如果给一个对象添加另外一个对象里面的实例方法,是可以添加成功的,这个对象类调用是无法调用的,但是实例调用确实可以调用的
 
 @param forClass                            需要添加方法的对象
 @param fromClass                           方法所在的对象
 @param classSel                            需要添加的方法
 @return                                    返回添加操作是否成功
 */
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

/**
 获取系统串行队列
 
 @return                                    返回系统串行队列
 */
+ (dispatch_queue_t)ly_systemSerialQueue;

/**
 获取系统并行队列
 
 @return                                    返回系统并行队列
 */
+ (dispatch_queue_t)ly_systemParallelQueue;

/**
 创建自定义的串行队列
 
 @return                                    返回自定义创建的串行对类
 */
+ (dispatch_queue_t)ly_createSerialQueue;

/**
 创建自定义的并行队列
 
 @return                                    返回自定义创建的并行对类
 */
+ (dispatch_queue_t)ly_createParallelQueue;

/**
 向系统串行队列添加异步任务
 
 @param action                              异步任务
 */
+ (void)ly_addAsync_InSystemSerialQueue:(LYSGCDAction)action;

/**
 向系统并行队列添加异步任务
 
 @param action                              异步任务
 */
+ (void)ly_addAsync_InSystemParallelQueue:(LYSGCDAction)action;

/**
 向系统并行队列添加同步任务,(从上面表中可以看出,在系统串行队列中添加同步任务,会造成死锁,因此这里不在提供在系统串行队列中添加同步任务)
 
 @param action                              同步任务
 */
+ (void)ly_addSync_InSystemParallelQueue:(LYSGCDAction)action;

/**
 在自定义的队列添加异步任务
 
 @param action                              异步任务
 @param queue                               自定义的队列
 */
+ (void)ly_addAsync:(LYSGCDAction)action queue:(dispatch_queue_t)queue;

/**
 在自定义的队列添加同步任务
 
 @param action                              同步任务
 @param queue                               自定义的队列
 */
+ (void)ly_addSync:(LYSGCDAction)action queue:(dispatch_queue_t)queue;

/**
 障碍任务
 
 @param firstAction                         先完成的任务,ly_add_Barrier_AsyncAction: queue:调用此方法进行添加
 @param actionBarrier                       障碍任务
 @param completeAction                      最后完成的任务
 */
+ (void)ly_add_Barrier_Async:(LYSGCDActionQueue)firstAction barrierAction:(LYSGCDAction)actionBarrier lastAction:(LYSGCDAction)completeAction;


/**
 添加障碍任务,配合上面的方法
 
 @param firstAction                         任务
 @param queue                               队列
 */
+ (void)ly_add_Barrier_AsyncAction:(LYSGCDAction)firstAction queue:(dispatch_queue_t)queue;

/**
 延迟任务
 
 @param interval                            延迟的时间
 @param action                              延迟事件
 */
+ (void)ly_addAfter:(NSTimeInterval)interval action:(LYSGCDAction)action;

/**
 重复任务
 
 @param num                                 重复的次数
 @param action                              重复的事件
 */
+ (void)ly_addRepeat:(NSInteger)num action:(LYSGCDAction)action;

/**
 一次任务
 
 @param action                              执行的任务
 */
+ (void)ly_addOnceAction:(LYSGCDAction)action;

/**
 等待任务ly_add_Group_AsyncAction: group: queue:调用此方法进行添加
 
 @param firstAction                         先执行的任务
 @param action                              其他任务完成后执行的任务
 */
+ (void)ly_add_Group_AsyncAction:(void(^)(dispatch_group_t group,dispatch_queue_t queue))firstAction notifyAction:(LYSGCDAction)action;

/**
 添加等待任务,配合上面方法
 
 @param firstAction                         任务体
 */
+ (void)ly_add_Group_AsyncAction:(LYSGCDAction)firstAction group:(dispatch_group_t)group queue:(dispatch_queue_t)queue;

@end

@interface LYSKVOManager : NSObject

/**
 添加观察者,实现原理是实现 observeValueForKeyPath: ofObject: change: context:方法,一次使用该方法进行属性监测时,不要重新这个系统方法,否则会失效
 
 @param object                              需要被观察的对象
 @param keyPath                             需要被观察的属性
 @param action                              观察属性监测事件
 @param identifier                          观察属性的标识(可用于移除)
 */
+ (void)ly_addObserverToObject:(id)object forKeyPath:(NSString *)keyPath action:(void(^)(id oldValue,id newValue))action identifier:(NSString *)identifier;

/**
 移除观察函数
 
 @param object                              被观察的对象
 @param keyPath                             被观察的属性
 @param identifier                          监测事件的标识
 */
+ (void)ly_removeObserverToObject:(id)object forKeyPath:(NSString *)keyPath identifier:(NSString *)identifier;

@end

@interface LYSKeyedArchiverManager : NSObject

/**
 给一个类添加NSCoding协议
 
 @param objcClass                           需要被添加协议的类
 */
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
