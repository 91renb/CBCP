//
//  CircleAllViewModel.h
//  CBCP
//
//  Created by LC on 2017/5/20.
//  Copyright © 2017年 LC. All rights reserved.
//

#import "CBViewModel.h"

@interface CircleAllViewModel : CBViewModel

@property (nonatomic, strong) RACSubject *refreshUI;

@property (nonatomic, strong) RACCommand *refreshDataCommand;

@property (nonatomic, strong) NSArray *dataArray;

@property (nonatomic, strong) RACSubject *cellClickSubject;

@end
