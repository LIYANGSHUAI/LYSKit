//
//  LYS_Category.m
//  LYSKit
//
//  Created by HENAN on 2017/9/22.
//  Copyright © 2017年 个人开发实用框架. All rights reserved.
//

#import "LYS_Category.h"
#import <objc/runtime.h>
#import "LYS_Define_interface.h"
@implementation UIView (LYCategory)
// 获取某个view的叶子View(一般为Window)
- (NSMutableArray *)ly_getTopSubViews{
    NSMutableArray *stack = [NSMutableArray array];
    NSMutableArray *leafNodes = [NSMutableArray array];
    if (self.subviews.count == 0) {return nil;}
    [stack addObjectsFromArray:self.subviews];
    while (stack.count != 0) {
        UIView *subView = [stack lastObject];
        [stack removeLastObject];
        if (subView.subviews.count != 0) {
            [stack addObjectsFromArray:subView.subviews];
        }else{
            [leafNodes addObject:subView];
        }
    }
    return leafNodes;
}
// 获取某个视图在哪个控制器上
- (UIViewController *)ly_getRootViewController{
    UIResponder *res = self;
    while (res) {
        if (res.nextResponder) {
            res = res.nextResponder;
        }
        if ([res isKindOfClass:[UIViewController class]]) {
            UIViewController *vc = (UIViewController*)res;
            return vc;
        }
    }
    return nil;
}
- (void)ly_shakeWithShakeDirection:(LYSQHLDirection)shakeDirection {
    [self ly_shakeWithTimes:10
                      speed:0.05
                      range:5
             shakeDirection:shakeDirection];
}
- (void)ly_shakeWithTimes:(NSInteger)times
           shakeDirection:(LYSQHLDirection)shakeDirection
{
    [self ly_shakeWithTimes:times
                      speed:0.05
                      range:5
             shakeDirection:shakeDirection];
}
- (void)ly_shakeWithTimes:(NSInteger)times
                    speed:(CGFloat)speed
           shakeDirection:(LYSQHLDirection)shakeDirection
{
    [self ly_shakeWithTimes:times
                      speed:speed
                      range:5
             shakeDirection:shakeDirection];
}
- (void)ly_shakeWithTimes:(NSInteger)times
                    speed:(CGFloat)speed
                    range:(CGFloat)range
           shakeDirection:(LYSQHLDirection)shakeDirection
{
    [self viewShakesWithTiems:times
                        speed:speed
                        range:range
               shakeDirection:shakeDirection
                 currentTimes:0 direction:1];
}
- (void)viewShakesWithTiems:(NSInteger)times
                      speed:(CGFloat)speed
                      range:(CGFloat)range
             shakeDirection:(LYSQHLDirection)shakeDirection
               currentTimes:(NSInteger)currentTimes
                  direction:(int)direction
{
    [UIView animateWithDuration:speed animations:^{
        self.transform = (shakeDirection == LYSQHLDirectionHorizontal)? CGAffineTransformMakeTranslation(range * direction, 0):CGAffineTransformMakeTranslation(0, range * direction);
    } completion:^(BOOL finished) {
        if (currentTimes >= times) {
            [UIView animateWithDuration:speed animations:^{
                self.transform = CGAffineTransformIdentity;
            }];
            return;
        }
        [self viewShakesWithTiems:times - 1
                            speed:speed
                            range:range
                   shakeDirection:shakeDirection
                     currentTimes:currentTimes + 1
                        direction:direction * -1];
    }];
}
- (void)ly_showLoadingWithColor:(UIColor *)color{
    UIActivityIndicatorView *indicatorView = objc_getAssociatedObject(self, @"LYS_loadingView") == nil ? nil : (UIActivityIndicatorView *)objc_getAssociatedObject(self, @"LYS_loadingView");
    if (indicatorView != nil) {
        [indicatorView stopAnimating];
        [indicatorView removeFromSuperview];
        objc_setAssociatedObject(self, @"LYS_loadingView", nil, OBJC_ASSOCIATION_RETAIN);
    }else{
        UIActivityIndicatorView *indicatorView = [[UIActivityIndicatorView alloc] init];
        [self addSubview:indicatorView];
        indicatorView.color = color;
        [indicatorView startAnimating];
        indicatorView.alpha = 0;
        indicatorView.userInteractionEnabled = NO;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            indicatorView.frame = self.bounds;
        });
        [UIView animateWithDuration:0.5 animations:^{
            indicatorView.alpha = 1;
        } completion:^(BOOL finished) {
            objc_setAssociatedObject(self, @"LYS_loadingView", indicatorView, OBJC_ASSOCIATION_RETAIN);
        }];
    }
}
- (void)ly_hiddenLoadingView{
    UIActivityIndicatorView *indicatorView = objc_getAssociatedObject(self, @"LYS_loadingView") == nil ? nil : (UIActivityIndicatorView *)objc_getAssociatedObject(self, @"LYS_loadingView");
    if (indicatorView != nil) {
        [UIView animateWithDuration:0.5 animations:^{
            indicatorView.alpha = 0;
        } completion:^(BOOL finished) {
            [indicatorView stopAnimating];
            [indicatorView removeFromSuperview];
            objc_setAssociatedObject(self, @"LYS_loadingView", nil, OBJC_ASSOCIATION_RETAIN);
        }];
    }
}
- (void)ly_tapGesture:(void(^)(UITapGestureRecognizer *sender,UIView *view))tapGesture
               tapNum:(NSInteger)tapNum
             touchNum:(NSInteger)touchNum
{
    if (tapGesture == nil) {return;}
    objc_setAssociatedObject(self, @"LYS_tapGesture", tapGesture, OBJC_ASSOCIATION_COPY);
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickAction:)];
    tap.numberOfTapsRequired = tapNum;
    tap.numberOfTouchesRequired = touchNum;
    [self addGestureRecognizer:tap];
}
- (void)clickAction:(id)sender{
    id tapGesture = objc_getAssociatedObject(self, @"LYS_tapGesture");
    ((void(^)(UITapGestureRecognizer *sender,UIView *view))tapGesture)(sender,self);
}
@end

