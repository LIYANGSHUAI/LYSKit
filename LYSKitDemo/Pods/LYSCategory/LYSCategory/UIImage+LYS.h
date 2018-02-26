//
//  UIImage+LYS.h
//  LYSKit
//
//  Created by HENAN on 2018/2/26.
//  Copyright © 2018年 liyangshuai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (LYS)

+ (UIImage *)ly_imageWithColor:(UIColor *)color alpha:(CGFloat)alpha;

+ (UIImage *)ly_screenShot:(CGSize)size withTargetView:(UIView *)targetView;

+ (UIImage *)ly_downloadNetworkImageURL:(NSString *)urlStr;

- (NSData *)ly_compressionImageWithMaxWidth:(CGFloat)maxWidth limitSize:(NSInteger)limitSize;

@end
