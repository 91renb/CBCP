//
//  UIImage+Compression.h
//  AFNetworkingPro
//
//  Created by LC on 17/2/7.
//  Copyright © 2017年 LC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Compression)


/**
 图片压缩

 @param sourceImage 被压缩的图片
 @param defineWidth 被压缩的尺寸(宽)
 @return 被压缩的图片
 */
+ (UIImage *)imageCompressed:(UIImage *)sourceImage withdefineWidth:(CGFloat)defineWidth;
@end
