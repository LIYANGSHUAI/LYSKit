
#import <UIKit/UIKit.h>

// 常用的一些日期拼接格式
extern NSString *const LYSDateFormatterStandardDateFormatBar;     // YYYY-MM-dd HH:mm:ss
extern NSString *const LYSDateFormatterStandardDateFormatSlash;   // YYYY/MM/dd HH:mm:ss
extern NSString *const LYSDateFormatterGregorianCalendarBar;      // YYYY-MM-dd
extern NSString *const LYSDateFormatterGregorianCalendarSlash;    // YYYY/MM/dd
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

@interface NSDate (LYSCategory)

// NSDate对象转日期字符串
+ (NSString *)ly_stringWithDate:(NSDate *)date formatter:(NSString *)formatStr;
+ (NSString *)ly_stringWithCurrentDateFormatter:(NSString *)formatStr;
- (NSString *)ly_stringWithFormatter:(NSString *)formatStr;

// 日期字符串转NSDate对象,这里要注意一点就是,后面的日期格式要和前面的日期字符串一致
+ (NSDate *)ly_dateWithString:(NSString *)dateStr formatter:(NSString *)formatStr;

// 传入时间和当前时间进行比较
+ (NSString *)ly_compareCurrentTime:(NSDate *)compareDate;

// 获取固定时间间隔之后的时间
+ (NSDate *)ly_dateSincleNow:(NSInteger)num;

// 获取明天和昨天
+ (NSDate *)ly_dateTomorrow;
+ (NSDate *)ly_dateYesterday;

@end

@interface NSDictionary (LYSCategory)

// 把字典转换成字符串格式(与NSString+LYCategory.h中ly_toDictionary方法对应)
- (NSString *)ly_toString;

// 快速打印模型属性信息
+ (NSString *)ly_createPropertyCodeWithDict:(NSDictionary *)dict;

@end

// 区分电话号码类型
typedef NS_ENUM(NSUInteger, LYSTelephoneNumber) {
    LYSTelephoneNumberYiDong,                                 // 移动
    MyEnumValueBLYSTelephoneNumberLiTong,                     // 联通
    MyEnumValueCLYSTelephoneNumberGuHua,                      // 固话
    LYSTelephoneNumberUnKnow                                  // 未知
};

@interface NSString (LYSCategory)

// 转换换成对应类型
- (NSData *)ly_toData;
- (NSDictionary *)ly_toDictionary;

// 去掉字符串结尾换行和空格
- (NSString *)ly_stringClearWhitespaceAndNewLine;

// 获取字符串在指定区域的预计占用Rect
- (CGRect)ly_rectWithSize:(CGSize)size attributes:(NSDictionary<NSString *,id> *)attributes;

// 获取首字母
- (NSString *)ly_firstLatter;

// 获取字符串拼音
- (NSString *)ly_firstCharactor;

// 判断是不是手机号
- (LYSTelephoneNumber)ly_telePhoneNumBer;

// 用一个参照字符串,把另外一个字符串,拆分成数组
- (NSArray<NSString *> *)ly_splitWithString:(NSString *)separator;

// 判断字符串是否以固定字符串开头或者结尾
- (BOOL)ly_hasPrefix:(NSString *)str;
- (BOOL)ly_hasSuffix:(NSString *)str;

@end

@interface UIColor (LYSCategory)

// 十六进制转color
+ (UIColor *)ly_hex:(NSString *)hexStr;

@end

@interface UIImage (LYSCategory)

// 创建一个给定透明度的图片
+ (UIImage *)ly_imageWithColor:(UIColor *)color alpha:(CGFloat)alpha;

// 截图功能
+ (UIImage *)ly_screenShot:(CGSize)size withTargetView:(UIView *)targetView;

// 下载图片(使用UIImage自带的一种加载网络图片的方法实现下载功能)
+ (UIImage *)ly_downloadNetworkImageURL:(NSString *)urlStr;

// 循环压缩图片
- (NSData *)ly_compressionImageWithMaxWidth:(CGFloat)maxWidth limitSize:(NSInteger)limitSize;

@end

@interface UINavigationBar (LYSCategory)

// 隐藏导航底部细线
- (void)ly_hiddenNavigationBarBottomLine;

// 导航条背景图片
- (void)ly_hiddenBackgroundImage;
- (void)ly_setBackgroundImage:(UIImage *)image;

@end

@interface UITabBar (LYSCategory)

// 隐藏导航条顶部细线
- (void)ly_hiddenTabbarBottomLine;

// 导航条背景图片
- (void)ly_hiddenBackgroundImage;
- (void)ly_setBackgroundImage:(UIImage *)image;

@end

/**
 控件振动的方向
 
 - LYSQHLDirectionHorizontal: 垂直方向
 - LYSQHLDirectionVertical: 水平方向
 */