@implementation UIViewController (LYCategory)

// 这段代码的意思是，如果我能判断的更精确就精确些。比如某个导航控制器，你说他在响应也行，他的top元素在响应也行，显然我想精确到top元素
+ (UIViewController *)ly_getOuterViewController
{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    NSMutableArray *array = [keyWindow ly_getTopSubViews];
    UINavigationController *nav = nil;
    UITabBarController *tab = nil;
    for (UIView *subView in array) {
        UIViewController *vc = [subView ly_getRootViewController];
        if (!([vc isKindOfClass:[UINavigationController class]] || [vc isKindOfClass:[UITabBarController class]])) {
            return vc;
        }
        if ([vc isKindOfClass:[UINavigationController class]]) {
            nav = (UINavigationController *)vc;
        }
        if ([vc isKindOfClass:[UITabBarController class]]) {
            tab = (UITabBarController *)vc;
        }
    }
    if (nav) {return nav;}
    if (tab) {return tab;}
    return nil;
}
// 弹出提示窗口
- (void)ly_alertTitle:(NSString *)title
              message:(NSString *)message
              leftStr:(NSString *)leftStr
           leftAction:(void(^)(void))leftAction
             rightStr:(NSString *)rightStr
          rightAction:(void(^)(void))rightAction
{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:leftStr style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        if (leftAction) {leftAction();}
    }];
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:rightStr style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        if (rightAction) {rightAction();}
    }];
    [alertVC addAction:confirmAction];
    [alertVC addAction:cancleAction];
    [self presentViewController:alertVC animated:YES completion:nil];
}
// 弹出提示窗口
+ (void)ly_alertTitle:(NSString *)title
              message:(NSString *)message
              leftStr:(NSString *)leftStr
           leftAction:(void(^)(void))leftAction
             rightStr:(NSString *)rightStr
          rightAction:(void(^)(void))rightAction
{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:leftStr style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        if (leftAction) {leftAction();}
    }];
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:rightStr style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        if (rightAction) {rightAction();}
    }];
    [alertVC addAction:confirmAction];
    [alertVC addAction:cancleAction];
    [[self ly_getOuterViewController] presentViewController:alertVC animated:YES completion:nil];
}
// 弹出提示窗口
- (void)ly_alertTitle:(NSString *)title
              message:(NSString *)message
 textfieldPlaceholder:(NSArray<NSString *> *)placeholders
              leftStr:(NSString *)leftStr
           leftAction:(void(^)(NSArray<UITextField *> *textFields))leftAction
             rightStr:(NSString *)rightStr
          rightAction:(void(^)(NSArray<UITextField *> *textFields))rightAction
{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    if (placeholders) {
        for (NSString *str in placeholders) {
            [alertVC addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
                textField.placeholder = str;
            }];
        }
    }
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:leftStr style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        if (leftAction) {leftAction(alertVC.textFields);}
    }];
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:rightStr style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        if (rightAction) {rightAction(alertVC.textFields);}
    }];
    [alertVC addAction:confirmAction];
    [alertVC addAction:cancleAction];
    [self presentViewController:alertVC animated:YES completion:nil];
}
// 弹出提示窗口
+ (void)ly_alertTitle:(NSString *)title
              message:(NSString *)message
 textfieldPlaceholder:(NSArray<NSString *> *)placeholders
              leftStr:(NSString *)leftStr
           leftAction:(void(^)(NSArray<UITextField *> *textFields))leftAction
             rightStr:(NSString *)rightStr
          rightAction:(void(^)(NSArray<UITextField *> *textFields))rightAction
{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    if (placeholders) {
        for (NSString *str in placeholders) {
            [alertVC addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
                textField.placeholder = str;
            }];
        }
    }
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:leftStr style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        if (leftAction) {leftAction(alertVC.textFields);}
    }];
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:rightStr style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        if (rightAction) {rightAction(alertVC.textFields);}
    }];
    [alertVC addAction:confirmAction];
    [alertVC addAction:cancleAction];
    [[self ly_getOuterViewController] presentViewController:alertVC animated:YES completion:nil];
}
// 仅仅显示确定按钮
- (void)ly_alertTitle:(NSString *)title
              message:(NSString *)message
           comfirmStr:(NSString *)comfirmStr
        comfirmAction:(void(^)(void))comfirmAction
{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:comfirmStr style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        if (comfirmAction) {comfirmAction();}
    }];
    [alertVC addAction:confirmAction];
    [self presentViewController:alertVC animated:YES completion:nil];
}
// 仅仅显示确定按钮
+ (void)ly_alertTitle:(NSString *)title
              message:(NSString *)message
           comfirmStr:(NSString *)comfirmStr
        comfirmAction:(void(^)(void))comfirmAction
{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:comfirmStr style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        if (comfirmAction) {comfirmAction();}
    }];
    [alertVC addAction:confirmAction];
    [[self ly_getOuterViewController] presentViewController:alertVC animated:YES completion:nil];
}
// 自定义弹窗条数
- (void)ly_alertTitle:(NSString *)title
              message:(NSString *)message
       preferredStyle:(UIAlertControllerStyle)preferredStyle
         actionTitles:(NSArray<NSString *> *)actionTitles
          clickAction:(void(^)(NSInteger index))clickAction
            cancelStr:(NSString *)cancelStr
         cancelAction:(void(^)(void))cancelAction
{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:preferredStyle];
    if (actionTitles) {
        for (int i = 0;i < actionTitles.count;i++) {
            UIAlertAction *action = [UIAlertAction actionWithTitle:actionTitles[i] style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                if (clickAction) { clickAction(i);}
            }];
            [alertVC addAction:action];
        }
    }
    if (cancelStr) {
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:cancelStr style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
            if (cancelAction) { cancelAction();}
        }];
        [alertVC addAction:cancel];
    }
    [self presentViewController:alertVC animated:YES completion:nil];
}
// 自定义弹窗条数
+ (void)ly_alertTitle:(NSString *)title
              message:(NSString *)message
       preferredStyle:(UIAlertControllerStyle)preferredStyle
         actionTitles:(NSArray<NSString *> *)actionTitles
          clickAction:(void(^)(NSInteger index))clickAction
            cancelStr:(NSString *)cancelStr
         cancelAction:(void(^)(void))cancelAction
{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:preferredStyle];
    if (actionTitles) {
        for (int i = 0;i < actionTitles.count;i++) {
            UIAlertAction *action = [UIAlertAction actionWithTitle:actionTitles[i] style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                if (clickAction) { clickAction(i);}
            }];
            [alertVC addAction:action];
        }
    }
    if (cancelStr) {
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:cancelStr style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
            if (cancelAction) { cancelAction();}
        }];
        [alertVC addAction:cancel];
    }
    [[self ly_getOuterViewController] presentViewController:alertVC animated:YES completion:nil];
}
// 判断一个控制器是否正在显示
+ (BOOL)ly_currentViewControllerVisible:(UIViewController *)viewController
{
    return (viewController.isViewLoaded && viewController.view.window);
}
@end

