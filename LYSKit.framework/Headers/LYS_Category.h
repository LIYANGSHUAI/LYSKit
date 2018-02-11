
#import "LYS_BaseObj.h"

#pragma mark - 常用的一些日期拼接格式 -

extern NSString *const LYSDateFormatterStandardDateFormatBar;     // yyyy-MM-dd HH:mm:ss
extern NSString *const LYSDateFormatterStandardDateFormatSlash;   // yyyy/MM/dd HH:mm:ss
extern NSString *const LYSDateFormatterGregorianCalendarBar;      // yyyy-MM-dd
extern NSString *const LYSDateFormatterGregorianCalendarSlash;    // yyyy/MM/dd
extern NSString *const LYSDateFormatterTime;                      // HH:mm:ss

/*
 *  YYYY:        年
 *  M/MM:   1~12 月
 *  MMM:    Jan/Feb/Mar/Apr/May/Jun/Jul/Aug/Sep/Oct/Nov/Dec月
 *  MMMM:   January/February/March/April/May/June/July/August/September/October/November/December月
 *
 *  d:      1~31 日
 *  H:      1~24 时 (24小时制)
 *  h:      1~12 时 (12小时制)
 *  m:      0~59 分
 *  s:      0~59 秒
 */

#pragma mark - 常用日期NSDate方法 -

@interface NSDate (LYSCategory)

/**
 将传入的日期转换成对应格式的字符串
 
 @param date                                待转换的日期
 @param formatStr                           需要转换成的格式
 @return                                    最终转换后的字符串
 */
+ (NSString *)ly_stringWithDate:(NSDate *)date formatter:(NSString *)formatStr;

/**
 将当前日期转换成对应格式的字符串
 
 @param formatStr                           需要转换成的格式
 @return                                    最终转换后的字符串
 */
+ (NSString *)ly_stringWithCurrentDateFormatter:(NSString *)formatStr;

/**
 将当前日期转换成对应格式的字符串
 
 @param formatStr                           需要转换成的格式
 @return                                    最终转换后的字符串
 */
- (NSString *)ly_stringWithFormatter:(NSString *)formatStr;

/**
 将传入固定格式的日期字符串转成对应的NSDate对象(此时,要保证日期字符串格式和传入对应的格式一致)
 
 @param dateStr                             时间字符串形式
 @param formatStr                           时间格式
 @return                                    返回对应的时间对象
 */
+ (NSDate *)ly_dateWithString:(NSString *)dateStr formatter:(NSString *)formatStr;

/**
 将传入的NSDate对象和当前时间的NSDate比较,获取比较结果
 
 @param compareDate                         和当前时间做比较的时间
 @return                                    返回比较的结果
 */
+ (NSString *)ly_compareCurrentTime:(NSDate *)compareDate;

/**
 获取n个24小时之后的NSDate
 
 @param num                                 小时的个数
 @return                                    返回预订的日期
 */
+ (NSDate *)ly_dateSincleNow:(NSInteger)num;

/**
 获取明天的这个时间点的NSDate
 
 @return                                    返回预订的日期
 */
+ (NSDate *)ly_dateTomorrow;

/**
 获取昨天的这个时间点的NSDate
 
 @return                                    返回预订的日期
 */
+ (NSDate *)ly_dateYesterday;

@end

#pragma mark - 常用字典类型NSDictionary方法 -

@interface NSDictionary (LYSCategory)

/**
 把字典转换成二进制
 
 @return                                    返回对应二进制数据
 */
- (NSData *)ly_toData;

/**
 把字典转换成字符串
 
 @return                                    字符串格式
 */
- (NSString *)ly_toString;

/**
 快速打印模型属性信息
 
 @param dict                                字符串
 @return                                    返回对应的属性模型
 */
+ (NSString *)ly_createPropertyCodeWithDict:(NSDictionary *)dict;

@end

#pragma mark - 常用手机运营商枚举值 区分电话号码类型-

typedef NS_ENUM(NSUInteger, LYSTelephoneNumber) {
    LYSTelephoneNumberYiDong,                                 // 移动
    LYSTelephoneNumberLiTong,                                 // 联通
    LYSTelephoneNumberGuHua,                                  // 固话
    LYSTelephoneNumberUnKnow                                  // 未知
};

