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

//热帖
#define K_URL_Circle_Hot @"http://quanzi.caipiao.163.com/circle_getHotPosts.html?product=caipiao_client&mobileType=iphone&ver=4.32&channel=i4zhushou&apiVer=1.1&apiLevel=27&deviceId=27&sort=hot"
#define K_URL_Circle_Hot_Next(boardId) [NSString stringWithFormat:@"http://quanzi.caipiao.163.com/circle_getHotPosts.html?product=caipiao_client&mobileType=iphone&ver=4.32&channel=i4zhushou&apiVer=1.1&apiLevel=27&deviceId=278&maxId=%@&sort=hot",boardId]

//帖子
#define K_URL_Circle_Detail(boardId) [NSString stringWithFormat:@"http://quanzi.caipiao.163.com/circle_getPosts.html?product=caipiao_client&mobileType=iphone&ver=4.32&channel=i4zhushou&apiVer=1.1&apiLevel=27&deviceId=27&boardId=%@&sort=hot",boardId]
#define K_URL_Circle_Detail_Next(boardId,postId) [NSString stringWithFormat:@"http://quanzi.caipiao.163.com/circle_getPosts.html?product=caipiao_client&mobileType=iphone&ver=4.32&channel=i4zhushou&apiVer=1.1&apiLevel=27&deviceId=27&boardId=%@&maxId=%@&sort=hot",boardId,postId]


//帖子详情
#define K_URL_Circle_Detail_CommentList(postId) [NSString stringWithFormat:@"http://quanzi.caipiao.163.com/circle_postInfo.html?product=caipiao_client&mobileType=iphone&ver=4.32&channel=i4zhushou&apiVer=1.1&apiLevel=27&deviceId=278&postId=%@",postId]
#define K_URL_Circle_Detail_CommentList_Next(commentId,postId) [NSString stringWithFormat:@"http://quanzi.caipiao.163.com/circle_postInfo.html?product=caipiao_client&mobileType=iphone&ver=4.32&channel=i4zhushou&apiVer=1.1&apiLevel=27&deviceId=278&includeLast=0&lastId=%@&postId=%@",commentId,postId]



//圈子
#define K_URL_Circlr_List_title @"http://quanzi.caipiao.163.com/circle_getBoardList.html?product=caipiao_client&mobileType=iphone&ver=4.32&channel=i4zhushou&apiVer=1.1&apiLevel=27&deviceId=27"


#endif /* URLMacro_h */