@implementation NSString (LYCategory)
// 转换成NSData类型
- (NSData *)ly_NSData
{
    return [self dataUsingEncoding:NSUTF8StringEncoding];
}
// 字符串转字典
- (NSDictionary *)ly_dictionary
{
    return [NSJSONSerialization JSONObjectWithData:[self ly_NSData] options:(NSJSONReadingAllowFragments) error:nil];
}
// 去掉字符串结尾换行和空格
- (NSString *)ly_stringClearWhitespaceAndNewLine
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}
// 获取字符串在指定区域的rect
- (CGRect)ly_rectWithSize:(CGSize)size
               attributes:(NSDictionary<NSString *,id> *)attributes
{
    return [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attributes context:nil];
}
// 获取首字母
- (NSString *)ly_firstLatter
{
    return [self substringToIndex:1];
}
// 获取字符串拼音
- (NSString *)ly_firstCharactor
{
    //转成了可变字符串
    NSMutableString *str = [NSMutableString stringWithString:self];
    //先转换为带声调的拼音
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformMandarinLatin,NO);
    //再转换为不带声调的拼音
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformStripDiacritics,NO);
    return str;
}
// 判断是不是手机号
- (NSString *)ly_telePhoneNumBer
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189
     22         */
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    NSString *result = nil;
    
    if (([regextestmobile evaluateWithObject:self] == YES)
        || ([regextestcm evaluateWithObject:self] == YES)
        || ([regextestct evaluateWithObject:self] == YES)
        || ([regextestcu evaluateWithObject:self] == YES))
    {
        if([regextestcm evaluateWithObject:self] == YES) {
            result = @"移动";
        } else if([regextestct evaluateWithObject:self] == YES) {
            result = @"联通";
        } else if ([regextestcu evaluateWithObject:self] == YES) {
            result = @"固定";
        } else {
            result = @"未知";
        }
    }
    else
    {
        result = @"未知";
    }
    return result;
}