typedef NS_ENUM(NSInteger, LYSQHLDirection) {
    LYSQHLDirectionHorizontal,
    LYSQHLDirectionVertical
};

@interface UIView (LYSCategory)

// 传一个振动的次数,振动的速度,振动的幅度和振动的方向
- (void)ly_shakeWithShakeDirection:(LYSQHLDirection)shakeDirection;
- (void)ly_shakeWithTimes:(NSInteger)times shakeDirection:(LYSQHLDirection)shakeDirection;
- (void)ly_shakeWithTimes:(NSInteger)times speed:(CGFloat)speed shakeDirection:(LYSQHLDirection)shakeDirection;
- (void)ly_shakeWithTimes:(NSInteger)times speed:(CGFloat)speed range:(CGFloat)range shakeDirection:(LYSQHLDirection)shakeDirection;

// 获取某个view的叶子View(一般为Window)
- (NSMutableArray *)ly_getTopSubViews;

// 获取当前视图所在的根视图控制器
- (UIViewController*)ly_getRootViewController;

// 加载圈
- (void)ly_showLoadingWithColor:(UIColor *)color;
- (void)ly_hiddenLoadingView;

// 给一个视图控件添加点击手势
- (void)ly_tapGesture:(void(^)(UITapGestureRecognizer *sender,UIView *view))tapGesture tapNum:(NSInteger)tapNum touchNum:(NSInteger)touchNum;

@end

@interface UIViewController (LYSCategory)

// 获取最外层的视图控制器
+ (UIViewController *)ly_getOuterViewController;

// 判断一个控制器是否正在显示
+ (BOOL)ly_currentViewControllerVisible:(UIViewController *)viewController;


// 自定义弹窗
- (void)ly_alertTitle:(NSString *)title message:(NSString *)message itemTitles:(NSArray<NSString *> *(^)(void))itemTitles itemActions:(void(^)(NSInteger index))itemActions NS_AVAILABLE_IOS(8.0);

+ (void)ly_alertTitle:(NSString *)title message:(NSString *)message itemTitles:(NSArray<NSString *> *(^)(void))itemTitles itemActions:(void(^)(NSInteger index))itemActions NS_AVAILABLE_IOS(8.0);

- (void)ly_alertTitle:(NSString *)title message:(NSString *)message leftStr:(NSString *)leftStr leftAction:(void(^)(void))leftAction rightStr:(NSString *)rightStr rightAction:(void(^)(void))rightAction NS_AVAILABLE_IOS(8.0);

+ (void)ly_alertTitle:(NSString *)title message:(NSString *)message leftStr:(NSString *)leftStr leftAction:(void(^)(void))leftAction rightStr:(NSString *)rightStr rightAction:(void(^)(void))rightAction NS_AVAILABLE_IOS(8.0);

- (void)ly_alertTitle:(NSString *)title message:(NSString *)message textfieldPlaceholder:(NSArray<NSString *> *)placeholders leftStr:(NSString *)leftStr leftAction:(void(^)(NSArray<UITextField *> *textFields))leftAction rightStr:(NSString *)rightStr rightAction:(void(^)(NSArray<UITextField *> *textFields))rightAction NS_AVAILABLE_IOS(8.0);

+ (void)ly_alertTitle:(NSString *)title message:(NSString *)message textfieldPlaceholder:(NSArray<NSString *> *)placeholders leftStr:(NSString *)leftStr leftAction:(void(^)(NSArray<UITextField *> *textFields))leftAction rightStr:(NSString *)rightStr rightAction:(void(^)(NSArray<UITextField *> *textFields))rightAction NS_AVAILABLE_IOS(8.0);

- (void)ly_alertTitle:(NSString *)title message:(NSString *)message comfirmStr:(NSString *)comfirmStr comfirmAction:(void(^)(void))comfirmAction NS_AVAILABLE_IOS(8.0);

+ (void)ly_alertTitle:(NSString *)title message:(NSString *)message comfirmStr:(NSString *)comfirmStr comfirmAction:(void(^)(void))comfirmAction NS_AVAILABLE_IOS(8.0);

- (void)ly_alertTitle:(NSString *)title message:(NSString *)message preferredStyle:(UIAlertControllerStyle)preferredStyle actionTitles:(NSArray<NSString *> *)actionTitles clickAction:(void(^)(NSInteger index))clickAction cancelStr:(NSString *)cancelStr cancelAction:(void(^)(void))cancelAction NS_AVAILABLE_IOS(8.0);

+ (void)ly_alertTitle:(NSString *)title message:(NSString *)message preferredStyle:(UIAlertControllerStyle)preferredStyle actionTitles:(NSArray<NSString *> *)actionTitles clickAction:(void(^)(NSInteger index))clickAction cancelStr:(NSString *)cancelStr cancelAction:(void(^)(void))cancelAction NS_AVAILABLE_IOS(8.0);

@end
