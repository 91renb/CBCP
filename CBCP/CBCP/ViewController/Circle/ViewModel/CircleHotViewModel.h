//
//  CircleHotViewModel.h
//  CBCP
//
//  Created by LC on 2017/5/20.
//  Copyright © 2017年 LC. All rights reserved.
//

#import "CBViewModel.h"
#import "CircleHotViewModel.h"
@interface CircleHotViewModel : CBViewModel

@property (nonatomic, strong) RACSubject *refreshUI;

@property (nonatomic, strong) RACCommand *refreshDataCommand;

@property (nonatomic, strong) RACCommand *nextPageCommand;

@property (nonatomic, strong) NSArray *dataArray;

@property (nonatomic, strong) RACSubject *cellClickSubject;

@property (nonatomic ,copy) NSString *boardId;

@end