@end

@implementation UIImage (LYCategory)

// 根据透明度绘制一个图片
+ (UIImage *)ly_imageWithColor:(UIColor *)color
                         alpha:(CGFloat)alpha
{
    // 创建一个color对象
    UIColor *tempColor = [color colorWithAlphaComponent:alpha];
    // 声明一个绘制大小
    CGSize colorSize = CGSizeMake(1, 1);
    UIGraphicsBeginImageContext(colorSize);
    // 开始绘制颜色区域
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 根据提供的颜色给相应绘制内容填充
    CGContextSetFillColorWithColor(context, tempColor.CGColor);
    // 设置填充相应的区域
    CGContextFillRect(context, CGRectMake(0, 0, 1, 1));
    // 声明UIImage对象
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}
// 截屏功能
+ (UIImage *)ly_screenShot:(CGSize)size
            withTargetView:(UIView *)targetView
{
    UIGraphicsBeginImageContextWithOptions(size,NO,0.0);
    [targetView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image= UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
// 下载图片
+ (UIImage *)ly_downloadNetworkImageURL:(NSString *)urlStr
{
    NSURL *url = [NSURL URLWithString:urlStr];
    NSData *urlData = [NSData dataWithContentsOfURL:url];
    return [UIImage imageWithData:urlData];
}
// 循环压缩图片
- (NSData *)ly_compressionImageWithMaxWidth:(CGFloat)maxWidth
                                  limitSize:(NSInteger)limitSize
{
    if (maxWidth < 0) {maxWidth = 1024;}
    // 限制图片大小
    CGSize newSize = CGSizeMake(self.size.width, self.size.height);
    CGFloat scaleH = newSize.height / maxWidth;
    CGFloat scaleW = newSize.width / maxWidth;
    if (scaleW > 1.0 && scaleW > scaleH) {
        newSize = CGSizeMake(ceil(self.size.width / scaleW), self.size.height / scaleH);
    }else if (scaleH > 1.0 && scaleW < scaleH){
        newSize = CGSizeMake(ceil(self.size.width / scaleH), ceil(self.size.height / scaleH));
    }
    UIGraphicsBeginImageContext(newSize);
    [self drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    // 压缩图片质量
    CGFloat compression = 0.9f;
    CGFloat mincompression = 0.1f;
    NSData *imageData = UIImageJPEGRepresentation(newImage, compression);
    while (imageData.length / 1000 > limitSize && compression > mincompression) {
        imageData = nil;
        compression -= 0.1;
        imageData = UIImageJPEGRepresentation(newImage, compression);
    }
    return imageData;
}
@end

@implementation NSDate (LYCategory)
// 获取给定时间的字符串格式
+ (NSString *)ly_stringWithDate:(NSDate *)date
                      formatter:(NSString *)formatStr
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = formatStr;
    return [formatter stringFromDate:date];
}
// 获取当前时间的字符串格式
+ (NSString *)ly_stringWithCurrentDateFormatter:(NSString *)formatStr
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = formatStr;
    return [formatter stringFromDate:[NSDate date]];
}
// 获取当前时间的字符串格式
- (NSString *)ly_stringWithFormatter:(NSString *)formatStr
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = formatStr;
    return [formatter stringFromDate:self];
}
// 字符串转日期
+ (NSDate *)ly_dateWithStr:(NSString *)dateStr
                 formatter:(NSString *)formatStr
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:formatStr];
    return [formatter dateFromString:dateStr];
}
// 指定时间和当前时间比较
+ (NSString *)compareCurrentTime:(NSDate*)compareDate
{
    NSTimeInterval timeInterval = [compareDate timeIntervalSinceNow];
    timeInterval = -timeInterval;
    NSInteger time = round(timeInterval);
    long temp = 0;
    if (time < 60) {
        NSString *result = @"刚刚";
        return result;
    }
    else if((temp = timeInterval/60) <60){
        NSString *result = [NSString stringWithFormat:@"%ld分前",temp];
        return result;
    }
    else if((temp = temp/60) <24){
        NSString *result = [NSString stringWithFormat:@"%ld小前",temp];
        return result;
    }
    else if((temp = temp/24) <30){
        NSString *result = [NSString stringWithFormat:@"%ld天前",temp];
        return result;
    }
    else if((temp = temp/30) <12){
        NSString *result = [NSString stringWithFormat:@"%ld月前",temp];
        return result;
    }
    else{
        temp = temp/12;
        NSString *result = [NSString stringWithFormat:@"%ld年前",temp];
        return result;
    }
    return  nil;
}
// 获取n个24小时之后的NSDate
+ (NSDate *)ly_dateSincleNow:(NSInteger)num
{
    return [NSDate dateWithTimeIntervalSinceNow:24 * 3600 * num];
}
// 获取明天的这个时间点的NSDate
+ (NSDate *)ly_dateTomorrow
{
    return [self ly_dateSincleNow:1];
}
// 获取昨天的这个时间点的NSDate
+ (NSDate *)ly_dateYesterday
{
    return [self ly_dateSincleNow:-1];
}
@end

