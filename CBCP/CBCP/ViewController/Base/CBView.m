//
//  CBView.m
//  CBCP
//
//  Created by LC on 2017/5/16.
//  Copyright © 2017年 LC. All rights reserved.
//

#import "CBView.h"

@implementation CBView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [self cb_setupViews];
        [self cb_bindViewModel];
    }
    return self;
}

- (instancetype)initWithViewModel:(id <CBViewModelProtocol>)viewModel
{
    self = [super init];
    if (self) {
        
        [self cb_setupViews];
        [self cb_bindViewModel];
    }
    return self;
}

- (void)cb_bindViewModel {
}

- (void)cb_setupViews {
}

- (void)cb_addReturnKeyBoard {
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    [tap.rac_gestureSignal subscribeNext:^(id x) {
        
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        [appDelegate.window endEditing:YES];
    }];
    [self addGestureRecognizer:tap];
}


@end
