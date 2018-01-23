
#import <UIKit/UIKit.h>
#import "LYS_BaseObj.h"

@interface LYSystemManager : NSObject

// 获取设备类型
+ (LYSTuple)ly_deviceString;

@end

@class CLLocation;

@class CLPlacemark;

@interface LYSLocationManager : NSObject

// 获取位置信息(如果此方法调用多次,那么下次的回调函数会覆盖上次的回调,前提时此时还没有定位成功)
+ (void)ly_location:(void(^)(CLLocation *location))success
               fail:(void(^)(NSString *state))fail;

// 对定位信息进行反编码
+ (void)ly_geocoder:(CLLocation *)location
            success:(void(^)(CLPlacemark *placemark))success;

@end

@interface LYSAPPDelegateManager : NSObject

// 设置window的跟视图控制器
+ (void)ly_createWindowAndSetRootViewController:(UIViewController *)rootViewController;
+ (void)ly_setWindowRootViewController:(UIViewController *)rootViewController;

// 根据返回条件分别显示不同的视图控制器
+ (void)ly_if:(BOOL(^)(void))ispermit showViewController:(UIViewController *)firstViewController elseShowViewController:(UIViewController *)secoundViewController;

// 设置启动动画
+ (void)ly_createWindowAndloadStartInterface:(UIViewController *)startInterface mainInterface:(UIViewController *)mainInterface delay:(NSTimeInterval)interval durtion:(NSTimeInterval)durtion;

// 模仿导航切换
+ (void)pushFrom:(UIViewController *)fromVC toViewController:(UIViewController *)toVC completion:(void(^)(void))completion;
+ (void)popFrom:(UIViewController *)fromVC toViewController:(UIViewController *)toVC completion:(void(^)(void))completion;

@end

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

// 创建LYSDate对象
LYDate ly_CreateDate(NSInteger y,
                     NSInteger m,
                     NSInteger d,
                     NSInteger h,
                     NSInteger f,
                     NSInteger s);

// 判断两个日期
bool ly_IsEqual(LYDate date1,LYDate date2);
bool ly_SameYear(LYDate date1,LYDate date2);
bool ly_SameMonth(LYDate date1,LYDate date2);
bool ly_SameDay(LYDate date1,LYDate date2);

// 比较两个日期返回(1, 0, -1)对应(date1比date2晚,date1和date2一样,date1比date2晚),最小比较到日,如果具体到时分秒,则不能区分
NSInteger ly_CompareDate(LYDate date1,LYDate date2);

@interface LYSDateManager : NSObject

// 获取今天的LYDate格式
+ (LYDate)ly_Today;

// 将某一日期转换为LYDate格式
+ (LYDate)ly_LYDateFromDate:(NSDate *)date;

// 获取给定日期是星期几
+ (NSInteger)ly_WeekDayForDate:(NSDate *)date;

// 获取这个月有多少天
+ (NSInteger)ly_DayNumForDate:(NSDate *)date;

// 获取这个月的第一天星期几
+ (NSInteger)ly_WeekDayForFirstDate:(NSDate *)date;

// 获取给定日期是几号
+ (NSInteger)ly_DayForDate:(NSDate *)date;

// 获取今天是几号
+ (NSInteger)ly_DayForToday;

// 将LYDate转为NSDate
+ (NSDate *)ly_DateFromLYDate:(LYDate)date;

@end