@implementation NSDictionary (LYCategory)
// 字典转字符串
- (NSString *)ly_string
{
    NSData *dictData = [NSJSONSerialization dataWithJSONObject:self options:(NSJSONWritingPrettyPrinted) error:nil];
    NSString *dictStr = [[NSString alloc] initWithData:dictData encoding:NSUTF8StringEncoding];
    return dictStr;
}
// 快速打印模型属性信息
+ (void)ly_createPropertyCodeWithDict:(NSDictionary *)dict
{
    NSMutableString *strM = [NSMutableString string];
    //遍历字典
    [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull propertyName, id  _Nonnull value, BOOL * _Nonnull stop)
     {
         NSString *code;//属性代码
         if ([value isKindOfClass:NSClassFromString(@"__NSCFString")]) {
             code = [NSString stringWithFormat:@"@property (nonatomic, copy) NSString *%@;",propertyName]             ;
         }else if ([value isKindOfClass:NSClassFromString(@"__NSCFNumber")]){
             code = [NSString stringWithFormat:@"@property (nonatomic, assign) int %@;",propertyName]             ;
         }else if ([value isKindOfClass:NSClassFromString(@"__NSCFArray")]){
             code = [NSString stringWithFormat:@"@property (nonatomic, strong) NSArray *%@;",propertyName]             ;
         }else if ([value isKindOfClass:NSClassFromString(@"__NSCFDictionary")]){
             code = [NSString stringWithFormat:@"@property (nonatomic, strong) NSDictionary *%@;",propertyName]             ;
         }else if ([value isKindOfClass:NSClassFromString(@"__NSCFBoolean")]){
             code = [NSString stringWithFormat:@"@property (nonatomic, assign) BOOL %@;",propertyName]             ;
         }else {
             code = [NSString stringWithFormat:@"@property (nonatomic, copy) NSString *%@;",propertyName]             ;
         }
         [strM appendFormat:@"%@\n",code];
     }];
    NSLog(@"%@",strM);
}
@end

