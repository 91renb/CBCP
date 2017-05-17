//
//  HomeYouLikeViewModel.m
//  CBCP
//
//  Created by LC on 2017/5/17.
//  Copyright © 2017年 LC. All rights reserved.
//

#import "HomeYouLikeViewModel.h"

@implementation HomeYouLikeViewModel

- (NSArray *)dataArray {
    
    if (!_dataArray) {
        
        _dataArray = [[NSArray alloc] init];
    }
    
    return _dataArray;
}

- (RACSubject *)refreshUISubject {
    
    if (!_refreshUISubject) {
        
        _refreshUISubject = [RACSubject subject];
    }
    
    return _refreshUISubject;
}

- (RACSubject *)cellClickSubject {
    
    if (!_cellClickSubject) {
        
        _cellClickSubject = [RACSubject subject];
    }
    
    return _cellClickSubject;
}

@end
