//
//  CommonMacro.h
//  CBCP
//
//  Created by LC on 2017/5/13.
//  Copyright © 2017年 LC. All rights reserved.
//

#ifndef CommonMacro_h
#define CommonMacro_h


#define is_IPHONE4 (([[UIScreen mainScreen]bounds].size.height < 568)?YES:NO)
#define is_IPHONE5 (([[UIScreen mainScreen]bounds].size.height == 568)?YES:NO)
#define is_IPHONE6 (([[UIScreen mainScreen]bounds].size.height > 568)?YES:NO)

#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define NAVIGATION_BAR_HEIGHT       64
#define MAIN_BOTTOM_TABBAR_HEIGHT   49
#define TEXTFIELD_HEIGHT            40


#define  WeakSelf(x)   __weak typeof(*&self)x = self

#define USER(x) [[NSUserDefaults standardUserDefaults] objectForKey:x]

#define KNOTIFICATION_LOGIN     @"caibaologin"
#define KNOTIFICATION_NetWork     @"network"


#endif /* CommonMacro_h */
