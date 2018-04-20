
#import "LYS_Category.h"

NSString *const LYSDateFormatterStandardDateFormatBar = @"yyyy-MM-dd HH:mm:ss";
NSString *const LYSDateFormatterStandardDateFormatSlash = @"yyyy/MM/dd HH:mm:ss";
NSString *const LYSDateFormatterGregorianCalendarBar = @"yyyy-MM-dd";
NSString *const LYSDateFormatterGregorianCalendarSlash = @"yyyy/MM/dd";
NSString *const LYSDateFormatterTime = @"HH:mm:ss";

#define FORMATTER(A) \
({\
NSDateFormatter *formatter = [[NSDateFormatter alloc] init];\
formatter.dateFormat = A;\
formatter;\
})

#define FORMAT(...) [NSString stringWithFormat:__VA_ARGS__]

#define ISKINDOFCLASS(A,B) [A isKindOfClass:NSClassFromString(B)]

@implementation NSDate (LYSCategory)

+ (NSString *)ly_stringWithDate:(NSDate *)date formatter:(NSString *)formatStr
{
    return [FORMATTER(formatStr) stringFromDate:date];
}

+ (NSString *)ly_stringWithCurrentDateFormatter:(NSString *)formatStr
{
    return [FORMATTER(formatStr) stringFromDate:[NSDate date]];
}

- (NSString *)ly_stringWithFormatter:(NSString *)formatStr
{
    return [FORMATTER(formatStr) stringFromDate:self];
}

+ (NSDate *)ly_dateWithString:(NSString *)dateStr formatter:(NSString *)formatStr
{
    return [FORMATTER(formatStr) dateFromString:dateStr];
}

+ (NSString *)ly_compareCurrentTime:(NSDate *)compareDate
{
    NSTimeInterval timeInterval = -[compareDate timeIntervalSinceNow];
    NSInteger time = round(timeInterval);
    long temp = 0;
    NSString *result = nil;
    if (time < 60)
    {
        result = @"刚刚";
    }else
        if((temp = timeInterval / 60) <60)
        {
            result = FORMAT(@"%ld分前",temp);
        }else
            if((temp = temp / 60) <24)
            {
                result = FORMAT(@"%ld小前",temp);
            }else
                if((temp = temp / 24) <30)
                {
                    result = FORMAT(@"%ld天前",temp);
                }else
                    if((temp = temp / 30) <12)
                    {
                        result = FORMAT(@"%ld月前",temp);
                    }else
                    {
                        result = FORMAT(@"%ld年前",temp / 12);
                    }
    return  result;
}

+ (NSDate *)ly_dateSincleNow:(NSInteger)num
{
    return [NSDate dateWithTimeIntervalSinceNow:24 * 3600 * num];
}

+ (NSDate *)ly_dateTomorrow
{
    return [self ly_dateSincleNow:1];
}

+ (NSDate *)ly_dateYesterday
{
    return [self ly_dateSincleNow:-1];
}

@end


////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
@implementation NSDictionary (LYSCategory)

- (NSData *)ly_toData
{
    return [NSJSONSerialization dataWithJSONObject:self options:(NSJSONWritingPrettyPrinted) error:nil];
}

- (NSString *)ly_toString
{
    return [[NSString alloc] initWithData:[self ly_toData] encoding:NSUTF8StringEncoding];
}

