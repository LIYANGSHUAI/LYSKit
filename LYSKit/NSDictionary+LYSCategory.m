//
//  NSDictionary+LYSCategory.m
//  LYSKitDemo
//
//  Created by HENAN on 2017/11/9.
//  Copyright © 2017年 HENAN. All rights reserved.
//

#import "NSDictionary+LYSCategory.h"

@implementation NSDictionary (LYSCategory)
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
