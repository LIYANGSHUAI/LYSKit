//
//  UIImage+LYS.m
//  LYSKit
//
//  Created by HENAN on 2018/2/26.
//  Copyright © 2018年 liyangshuai. All rights reserved.
//

#import "UIImage+LYS.h"

@implementation UIImage (LYS)

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