+ (NSString *)ly_createPropertyCodeWithDict:(NSDictionary *)dict
{
    NSMutableString *mStr = [NSMutableString stringWithString:@"\n"];
    for (NSString *propertyName in dict)
    {
        if (ISKINDOFCLASS(dict[propertyName],@"__NSCFString"))
        {
            [mStr appendString:FORMAT(@"@property (nonatomic, copy) NSString *%@;\n",propertyName)];
        }else
            if (ISKINDOFCLASS(dict[propertyName],@"__NSCFNumber"))
            {
                [mStr appendString:FORMAT(@"@property (nonatomic, assign) int %@;\n",propertyName)];
            }else
                if (ISKINDOFCLASS(dict[propertyName],@"__NSCFArray"))
                {
                    [mStr appendString:FORMAT(@"@property (nonatomic, strong) NSArray *%@;\n",propertyName)];
                }else
                    if (ISKINDOFCLASS(dict[propertyName],@"__NSCFDictionary"))
                    {
                        [mStr appendString:FORMAT(@"@property (nonatomic, strong) NSDictionary *%@;\n",propertyName)];
                    }else
                        if (ISKINDOFCLASS(dict[propertyName],@"__NSCFBoolean"))
                        {
                            [mStr appendString:FORMAT(@"@property (nonatomic, assign) BOOL %@;\n",propertyName)];
                        }else
                        {
                            [mStr appendString:FORMAT(@"@property (nonatomic, copy) NSString *%@;\n",propertyName)];
                        }
    }
    return mStr;
}
@end


////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
@implementation NSString (LYSCategory)

- (NSData *)ly_toData
{
    return [self dataUsingEncoding:NSUTF8StringEncoding];
}

- (NSDictionary *)ly_toDictionary
{
    return [NSJSONSerialization JSONObjectWithData:[self ly_toData] options:(NSJSONReadingAllowFragments) error:nil];
}

- (NSString *)ly_stringClearWhitespaceAndNewLine
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (CGRect)ly_rectWithSize:(CGSize)size attributes:(NSDictionary<NSString *,id> *)attributes
{
    return [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attributes context:nil];
}

- (NSString *)ly_firstLatter
{
    return [self substringToIndex:1];
}

- (NSString *)ly_toPinyin
{
    //转成了可变字符串
    NSMutableString *str = [NSMutableString stringWithString:self];
    //先转换为带声调的拼音
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformMandarinLatin,NO);
    //再转换为不带声调的拼音
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformStripDiacritics,NO);
    return str;
}

- (LYSTelephoneNumber)ly_telePhoneNumBer
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
    LYSTelephoneNumber result = LYSTelephoneNumberUnKnow;
    
    if (([regextestmobile evaluateWithObject:self] == YES)
        || ([regextestcm evaluateWithObject:self] == YES)
        || ([regextestct evaluateWithObject:self] == YES)
        || ([regextestcu evaluateWithObject:self] == YES))
    {
        if([regextestcm evaluateWithObject:self] == YES)
        {
            result = LYSTelephoneNumberYiDong;
        } else
            if([regextestct evaluateWithObject:self] == YES)
            {
                result = LYSTelephoneNumberLiTong;
            } else
                if ([regextestcu evaluateWithObject:self] == YES)
                {
                    result = LYSTelephoneNumberGuHua;
                } else
                {
                    result = LYSTelephoneNumberUnKnow;
                }
    }
    else
    {
        result = LYSTelephoneNumberUnKnow;
    }
    return result;
}

- (NSArray<NSString *> *)ly_splitWithString:(NSString *)separator{
    return [self componentsSeparatedByString:separator];
}

- (BOOL)ly_hasPrefix:(NSString *)str{
    return [self hasPrefix:str];
}

- (BOOL)ly_hasSuffix:(NSString *)str{
    return [self hasSuffix:str];
}

@end