#pragma mark - 常用字符串NSString方法 -

@interface NSString (LYSCategory)

/**
 将字符串转换成NSData
 
 @return                                    返回NSData对象
 */
- (NSData *)ly_toData;

/**
 将字符串转换为字典
 
 @return                                    字典格式
 */
- (NSDictionary *)ly_toDictionary;

/**
 去掉字符串结尾换行和空格
 
 @return                                    返回转换后的字符串
 */
- (NSString *)ly_stringClearWhitespaceAndNewLine;

/**
 获取字符串在指定区域的预计占用Rect
 
 @param size                                指定区域
 @param attributes                          预计字符串参数
 @return                                    返回预计Rect
 */
- (CGRect)ly_rectWithSize:(CGSize)size attributes:(NSDictionary<NSString *,id> *)attributes;

/**
 获取首字母
 
 @return                                    返回字符串的首字母
 */
- (NSString *)ly_firstLatter;

/**
 获取字符串拼音
 
 @return                                    返回字符串的拼音
 */
- (NSString *)ly_toPinyin;

/**
 判断是不是手机号,以及手机号运营商名称,具体类型可查看LYSTelephoneNumber类型
 
 @return                                    返回手机号的类别
 */
- (LYSTelephoneNumber)ly_telePhoneNumBer;

/**
 用一个参照字符串,把另外一个字符串,拆分成数组
 
 @param separator                           参照字符串
 @return                                    拆分后的数组
 */
- (NSArray<NSString *> *)ly_splitWithString:(NSString *)separator;

/**
 判断一个字符串是否以另外一个字符串开头
 
 @param str                                 开头字符串
 @return                                    返回计算结果
 */
- (BOOL)ly_hasPrefix:(NSString *)str;

/**
 判断一个字符串是否以另外一个字符串结尾
 
 @param str                                 结尾字符串
 @return                                    返回计算结果
 */
- (BOOL)ly_hasSuffix:(NSString *)str;

@end

#pragma mark - 常用颜色UIColor方法 -

@interface UIColor (LYSCategory)

/**
 将十六进制转对应的UIColor
 
 @param hexStr                              颜色十六进制
 @return                                    对应的color
 */
+ (UIColor *)ly_hex:(NSString *)hexStr;

@end

#pragma mark - 常用图片UIImage方法 -

@interface UIImage (LYSCategory)

/**
 创建一个给定透明度的图片
 
 @param color                               颜色
 @param alpha                               透明度
 @return                                    返回图片
 */
+ (UIImage *)ly_imageWithColor:(UIColor *)color alpha:(CGFloat)alpha;

/**
 截图功能
 
 @param size                                截图出来的视图大小
 @param targetView                          要截的视图
 @return                                    返回image图片
 */
+ (UIImage *)ly_screenShot:(CGSize)size withTargetView:(UIView *)targetView;

/**
 下载图片
 
 @param urlStr                              图片的地址
 @return                                    返回的图片
 */
+ (UIImage *)ly_downloadNetworkImageURL:(NSString *)urlStr;

/**
 循环压缩图片
 
 @param maxWidth                            图片的宽度
 @param limitSize                           图片的大小
 @return                                    压缩后的图片
 */
- (NSData *)ly_compressionImageWithMaxWidth:(CGFloat)maxWidth limitSize:(NSInteger)limitSize;

@end

#pragma mark - 常用导航UINavigationBar方法 -

@interface UINavigationBar (LYSCategory)

/**
 隐藏导航底部细线
 */
- (void)ly_hiddenNavigationBarBottomLine;

/**
 显示导航底部细线
 */
- (void)ly_showNavigationBarBottomLine;

/**
 隐藏导航条背景图片
 */
- (void)ly_hiddenBackgroundImage;

/**
 设置导航背景图片
 
 @param image                               背景图片
 */
- (void)ly_setBackgroundImage:(UIImage *)image;

@end

#pragma mark - 常用底部导航UITabBar方法 -

