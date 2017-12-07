//
//  NSDictionary+LYSCategory.m
//  LYSKitDemo
//
//  Created by HENAN on 2017/12/6.
//  Copyright © 2017年 HENAN. All rights reserved.
//

#import "NSDictionary+LYSCategory.h"

@implementation NSDictionary (LYSCategory)

/**
 返回数据

 @return 返回数据
 */
- (NSString *)toString
{
    NSData *dictData = [NSJSONSerialization dataWithJSONObject:self options:(NSJSONWritingPrettyPrinted) error:nil];
    NSString *dictStr = [[NSString alloc] initWithData:dictData encoding:NSUTF8StringEncoding];
    return dictStr;
}
+ (void)printPropertyCodeWithDict:(NSDictionary *)dict
{
    NSMutableString *strM = [NSMutableString string];
    [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull propertyName, id  _Nonnull value, BOOL * _Nonnull stop)
     {
         NSString *code;
         if ([value isKindOfClass:NSClassFromString(@"__NSCFString")])
         {
             code = [NSString stringWithFormat:@"@property (nonatomic, copy) NSString *%@;",propertyName]             ;
         }
         else if ([value isKindOfClass:NSClassFromString(@"__NSCFNumber")])
         {
             code = [NSString stringWithFormat:@"@property (nonatomic, assign) int %@;",propertyName]             ;
         }else if ([value isKindOfClass:NSClassFromString(@"__NSCFArray")])
         {
             code = [NSString stringWithFormat:@"@property (nonatomic, strong) NSArray *%@;",propertyName]             ;
         }else if ([value isKindOfClass:NSClassFromString(@"__NSCFDictionary")])
         {
             code = [NSString stringWithFormat:@"@property (nonatomic, strong) NSDictionary *%@;",propertyName]             ;
         }else if ([value isKindOfClass:NSClassFromString(@"__NSCFBoolean")])
         {
             code = [NSString stringWithFormat:@"@property (nonatomic, assign) BOOL %@;",propertyName]             ;
         }else {
             code = [NSString stringWithFormat:@"@property (nonatomic, copy) NSString *%@;",propertyName]             ;
         }
         [strM appendFormat:@"%@\n",code];
     }];
    NSLog(@"%@",strM);
}
@end