////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
//#pragma mark - 颜色字符串转换为对应的颜色 -
//#define LYS_Implementation_HEX(str)\
//({\
//UIColor *color = nil;\
//NSString *hexColor = str;\
//hexColor = [hexColor stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];\
//if ([hexColor length] < 6) {color = nil;}else{\
//if ([hexColor hasPrefix:@"#"]) {hexColor = [hexColor substringFromIndex:1];}\
//NSString *red = [hexColor substringWithRange:NSMakeRange(0, 2)];\
//NSString *green = [hexColor substringWithRange:NSMakeRange(2, 2)];\
//NSString *blue = [hexColor substringWithRange:NSMakeRange(4, 2)];\
//unsigned int r, g ,b , a;\
//[[NSScanner scannerWithString:red] scanHexInt:&r];\
//[[NSScanner scannerWithString:green] scanHexInt:&g];\
//[[NSScanner scannerWithString:blue] scanHexInt:&b];\
//if ([hexColor length] == 8) {\
//NSString *as = [hexColor substringWithRange:NSMakeRange(4, 2)];\
//[[NSScanner scannerWithString:as] scanHexInt:&a];\
//}else {\
//a = 255;\
//}\
//color = [UIColor colorWithRed:(float)r / 255.0 green:(float)g / 255.0 blue:(float)b / 255.0 alpha:(float)a / 255.0];\
//}\
//(color);\
//})

@implementation UIColor (LYSCategory)

+ (UIColor *)ly_hex:(NSString *)hexStr
{
    UIColor *color = nil;
    NSString *hexColor = hexStr;
    hexColor = [hexColor stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if ([hexColor length] < 6) {color = nil;}else
    {
        if ([hexColor hasPrefix:@"#"]) {hexColor = [hexColor substringFromIndex:1];}
        NSString *red = [hexColor substringWithRange:NSMakeRange(0, 2)];
        NSString *green = [hexColor substringWithRange:NSMakeRange(2, 2)];
        NSString *blue = [hexColor substringWithRange:NSMakeRange(4, 2)];
        unsigned int r, g ,b , a;
        [[NSScanner scannerWithString:red] scanHexInt:&r];
        [[NSScanner scannerWithString:green] scanHexInt:&g];
        [[NSScanner scannerWithString:blue] scanHexInt:&b];
        if ([hexColor length] == 8)
        {
            NSString *as = [hexColor substringWithRange:NSMakeRange(4, 2)];
            [[NSScanner scannerWithString:as] scanHexInt:&a];
        }else
        {
            a = 255;
        }
        color = [UIColor colorWithRed:(float)r / 255.0 green:(float)g / 255.0 blue:(float)b / 255.0 alpha:(float)a / 255.0];
    }
    return color;
}

@end


////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
@implementation UIImage (LYSCategory)

+ (UIImage *)ly_imageWithColor:(UIColor *)color alpha:(CGFloat)alpha
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

+ (UIImage *)ly_screenShot:(CGSize)size withTargetView:(UIView *)targetView
{
    UIGraphicsBeginImageContextWithOptions(size,NO,0.0);
    [targetView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image= UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)ly_downloadNetworkImageURL:(NSString *)urlStr
{
    NSURL *url = [NSURL URLWithString:urlStr];
    NSData *urlData = [NSData dataWithContentsOfURL:url];
    return [UIImage imageWithData:urlData];
}

- (NSData *)ly_compressionImageWithMaxWidth:(CGFloat)maxWidth limitSize:(NSInteger)limitSize
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


////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
@implementation UINavigationBar (LYSCategory)

- (void)ly_hiddenNavigationBarBottomLine
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0)
    {
        for (UIView *view in self.subviews) {
            if (ISKINDOFCLASS(view, @"_UIBarBackground")) {
                for (UIView *temView in view.subviews) {
                    if (ISKINDOFCLASS(temView,@"UIImageView") && CGRectGetHeight(temView.frame) <= 1) {
                        temView.hidden = YES;
                    }
                }
            }
        }
    }
    else
    {
        for (UIView *view in self.subviews) {
            if (ISKINDOFCLASS(view, @"_UINavigationBarBackground")) {
                for (UIView *temView in view.subviews) {
                    if (ISKINDOFCLASS(temView,@"UIImageView") && CGRectGetHeight(temView.frame) <= 1) {
                        temView.hidden = YES;
                    }
                }
            }
        }
    }
}

