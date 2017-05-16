//
//  CBViewModel.m
//  CBCP
//
//  Created by LC on 2017/5/16.
//  Copyright © 2017年 LC. All rights reserved.
//

#import "CBViewModel.h"

@implementation CBViewModel

@synthesize httpManager  = _httpManager;

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    
    CBViewModel *viewModel = [super allocWithZone:zone];
    
    if (viewModel) {
        
        [viewModel CB_initialize];
    }
    return viewModel;
}

- (instancetype)initWithModel:(id)model {
    
    self = [super init];
    if (self) {
    }
    return self;
}

- (CBHttpManager *)httpManager {
    
    if (!_httpManager) {
        
        _httpManager = [CBHttpManager shareManager];
    }
    return _httpManager;
}

- (void)CB_initialize {}

@end
