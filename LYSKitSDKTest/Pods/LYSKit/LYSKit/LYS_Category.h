//
//  LYS_Category.h
//  LYSKitDemo
//
//  Created by HENAN on 2017/11/9.
//  Copyright © 2017年 HENAN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSDate (LYSCategory)

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

/**
 类方法,获取给定日期字符串显示
 
 @param date 需要转换的日期
 @param formatStr 转换的格式
 @return 时间的字符串形式
 */
+ (NSString *)ly_stringWithDate:(NSDate *)date
                      formatter:(NSString *)formatStr;

/**
 类方法,获取当前日期字符串显示
 
 @param formatStr 转换的格式
 @return 时间的字符串形式
 */
+ (NSString *)ly_stringWithCurrentDateFormatter:(NSString *)formatStr;

/**
 实例方法,获取当前日期字符串显示
 
 @param formatStr 转换的格式
 @return 时间的字符串形式
 */
- (NSString *)ly_stringWithFormatter:(NSString *)formatStr;

/**
 字符串转日期
 
 @param dateStr 时间字符串形式
 @param formatStr 时间格式
 @return 返回对应的时间对象
 */
+ (NSDate *)ly_dateWithStr:(NSString *)dateStr
                 formatter:(NSString *)formatStr;

/**
 指定时间和当前时间比较
 
 @param compareDate 和当前时间做比较的时间
 @return 返回比较的结果
 */
+ (NSString *)ly_compareCurrentTime:(NSDate*)compareDate;

/**
 获取n个24小时之后的NSDate
 
 @param num 小时的个数
 @return 返回预订的日期
 */
+ (NSDate *)ly_dateSincleNow:(NSInteger)num;

/**
 获取明天的这个时间点的NSDate
 
 @return 返回预订的日期
 */
+ (NSDate *)ly_dateTomorrow;

/**
 获取昨天的这个时间点的NSDate
 
 @return 返回预订的日期
 */
+ (NSDate *)ly_dateYesterday;

@end

@interface NSDictionary (LYSCategory)
/**
 把字典转换成字符串格式(与NSString+LYCategory.h中ly_dictionary方法对应)
 
 @return 字符串格式
 */
- (NSString *)ly_string;

/**
 快速打印模型属性信息
 
 @param dict 字符串
 */
+ (void)ly_createPropertyCodeWithDict:(NSDictionary *)dict;

@end

@interface NSString (LYSCategory)

/**
 转换成NSData类型
 
 @return 返回NSData对象
 */
- (NSData *)ly_NSData;

/**
 字符串转换为字典(与NSDictionary+LYCategory.h中ly_string方法对应)
 
 @return 字典格式
 */
- (NSDictionary *)ly_dictionary;

/**
 去掉字符串结尾换行和空格
 
 @return 返回转换后的字符串
 */
- (NSString *)ly_stringClearWhitespaceAndNewLine;

/**
 获取字符串在指定区域的预计占用Rect
 
 @param size 指定区域
 @param attributes 预计字符串参数
 @return 返回预计Rect
 */
- (CGRect)ly_rectWithSize:(CGSize)size
               attributes:(NSDictionary<NSString *,id> *)attributes;

/**
 获取首字母
 
 @return 返回字符串的首字母
 */
- (NSString *)ly_firstLatter;

/**
 获取字符串拼音
 
 @return 返回字符串的拼音
 */
- (NSString *)ly_firstCharactor;

/**
 判断是不是手机号
 
 @return 返回手机号的类别
 */
- (NSString *)ly_telePhoneNumBer;

@end

@interface UIColor (LYSCategory)

/**
 十六进制转color
 
 @param hexStr 颜色十六进制
 @return 对应的color
 */
+ (UIColor *)ly_hex:(NSString *)hexStr;
@end

@interface UIImage (LYSCategory)

/**
 创建一个给定透明度的图片
 
 @param color 颜色
 @param alpha 透明度
 @return 返回图片
 */
+ (UIImage *)ly_imageWithColor:(UIColor *)color
                         alpha:(CGFloat)alpha;

/**
 截图功能
 
 @param size 截图出来的视图大小
 @param targetView 要截的视图
 @return 返回image图片
 */
+ (UIImage *)ly_screenShot:(CGSize)size
            withTargetView:(UIView *)targetView;

/**
 下载图片(使用UIImage自带的一种加载网络图片的方法实现下载功能)
 
 @param urlStr 图片的地址
 @return 返回的图片
 */
+ (UIImage *)ly_downloadNetworkImageURL:(NSString *)urlStr;

/**
 循环压缩图片
 
 @param maxWidth 图片的宽度
 @param limitSize 图片的大小
 @return 压缩后的图片
 */
- (NSData *)ly_compressionImageWithMaxWidth:(CGFloat)maxWidth
                                  limitSize:(NSInteger)limitSize;
@end