- (void)ly_showNavigationBarBottomLine{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0)
    {
        for (UIView *view in self.subviews) {
            if (ISKINDOFCLASS(view, @"_UIBarBackground")) {
                for (UIView *temView in view.subviews) {
                    if (ISKINDOFCLASS(temView,@"UIImageView") && CGRectGetHeight(temView.frame) <= 1) {
                        temView.hidden = NO;
                    }
                }
            }
        }
    }
    else
    {
        for (UIView *view in self.subviews) {
            if (ISKINDOFCLASS(view, @"_UINavigationBarBackground")) {
                for (UIView *temView in view.subviews) {
                    if (ISKINDOFCLASS(temView,@"UIImageView") && CGRectGetHeight(temView.frame) <= 1) {
                        temView.hidden = NO;
                    }
                }
            }
        }
    }
}

- (void)ly_hiddenBackgroundImage
{
    [self setBackgroundImage:[UIImage ly_imageWithColor:[UIColor clearColor] alpha:0] forBarMetrics:(UIBarMetricsDefault)];
}

- (void)ly_setBackgroundImage:(UIImage *)image
{
    [self setBackgroundImage:image forBarMetrics:(UIBarMetricsDefault)];
}

@end


////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
@implementation UITabBar (LYSCategory)

- (void)ly_hiddenTabbarTopLine
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0)
    {
        for (UIView *view in self.subviews) {
            if (ISKINDOFCLASS(view,@"_UIBarBackground")) {
                for (UIView *temView in view.subviews) {
                    if (ISKINDOFCLASS(temView,@"UIImageView") && CGRectGetHeight(temView.frame) <= 1) {
                        temView.hidden = YES;
                    }
                }
            }
        }
    }
    else
    {
        for (UIView *view in self.subviews) {
            if (ISKINDOFCLASS(view,@"UIImageView") && CGRectGetHeight(view.frame) <= 1) {
                view.hidden = YES;
            }
        }
    }
}

- (void)ly_showTabbarTopLine
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0)
    {
        for (UIView *view in self.subviews) {
            if (ISKINDOFCLASS(view,@"_UIBarBackground")) {
                for (UIView *temView in view.subviews) {
                    if (ISKINDOFCLASS(temView,@"UIImageView") && CGRectGetHeight(temView.frame) <= 1) {
                        temView.hidden = NO;
                    }
                }
            }
        }
    }
    else
    {
        for (UIView *view in self.subviews) {
            if (ISKINDOFCLASS(view,@"UIImageView") && CGRectGetHeight(view.frame) <= 1) {
                view.hidden = NO;
            }
        }
    }
}

- (void)ly_hiddenBackgroundImage
{
    UIImage *image = [UIImage ly_imageWithColor:[UIColor clearColor] alpha:0];
    [self setBackgroundImage:image];
}

- (void)ly_setBackgroundImage:(UIImage *)image
{
    [self setBackgroundImage:image];
}


@end


////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
@implementation UIView (LYSCategory)

- (NSMutableArray *)ly_getTopSubViews
{
    NSMutableArray *stack = [NSMutableArray array];
    NSMutableArray *leafNodes = [NSMutableArray array];
    if (self.subviews.count == 0) {return nil;}
    [stack addObjectsFromArray:self.subviews];
    while (stack.count != 0)
    {
        UIView *subView = [stack lastObject];
        [stack removeLastObject];
        if (subView.subviews.count != 0)
        {
            [stack addObjectsFromArray:subView.subviews];
        }else
        {
            [leafNodes addObject:subView];
        }
    }
    return leafNodes;
}

- (UIViewController *)ly_getRootViewController
{
    UIResponder *res = self;
    while (res) {
        if (res.nextResponder)
        {
            res = res.nextResponder;
        }
        if ([res isKindOfClass:[UIViewController class]])
        {
            UIViewController *vc = (UIViewController*)res;
            return vc;
        }
    }
    return nil;
}

- (void)ly_shakeWithShakeDirection:(LYSQHLDirection)shakeDirection
{
    [self ly_shakeWithTimes:10
                      speed:0.05
                      range:5
             shakeDirection:shakeDirection];
}

