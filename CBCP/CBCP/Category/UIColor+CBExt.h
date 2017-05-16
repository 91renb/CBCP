//
//  UIColor+CBExt.h
//  CBCP
//
//  Created by LC on 2017/5/13.
//  Copyright © 2017年 LC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (CBExt)

/**
 颜色字符串要以#开头

 @param rgb <#rgba description#>
 @return <#return value description#>
 */
+ (instancetype)colorWithHexRGB:(NSString *)rgb;
+ (instancetype)colorWithHexRGBA:(NSString *)rgba;
+ (instancetype)colorWithHexARGB:(NSString *)argb;


/**
 随机颜色

 @return <#return value description#>
 */
+ (UIColor *)randomColor;
+ (UIColor *)randomColorWithAlpha:(CGFloat)alpha;

@end
