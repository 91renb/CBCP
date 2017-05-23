//
//  URLMacro.h
//  CBCP
//
//  Created by LC on 2017/5/13.
//  Copyright © 2017年 LC. All rights reserved.
//

#ifndef URLMacro_h
#define URLMacro_h

#define K_URL_Home @"http://api.caipiao.163.com/clientHall_hallInfoAll.html?product=caipiao_client&mobileType=iphone&ver=4.32&channel=i4zhushou"

#define K_URL_Circle_Hot @"http://quanzi.caipiao.163.com/circle_getHotPosts.html?product=caipiao_client&mobileType=iphone&ver=4.32&channel=i4zhushou&apiVer=1.1&apiLevel=27&deviceId=27&sort=hot"
#define K_URL_Circle_Hot_Next(boardId) [NSString stringWithFormat:@"http://quanzi.caipiao.163.com/circle_getHotPosts.html?product=caipiao_client&mobileType=iphone&ver=4.32&channel=i4zhushou&apiVer=1.1&apiLevel=27&deviceId=278&maxId=%@&sort=hot",boardId]

#define K_URL_Circlr_List_title @"http://quanzi.caipiao.163.com/circle_getBoardList.html?product=caipiao_client&mobileType=iphone&ver=4.32&channel=i4zhushou&apiVer=1.1&apiLevel=27&deviceId=27"


#endif /* URLMacro_h */