@interface UITabBar (LYSCategory)

/**
 隐藏导航条顶部线的alpha
 */
- (void)ly_hiddenTabbarTopLine;

/**
 显示导航条顶部线的alpha
 */
- (void)ly_showTabbarTopLine;

/**
 隐藏导航条背景图片
 */
- (void)ly_hiddenBackgroundImage;

/**
 设置背景图片
 
 @param image                               设置背景图片
 */
- (void)ly_setBackgroundImage:(UIImage *)image;

@end

#pragma mark - UIView视图振动方向枚举值 -

/**
 控件振动的方向
 
 - LYSQHLDirectionHorizontal:               垂直方向
 - LYSQHLDirectionVertical:                 水平方向
 */

typedef NS_ENUM(NSInteger, LYSQHLDirection) {
    LYSQHLDirectionHorizontal,
    LYSQHLDirectionVertical
};

#pragma mark - 常用视图UIView方法 -

@interface UIView (LYSCategory)

/**
 获取某个view的叶子View(一般为Window)
 
 @return                                    叶子view数组
 */
- (NSMutableArray *)ly_getTopSubViews;

/**
 获取当前视图所在的根视图控制器
 
 @return                                    返回跟视图控制器
 */
- (UIViewController*)ly_getRootViewController;

/**
 传一个振动的方向,具体方向可查看LYSQHLDirection类型
 
 @param shakeDirection 振动的方向
 */
- (void)ly_shakeWithShakeDirection:(LYSQHLDirection)shakeDirection;

/**
 传一个振动的次数和振动的方向,具体方向可查看LYSQHLDirection类型
 
 @param times                               振动的次数
 @param shakeDirection                      振动的方向
 */
- (void)ly_shakeWithTimes:(NSInteger)times shakeDirection:(LYSQHLDirection)shakeDirection;

/**
 传一个振动的次数,振动的速度和振动的方向,具体方向可查看LYSQHLDirection类型
 
 @param times                               振动的次数
 @param speed                               振动的速度
 @param shakeDirection                      振动的方向
 */
- (void)ly_shakeWithTimes:(NSInteger)times speed:(CGFloat)speed shakeDirection:(LYSQHLDirection)shakeDirection;

/**
 传一个振动的次数,振动的速度,振动的幅度和振动的方向,具体方向可查看LYSQHLDirection类型
 
 @param times                               振动的次数
 @param speed                               振动的速度
 @param range                               振动的幅度
 @param shakeDirection                      振动的方向
 */
- (void)ly_shakeWithTimes:(NSInteger)times speed:(CGFloat)speed range:(CGFloat)range shakeDirection:(LYSQHLDirection)shakeDirection;

/**
 添加加载圈
 
 @param color                               加载圈的颜色
 */
- (void)ly_showLoadingWithColor:(UIColor *)color;

/**
 隐藏加载圈
 */
- (void)ly_hiddenLoadingView;

/**
 给一个视图控件添加点击手势
 
 @param tapGesture                          手势回调
 @param tapNum                              触发回调的点击次数
 @param touchNum                            触发回调的手指个数
 */
- (void)ly_tapGesture:(void(^)(UITapGestureRecognizer *sender,UIView *view))tapGesture tapNum:(NSInteger)tapNum touchNum:(NSInteger)touchNum;

@end

#pragma mark - 常用控制器UIViewController方法 -

@interface UIViewController (LYSCategory)

/**
 获取最外层控制器
 
 @return                                    返回控制器
 */
+ (UIViewController *)ly_getOuterViewController;

/**
 判断这个控制器是否正在显示
 
 @param viewController                      需要判断的控制器
 @return                                    返回判断结果
 */
+ (BOOL)ly_currentViewControllerVisible:(UIViewController *)viewController;

/**
 弹出一个左右按钮的弹窗
 
 @param title                               标题
 @param message                             副标题
 @param leftStr                             左按钮
 @param leftAction                          左按钮事件
 @param rightStr                            右按钮
 @param rightAction                         右按钮事件
 */