- (void)ly_shakeWithTimes:(NSInteger)times shakeDirection:(LYSQHLDirection)shakeDirection
{
    [self ly_shakeWithTimes:times
                      speed:0.05
                      range:5
             shakeDirection:shakeDirection];
}

- (void)ly_shakeWithTimes:(NSInteger)times speed:(CGFloat)speed shakeDirection:(LYSQHLDirection)shakeDirection
{
    [self ly_shakeWithTimes:times
                      speed:speed
                      range:5
             shakeDirection:shakeDirection];
}

- (void)ly_shakeWithTimes:(NSInteger)times speed:(CGFloat)speed range:(CGFloat)range shakeDirection:(LYSQHLDirection)shakeDirection
{
    [self viewShakesWithTiems:times
                        speed:speed
                        range:range
               shakeDirection:shakeDirection
                 currentTimes:0 direction:1];
}

- (void)viewShakesWithTiems:(NSInteger)times speed:(CGFloat)speed range:(CGFloat)range shakeDirection:(LYSQHLDirection)shakeDirection currentTimes:(NSInteger)currentTimes direction:(int)direction
{
    [UIView animateWithDuration:speed animations:^{
        self.transform = (shakeDirection == LYSQHLDirectionHorizontal)? CGAffineTransformMakeTranslation(range * direction, 0):CGAffineTransformMakeTranslation(0, range * direction);
    } completion:^(BOOL finished) {
        if (currentTimes >= times)
        {
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

- (void)ly_showLoadingWithColor:(UIColor *)color
{
    UIActivityIndicatorView *indicatorView = objc_getAssociatedObject(self, @"LYS_loadingView") == nil ? nil : (UIActivityIndicatorView *)objc_getAssociatedObject(self, @"LYS_loadingView");
    if (indicatorView != nil)
    {
        [indicatorView stopAnimating];
        [indicatorView removeFromSuperview];
        objc_setAssociatedObject(self, @"LYS_loadingView", nil, OBJC_ASSOCIATION_RETAIN);
    }else
    {
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

- (void)ly_hiddenLoadingView
{
    UIActivityIndicatorView *indicatorView = objc_getAssociatedObject(self, @"LYS_loadingView") == nil ? nil : (UIActivityIndicatorView *)objc_getAssociatedObject(self, @"LYS_loadingView");
    if (indicatorView != nil)
    {
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
- (void)clickAction:(id)sender
{
    id tapGesture = objc_getAssociatedObject(self, @"LYS_tapGesture");
    ((void(^)(UITapGestureRecognizer *sender,UIView *view))tapGesture)(sender,self);
}

@end


////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
@implementation UIViewController (LYSCategory)

+ (UIViewController *)ly_getOuterViewController
{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    NSMutableArray *array = [keyWindow ly_getTopSubViews];
    UINavigationController *nav = nil;
    UITabBarController *tab = nil;
    for (UIView *subView in array) {
        UIViewController *vc = [subView ly_getRootViewController];
        if (!([vc isKindOfClass:[UINavigationController class]] || [vc isKindOfClass:[UITabBarController class]]))
        {
            return vc;
        }
        if ([vc isKindOfClass:[UINavigationController class]])
        {
            nav = (UINavigationController *)vc;
        }
        if ([vc isKindOfClass:[UITabBarController class]])
        {
            tab = (UITabBarController *)vc;
        }
    }
    if (nav) {return nav;}
    if (tab) {return tab;}
    return nil;
}

+ (BOOL)ly_currentViewControllerVisible:(UIViewController *)viewController
{
    return (viewController.isViewLoaded && viewController.view.window);
}

- (void)ly_alertTitle:(NSString *)title
              message:(NSString *)message
              leftStr:(NSString *)leftStr
           leftAction:(void(^)(void))leftAction
             rightStr:(NSString *)rightStr
          rightAction:(void(^)(void))rightAction
{
    [self ly_alertTitle:title
                message:message
         preferredStyle:(UIAlertControllerStyleAlert)
           actionTitles:@[leftStr,rightStr]
            clickAction:^(NSInteger index)
     {
         if (index == 0) {
             if (leftAction) {
                 leftAction();
             }
         }else{
             if (rightAction) {
                 rightAction();
             }
         }
     }
              cancelStr:nil
           cancelAction:nil];
}

+ (void)ly_alertTitle:(NSString *)title
              message:(NSString *)message
              leftStr:(NSString *)leftStr
           leftAction:(void(^)(void))leftAction
             rightStr:(NSString *)rightStr
          rightAction:(void(^)(void))rightAction
{
    [self ly_alertTitle:title
                message:message
         preferredStyle:(UIAlertControllerStyleAlert)
           actionTitles:@[leftStr,rightStr]
            clickAction:^(NSInteger index)
     {
         if (index == 0) {
             if (leftAction) {
                 leftAction();
             }
         }else{
             if (rightAction) {
                 rightAction();
             }
         }
     }
              cancelStr:nil
           cancelAction:nil];
}

- (void)ly_alertTitle:(NSString *)title
              message:(NSString *)message
           comfirmStr:(NSString *)comfirmStr
        comfirmAction:(void(^)(void))comfirmAction
{
    [self ly_alertTitle:title
                message:message
         preferredStyle:(UIAlertControllerStyleAlert)
           actionTitles:@[comfirmStr]
            clickAction:^(NSInteger index)
     {
         if (comfirmAction) {
             comfirmAction();
         }
     }
              cancelStr:nil
           cancelAction:nil];
}

+ (void)ly_alertTitle:(NSString *)title
              message:(NSString *)message
           comfirmStr:(NSString *)comfirmStr
        comfirmAction:(void(^)(void))comfirmAction
{
    [self ly_alertTitle:title
                message:message
         preferredStyle:(UIAlertControllerStyleAlert)
           actionTitles:@[comfirmStr]
            clickAction:^(NSInteger index)
     {
         if (comfirmAction) {
             comfirmAction();
         }
     }
              cancelStr:nil
           cancelAction:nil];
}

- (void)ly_alertTitle:(NSString *)title
              message:(NSString *)message
       preferredStyle:(UIAlertControllerStyle)preferredStyle
         actionTitles:(NSArray<NSString *> *)actionTitles
          clickAction:(void(^)(NSInteger index))clickAction
            cancelStr:(NSString *)cancelStr
         cancelAction:(void(^)(void))cancelAction
{
    UIAlertController *alertVC = [UIViewController alertWithTitle:title
                                                          message:message
                                                   preferredStyle:preferredStyle
                                                     actionTitles:actionTitles
                                                      clickAction:clickAction
                                                        cancelStr:cancelStr
                                                     cancelAction:cancelAction];
    [self presentViewController:alertVC animated:YES completion:nil];
}

+ (void)ly_alertTitle:(NSString *)title
              message:(NSString *)message
       preferredStyle:(UIAlertControllerStyle)preferredStyle
         actionTitles:(NSArray<NSString *> *)actionTitles
          clickAction:(void(^)(NSInteger index))clickAction
            cancelStr:(NSString *)cancelStr
         cancelAction:(void(^)(void))cancelAction
{
    UIAlertController *alertVC = [self alertWithTitle:title
                                              message:message
                                       preferredStyle:preferredStyle
                                         actionTitles:actionTitles
                                          clickAction:clickAction
                                            cancelStr:cancelStr
                                         cancelAction:cancelAction];
    [[self ly_getOuterViewController] presentViewController:alertVC animated:YES completion:nil];
}

- (void)ly_alertTitle:(NSString *)title
              message:(NSString *)message
 textfieldPlaceholder:(NSArray<NSString *> *)placeholders
         actionTitles:(NSArray<NSString *> *)actionTitles
          clickAction:(void(^)(NSInteger index))clickAction
            cancelStr:(NSString *)cancelStr
         cancelAction:(void(^)(void))cancelAction
{
    UIAlertController *alertVC = [UIViewController alertWithTitle:title
                                                          message:message
                                             textfieldPlaceholder:placeholders
                                                     actionTitles:actionTitles
                                                      clickAction:clickAction
                                                        cancelStr:cancelStr
                                                     cancelAction:cancelAction];
    [self presentViewController:alertVC animated:YES completion:nil];
}

+ (void)ly_alertTitle:(NSString *)title
              message:(NSString *)message
 textfieldPlaceholder:(NSArray<NSString *> *)placeholders
         actionTitles:(NSArray<NSString *> *)actionTitles
          clickAction:(void(^)(NSInteger index))clickAction
            cancelStr:(NSString *)cancelStr
         cancelAction:(void(^)(void))cancelAction
{
    UIAlertController *alertVC = [self alertWithTitle:title
                                              message:message
                                 textfieldPlaceholder:placeholders
                                         actionTitles:actionTitles
                                          clickAction:clickAction
                                            cancelStr:cancelStr
                                         cancelAction:cancelAction];
    [[self ly_getOuterViewController] presentViewController:alertVC animated:YES completion:nil];
}

+ (UIAlertController *)alertWithTitle:(NSString *)title
                              message:(NSString *)message
                 textfieldPlaceholder:(NSArray<NSString *> *)placeholders
                         actionTitles:(NSArray<NSString *> *)actionTitles
                          clickAction:(void(^)(NSInteger index))clickAction
                            cancelStr:(NSString *)cancelStr
                         cancelAction:(void(^)(void))cancelAction
{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    if (placeholders)
    {
        for (NSString *str in placeholders)
        {
            [alertVC addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
                textField.placeholder = str;
            }];
        }
    }
    if (actionTitles)
    {
        for (int i = 0;i < actionTitles.count;i++)
        {
            UIAlertAction *action = [UIAlertAction actionWithTitle:actionTitles[i]
                                                             style:(UIAlertActionStyleDefault)
                                                           handler:^(UIAlertAction * _Nonnull action)
                                     {
                                         if (clickAction) { clickAction(i);}
                                     }
                                     ];
            [alertVC addAction:action];
        }
    }
    if (cancelStr)
    {
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:cancelStr
                                                         style:(UIAlertActionStyleCancel)
                                                       handler:^(UIAlertAction * _Nonnull action)
                                 {
                                     if (cancelAction) { cancelAction();}
                                 }
                                 ];
        [alertVC addAction:cancel];
    }
    return alertVC;
}

+ (UIAlertController *)alertWithTitle:(NSString *)title
                              message:(NSString *)message
                       preferredStyle:(UIAlertControllerStyle)preferredStyle
                         actionTitles:(NSArray<NSString *> *)actionTitles
                          clickAction:(void(^)(NSInteger index))clickAction
                            cancelStr:(NSString *)cancelStr
                         cancelAction:(void(^)(void))cancelAction
{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:title
                                                                     message:message
                                                              preferredStyle:preferredStyle];
    if (actionTitles)
    {
        for (int i = 0;i < actionTitles.count;i++)
        {
            UIAlertAction *action = [UIAlertAction actionWithTitle:actionTitles[i]
                                                             style:(UIAlertActionStyleDefault)
                                                           handler:^(UIAlertAction * _Nonnull action)
                                     {
                                         if (clickAction) { clickAction(i);}
                                     }
                                     ];
            [alertVC addAction:action];
        }
    }
    if (cancelStr)
    {
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:cancelStr
                                                         style:(UIAlertActionStyleCancel)
                                                       handler:^(UIAlertAction * _Nonnull action)
                                 {
                                     if (cancelAction) { cancelAction();}
                                 }
                                 ];
        [alertVC addAction:cancel];
    }
    return alertVC;
}

@end
