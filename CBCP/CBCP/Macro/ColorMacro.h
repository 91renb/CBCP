//
//  ColorMacro.h
//  CBCP
//
//  Created by LC on 2017/5/13.
//  Copyright © 2017年 LC. All rights reserved.
//

#ifndef ColorMacro_h
#define ColorMacro_h


#define CB_hexColor(colorV)   [UIColor colorWithHexColorString:@#colorV]
#define CB_rgb(r,g,b)    [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:1.0]
#define CB_rgba(r,g,b,a)    [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:a]
#define CB_rgb_hex(rgbValue)    [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define ALLVIEWBACKCOLOR          CB_rgb(246, 246, 246)
#define Navi_Title_Color          CB_rgb(15, 136, 235)

#define CB_rgb_81                 CB_rgb(81,81,81)
#define CB_rgb_51                 CB_rgb(51,51,51)

#endif /* ColorMacro_h */
