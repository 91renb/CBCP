//
//  CBViewProtocol.h
//  CBCP
//
//  Created by LC on 2017/5/16.
//  Copyright © 2017年 LC. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CBViewModelProtocol;


@protocol CBViewProtocol <NSObject>

@optional

- (instancetype)initWithViewModel:(id <CBViewModelProtocol>)viewModel;

- (void)cb_bindViewModel;
- (void)cb_setupViews;
- (void)cb_addReturnKeyBoard;

@end