- (void)ly_alertTitle:(NSString *)title message:(NSString *)message leftStr:(NSString *)leftStr leftAction:(void(^)(void))leftAction rightStr:(NSString *)rightStr rightAction:(void(^)(void))rightAction;

/**
 弹出一个左右按钮的弹窗
 
 @param title                               标题
 @param message                             副标题
 @param leftStr                             左按钮
 @param leftAction                          左按钮事件
 @param rightStr                            右按钮
 @param rightAction                         右按钮事件
 */
+ (void)ly_alertTitle:(NSString *)title message:(NSString *)message leftStr:(NSString *)leftStr leftAction:(void(^)(void))leftAction rightStr:(NSString *)rightStr rightAction:(void(^)(void))rightAction;

/**
 弹出一个只有一个按钮的弹窗
 
 @param title                               标题
 @param message                             副标题
 @param comfirmStr                          按钮
 @param comfirmAction                       按钮事件
 */
- (void)ly_alertTitle:(NSString *)title message:(NSString *)message comfirmStr:(NSString *)comfirmStr comfirmAction:(void(^)(void))comfirmAction;

/**
 弹出一个只有一个按钮的弹窗
 
 @param title                               标题
 @param message                             副标题
 @param comfirmStr                          按钮
 @param comfirmAction                       按钮事件
 */
+ (void)ly_alertTitle:(NSString *)title message:(NSString *)message comfirmStr:(NSString *)comfirmStr comfirmAction:(void(^)(void))comfirmAction;

/**
 弹出一个多个按钮的弹窗,并且附带取消按钮
 
 @param title                               标题
 @param message                             副标题
 @param preferredStyle                      弹窗样式
 @param actionTitles                        按钮
 @param clickAction                         按钮事件
 @param cancelStr                           取消
 @param cancelAction                        取消事件
 */
- (void)ly_alertTitle:(NSString *)title message:(NSString *)message preferredStyle:(UIAlertControllerStyle)preferredStyle actionTitles:(NSArray<NSString *> *)actionTitles clickAction:(void(^)(NSInteger index))clickAction cancelStr:(NSString *)cancelStr cancelAction:(void(^)(void))cancelAction;

/**
 弹出一个多个按钮的弹窗,并且附带取消按钮
 
 @param title                               标题
 @param message                             副标题
 @param preferredStyle                      弹窗样式
 @param actionTitles                        按钮
 @param clickAction                         按钮事件
 @param cancelStr                           取消
 @param cancelAction                        取消事件
 */
+ (void)ly_alertTitle:(NSString *)title message:(NSString *)message preferredStyle:(UIAlertControllerStyle)preferredStyle actionTitles:(NSArray<NSString *> *)actionTitles clickAction:(void(^)(NSInteger index))clickAction cancelStr:(NSString *)cancelStr cancelAction:(void(^)(void))cancelAction;

/**
 弹出一个多个按钮的弹窗,并且附带取消按钮
 
 @param title                               标题
 @param message                             副标题
 @param placeholders                        输入框
 @param actionTitles                        按钮
 @param clickAction                         按钮事件
 @param cancelStr                           取消
 @param cancelAction                        取消事件
 */
- (void)ly_alertTitle:(NSString *)title message:(NSString *)message textfieldPlaceholder:(NSArray<NSString *> *)placeholders actionTitles:(NSArray<NSString *> *)actionTitles clickAction:(void(^)(NSInteger index))clickAction cancelStr:(NSString *)cancelStr cancelAction:(void(^)(void))cancelAction;

/**
 弹出一个多个按钮的弹窗,并且附带取消按钮
 
 @param title                               标题
 @param message                             副标题
 @param placeholders                        输入框
 @param actionTitles                        按钮
 @param clickAction                         按钮事件
 @param cancelStr                           取消
 @param cancelAction                        取消事件
 */
+ (void)ly_alertTitle:(NSString *)title message:(NSString *)message textfieldPlaceholder:(NSArray<NSString *> *)placeholders actionTitles:(NSArray<NSString *> *)actionTitles clickAction:(void(^)(NSInteger index))clickAction cancelStr:(NSString *)cancelStr cancelAction:(void(^)(void))cancelAction;

@end
