//
//  CBCustomTabbar.h
//  CBCP
//
//  Created by LC on 2017/5/16.
//  Copyright © 2017年 LC. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^plusBtnClick)();

@interface CBCustomTabbar : UITabBar

@property (nonatomic, copy) plusBtnClick clickBlock;

@end
