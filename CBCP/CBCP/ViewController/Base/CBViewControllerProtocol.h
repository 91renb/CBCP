//
//  CBViewControllerProtocol.h
//  CBCP
//
//  Created by LC on 2017/5/16.
//  Copyright © 2017年 LC. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CBViewModelProtocol;

@protocol CBViewControllerProtocol <NSObject>

@optional
- (instancetype)initWithViewModel:(id <CBViewModelProtocol>)viewModel;

- (void)cb_bindViewModel;
- (void)cb_addSubviews;
- (void)cb_layoutNavigation;
- (void)cb_getNewData;
- (void)recoverKeyboard;

@end