@interface UINavigationBar (LYSCategory)

/**
 获取导航底部细线
 
 @return 返回细线视图
 */
- (UIView *)ly_navigationBarBottomLine;

/**
 隐藏导航条背景图片
 */
- (void)ly_hiddenBackgroundImage;

/**
 隐藏背景图片,并给一个给定alpha的图片
 
 @param color 背景图片的颜色
 @param alpha 背景图片的透明度
 */
- (void)ly_hiddenAndSetBackgroundImageColor:(UIColor *)color
                                      alpha:(CGFloat)alpha;

/**
 设置导航背景图片
 
 @param image 背景图片
 */
- (void)ly_setBackgroundImage:(UIImage *)image;
@end

@interface UITabBar (LYSCategory)
/**
 设置导航条顶部线的alpha
 
 @param color 颜色
 @param alpha 透明度
 */
- (void)ly_setBarButtonLineColor:(UIColor *)color
                           alpha:(CGFloat)alpha;

/**
 隐藏导航条背景图片
 */
- (void)ly_hiddenBackgroundImage;

/**
 隐藏背景图片,并给一个给定alpha的图片
 
 @param color 颜色
 @param alpha 透明度
 */
- (void)ly_hiddenAndSetBackgroundImageColor:(UIColor *)color
                                      alpha:(CGFloat)alpha;

/**
 设置背景图片
 
 @param image 设置背景图片
 */
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
/**
 获取某个view的叶子View(一般为Window)
 
 @return 叶子view数组
 */
- (NSMutableArray *)ly_getTopSubViews;

/**
 获取当前视图所在的根视图控制器
 
 @return 返回跟视图控制器
 */
- (UIViewController*)ly_getRootViewController;

/**
 传一个振动的方向
 
 @param shakeDirection 振动的方向
 */
- (void)ly_shakeWithShakeDirection:(LYSQHLDirection)shakeDirection;

/**
 传一个振动的次数和振动的方向
 
 @param times 振动的次数
 @param shakeDirection 振动的方向
 */
- (void)ly_shakeWithTimes:(NSInteger)times
           shakeDirection:(LYSQHLDirection)shakeDirection;

/**
 传一个振动的次数,振动的速度和振动的方向
 
 @param times 振动的次数
 @param speed 振动的速度
 @param shakeDirection 振动的方向
 */
- (void)ly_shakeWithTimes:(NSInteger)times
                    speed:(CGFloat)speed
           shakeDirection:(LYSQHLDirection)shakeDirection;

/**
 传一个振动的次数,振动的速度,振动的幅度和振动的方向
 
 @param times 振动的次数
 @param speed 振动的速度
 @param range 振动的幅度
 @param shakeDirection 振动的方向
 */
- (void)ly_shakeWithTimes:(NSInteger)times
                    speed:(CGFloat)speed
                    range:(CGFloat)range
           shakeDirection:(LYSQHLDirection)shakeDirection;

/**
 添加加载圈
 
 @param color 加载圈的颜色
 */
- (void)ly_showLoadingWithColor:(UIColor *)color;

/**
 隐藏加载圈
 */
- (void)ly_hiddenLoadingView;

/**
 给一个视图控件添加点击手势
 
 @param tapGesture 手势回调
 @param tapNum 触发回调的点击次数
 @param touchNum 触发回调的手指个数
 */
- (void)ly_tapGesture:(void(^)(UITapGestureRecognizer *sender,UIView *view))tapGesture
               tapNum:(NSInteger)tapNum
             touchNum:(NSInteger)touchNum;
@end

@interface UIViewController (LYSCategory)
/**
 获取最外层的视图控制器
 
 @return 返回最外层的视图控制器
 */
+ (UIViewController *)ly_getOuterViewController;

/**
 实例方法弹出窗口,窗口样式默认是UIAlertControllerStyleAlert类型
 
 @param title 弹窗的标题
 @param message 弹窗的提示信息
 @param leftStr 弹窗的左边按钮标题
 @param leftAction 弹出的左边按钮点击事件
 @param rightStr 弹窗的右边按钮标题
 @param rightAction 弹出的右边按钮点击事件
 */
- (void)ly_alertTitle:(NSString *)title
              message:(NSString *)message
              leftStr:(NSString *)leftStr
           leftAction:(void(^)(void))leftAction
             rightStr:(NSString *)rightStr
          rightAction:(void(^)(void))rightAction NS_AVAILABLE_IOS(8.0);

/**
 类方法弹出窗口,窗口样式默认是UIAlertControllerStyleAlert类型
 
 @param title 弹窗的标题
 @param message 弹窗的提示信息
 @param leftStr 弹窗的左边按钮标题
 @param leftAction 弹出的左边按钮点击事件
 @param rightStr 弹窗的右边按钮标题
 @param rightAction 弹出的右边按钮点击事件
 */