@implementation UINavigationBar (LYCategory)
// 获取导航底部细线
- (UIView *)ly_navigationBarBottomLine
{
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:NSClassFromString(@"_UIBarBackground")]) {
            for (UIView *temView in view.subviews) {
                if ([temView isKindOfClass:NSClassFromString(@"UIImageView")]) {
                    return temView;
                }
            }
        }
    }
    return nil;
}
// 隐藏导航条背景图片
- (void)ly_hiddenBackgroundImage
{
    [self setBackgroundImage:nil forBarMetrics:(UIBarMetricsDefault)];
}
// 隐藏背景图片,并给一个给定alpha的图片
- (void)ly_hiddenAndSetBackgroundImageColor:(UIColor *)color
                                      alpha:(CGFloat)alpha
{
    [self setBackgroundImage:nil forBarMetrics:(UIBarMetricsDefault)];
    [self setBackgroundImage:[UIImage ly_imageWithColor:color alpha:alpha] forBarMetrics:(UIBarMetricsDefault)];
}
// 设置导航背景图片
- (void)ly_setBackgroundImage:(UIImage *)image
{
    [self setBackgroundImage:image forBarMetrics:(UIBarMetricsDefault)];
}
@end

@implementation UITabBar (LYCategory)
// 设置导航条顶部线的alpha
- (void)ly_setBarButtonLineColor:(UIColor *)color
                           alpha:(CGFloat)alpha
{
    UIImage *image = [UIImage ly_imageWithColor:color alpha:alpha];
    [self setShadowImage:image];
}
// 隐藏导航条背景图片
- (void)ly_hiddenBackgroundImage
{
    [self setBackgroundImage:nil];
}
// 隐藏背景图片,并给一个给定alpha的图片
- (void)ly_hiddenAndSetBackgroundImageColor:(UIColor *)color
                                      alpha:(CGFloat)alpha
{
    UIImage *image = [UIImage ly_imageWithColor:color alpha:alpha];
    [self setBackgroundImage:image];
}
// 设置背景图片
- (void)ly_setBackgroundImage:(UIImage *)image
{
    [self setBackgroundImage:image];
}
@end

