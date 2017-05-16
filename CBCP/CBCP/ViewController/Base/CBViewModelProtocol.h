//
//  CBViewModelProtocol.h
//  CBCP
//
//  Created by LC on 2017/5/16.
//  Copyright © 2017年 LC. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    CBHeaderRefresh_HasMoreData = 1,
    CBHeaderRefresh_HasNoMoreData,
    CBFooterRefresh_HasMoreData,
    CBFooterRefresh_HasNoMoreData,
    CBRefreshError,
    CBRefreshUI,
} CBRefreshDataStatus;

@protocol CBViewModelProtocol <NSObject>

- (instancetype)initWithModel:(id)model;

@property (strong, nonatomic)CBHttpManager *httpManager;


/**
 *  初始化
 */
- (void)CB_initialize;

@end
