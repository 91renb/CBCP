//
//  CommonMacro.h
//  CBCP
//
//  Created by LC on 2017/5/13.
//  Copyright © 2017年 LC. All rights reserved.
//

#ifndef CommonMacro_h
#define CommonMacro_h




//屏幕高、宽
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

#define NAVIGATION_BAR_HEIGHT       64
#define MAIN_BOTTOM_TABBAR_HEIGHT   49
#define TEXTFIELD_HEIGHT            40


#define ImageNamed(name) [UIImage imageNamed:name]


#define  WeakSelf(x)   __weak typeof(*&self)x = self

// 微软雅黑
#define CB_YAHEI_FONT(FONTSIZE) [UIFont fontWithName:@"MicrosoftYaHei" size:(FONTSIZE)]
// 英文 和 数字
#define CB_ENGLISH_FONT(FONTSIZE) [UIFont fontWithName:@"Helvetica Light" size:(FONTSIZE)]

//NSUserDefaults
#define USER(x) [[NSUserDefaults standardUserDefaults] objectForKey:x]

// 颜色(RGB)
#define RGBCOLOR(r, g, b)       [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBACOLOR(r, g, b, a)   [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

// View 圆角和加边框
#define ViewBorderRadius(View, Radius, Width, Color)\
                                                    \
                                                    [View.layer setCornerRadius:(Radius)];\
                                                    [View.layer setMasksToBounds:YES];\
                                                    [View.layer setBorderWidth:(Width)];\
                                                    [View.layer setBorderColor:[Color CGColor]]

// View 圆角
#define ViewRadius(View, Radius)\
                                \
                                [View.layer setCornerRadius:(Radius)];\
                                [View.layer setMasksToBounds:YES]


///打印日志
#ifndef __OPTIMIZE__

#define CBLog(...) printf("%s - %d: %s\n", __func__, __LINE__, [[NSString stringWithFormat:__VA_ARGS__]UTF8String]);

#endif

///获取设备
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6_Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)

///获取Xcode的版本号
#define XcodeAppVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

///系统版本号
#define VersionLargerThan7  ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#define VersionLargerThan8  ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

#define Version7  ([[[UIDevice currentDevice] systemVersion] floatValue] == 7.0)
#define Version8  ([[[UIDevice currentDevice] systemVersion] floatValue] == 8.0)

//系统版本号
#define _DEVICE_SYSTEM_VERSION_  [[[UIDevice currentDevice] systemVersion]floatValue]

// 是否Retina屏
#define isRetina    ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? \
                    CGSizeEqualToSize(CGSizeMake(640, 960), \
                    [[UIScreen mainScreen] currentMode].size) : \
                    NO)
// 当前语言
#define CURRENTLANGUAGE         ([[NSLocale preferredLanguages] objectAtIndex:0])


///正常字体
#define H30 [UIFont systemFontOfSize:30]
#define H29 [UIFont systemFontOfSize:29]
#define H28 [UIFont systemFontOfSize:28]
#define H27 [UIFont systemFontOfSize:27]
#define H26 [UIFont systemFontOfSize:26]
#define H25 [UIFont systemFontOfSize:25]
#define H24 [UIFont systemFontOfSize:24]
#define H23 [UIFont systemFontOfSize:23]
#define H22 [UIFont systemFontOfSize:22]
#define H20 [UIFont systemFontOfSize:20]
#define H19 [UIFont systemFontOfSize:19]
#define H18 [UIFont systemFontOfSize:18]
#define H17 [UIFont systemFontOfSize:17]
#define H16 [UIFont systemFontOfSize:16]
#define H15 [UIFont systemFontOfSize:15]
#define H14 [UIFont systemFontOfSize:14]
#define H13 [UIFont systemFontOfSize:13]
#define H12 [UIFont systemFontOfSize:12]
#define H11 [UIFont systemFontOfSize:11]
#define H10 [UIFont systemFontOfSize:10]
#define H8 [UIFont systemFontOfSize:8]

///粗体
#define HB20 [UIFont boldSystemFontOfSize:20]
#define HB18 [UIFont boldSystemFontOfSize:18]
#define HB16 [UIFont boldSystemFontOfSize:16]
#define HB14 [UIFont boldSystemFontOfSize:14]
#define HB13 [UIFont boldSystemFontOfSize:13]
#define HB12 [UIFont boldSystemFontOfSize:12]
#define HB11 [UIFont boldSystemFontOfSize:11]
#define HB10 [UIFont boldSystemFontOfSize:10]
#define HB8 [UIFont boldSystemFontOfSize:8]

///常用颜色
#define black_color     [UIColor blackColor]
#define blue_color      [UIColor blueColor]
#define brown_color     [UIColor brownColor]
#define clear_color     [UIColor clearColor]
#define darkGray_color  [UIColor darkGrayColor]
#define darkText_color  [UIColor darkTextColor]
#define white_color     [UIColor whiteColor]
#define yellow_color    [UIColor yellowColor]
#define red_color       [UIColor redColor]
#define orange_color    [UIColor orangeColor]
#define purple_color    [UIColor purpleColor]
#define lightText_color [UIColor lightTextColor]
#define lightGray_color [UIColor lightGrayColor]
#define green_color     [UIColor greenColor]
#define gray_color      [UIColor grayColor]
#define magenta_color   [UIColor magentaColor]


#endif /* CommonMacro_h */