+ (void)ly_alertTitle:(NSString *)title
              message:(NSString *)message
              leftStr:(NSString *)leftStr
           leftAction:(void(^)(void))leftAction
             rightStr:(NSString *)rightStr
          rightAction:(void(^)(void))rightAction NS_AVAILABLE_IOS(8.0);

/**
 实例方法,带有输入框的弹窗
 
 @param title 弹窗的标题
 @param message 弹窗的提示信息
 @param placeholders 输入的占位字符串,个数决定输入框的个数
 @param leftStr 弹窗的左边按钮标题
 @param leftAction 弹窗的左边按钮点击事件
 @param rightStr 弹窗的右边按钮标题
 @param rightAction 弹窗的右边按钮点击事件
 */
- (void)ly_alertTitle:(NSString *)title
              message:(NSString *)message
 textfieldPlaceholder:(NSArray<NSString *> *)placeholders
              leftStr:(NSString *)leftStr
           leftAction:(void(^)(NSArray<UITextField *> *textFields))leftAction
             rightStr:(NSString *)rightStr
          rightAction:(void(^)(NSArray<UITextField *> *textFields))rightAction NS_AVAILABLE_IOS(8.0);

/**
 类方法,带有输入框的弹窗
 
 @param title 弹窗的标题
 @param message 弹窗的提示信息
 @param placeholders 输入的占位字符串,个数决定输入框的个数
 @param leftStr 弹窗的左边按钮标题
 @param leftAction 弹窗的左边按钮点击事件
 @param rightStr 弹窗的右边按钮标题
 @param rightAction 弹窗的右边按钮点击事件 \
 */
+ (void)ly_alertTitle:(NSString *)title
              message:(NSString *)message
 textfieldPlaceholder:(NSArray<NSString *> *)placeholders
              leftStr:(NSString *)leftStr
           leftAction:(void(^)(NSArray<UITextField *> *textFields))leftAction
             rightStr:(NSString *)rightStr
          rightAction:(void(^)(NSArray<UITextField *> *textFields))rightAction NS_AVAILABLE_IOS(8.0);

/**
 实例方法,只有一个按钮的弹窗
 
 @param title 弹窗的标题
 @param message 弹窗的提示信息
 @param comfirmStr 弹窗按钮标题
 @param comfirmAction 弹窗按钮点击事件
 */
- (void)ly_alertTitle:(NSString *)title
              message:(NSString *)message
           comfirmStr:(NSString *)comfirmStr
        comfirmAction:(void(^)(void))comfirmAction NS_AVAILABLE_IOS(8.0);

/**
 类方法,只有一个按钮的弹窗
 
 @param title 弹窗的标题
 @param message 弹窗的提示信息
 @param comfirmStr 弹窗按钮标题
 @param comfirmAction 弹窗按钮点击事件
 */
+ (void)ly_alertTitle:(NSString *)title
              message:(NSString *)message
           comfirmStr:(NSString *)comfirmStr
        comfirmAction:(void(^)(void))comfirmAction NS_AVAILABLE_IOS(8.0);

/**
 实例方法,返回自定义条数弹窗
 
 @param title 弹窗的标题
 @param message 弹窗的提示信息
 @param preferredStyle 弹窗的样式
 @param actionTitles 弹窗的条目标题
 @param clickAction 弹窗的点击事件
 @param cancelStr 弹窗的取消按钮标题
 @param cancelAction 弹窗的去掉点击事件
 */
- (void)ly_alertTitle:(NSString *)title
              message:(NSString *)message
       preferredStyle:(UIAlertControllerStyle)preferredStyle
         actionTitles:(NSArray<NSString *> *)actionTitles
          clickAction:(void(^)(NSInteger index))clickAction
            cancelStr:(NSString *)cancelStr
         cancelAction:(void(^)(void))cancelAction NS_AVAILABLE_IOS(8.0);

/**
 类方法,返回自定义条数弹窗
 
 @param title 弹窗的标题
 @param message 弹窗的提示信息
 @param preferredStyle 弹窗的样式
 @param actionTitles 弹窗的条目标题
 @param clickAction 弹窗的点击事件
 @param cancelStr 弹窗的取消按钮标题
 @param cancelAction 弹窗的去掉点击事件
 */
+ (void)ly_alertTitle:(NSString *)title
              message:(NSString *)message
       preferredStyle:(UIAlertControllerStyle)preferredStyle
         actionTitles:(NSArray<NSString *> *)actionTitles
          clickAction:(void(^)(NSInteger index))clickAction
            cancelStr:(NSString *)cancelStr
         cancelAction:(void(^)(void))cancelAction NS_AVAILABLE_IOS(8.0);
/**
 判断一个控制器是否正在显示
 
 @param viewController 参数控制器
 @return 返回BOOL类型
 */
+ (BOOL)ly_currentViewControllerVisible:(UIViewController *)viewController;
@end
