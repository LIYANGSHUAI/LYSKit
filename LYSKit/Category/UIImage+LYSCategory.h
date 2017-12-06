//
//  UIImage+LYSCategory.h
//  LYSKitDemo
//
//  Created by HENAN on 2017/12/6.
//  Copyright © 2017年 HENAN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (LYSCategory)

// Create a given picture of a given transparency
+ (UIImage *)imageWithColor:(UIColor *)color alpha:(CGFloat)alpha;

// Screenshot function
+ (UIImage *)screenShot:(CGSize)size withTargetView:(UIView *)targetView;

// Download pictures (use a way to load a network picture with UIImage to download the download function)
+ (UIImage *)downloadNetworkImageURL:(NSString *)urlStr;

// Cyclic compressed picture
- (NSData *)compressionImageWithMaxWidth:(CGFloat)maxWidth limitSize:(NSInteger)limitSize;

@end

