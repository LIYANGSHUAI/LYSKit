//
//  UIImage+LYSCategory.h
//  LYSKitDemo
//
//  Created by HENAN on 2017/11/9.
//  Copyright © 2017年 HENAN. All rights reserved.
//

#import <UIKit/UIKit.h>

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
