//
//  HomeListViewModel.h
//  CBCP
//
//  Created by LC on 2017/5/17.
//  Copyright © 2017年 LC. All rights reserved.
//

#import "CBViewModel.h"
#import "HomeYouLikeViewModel.h"
#import "HomeHeaderViewModel.h"

@interface HomeListViewModel : CBViewModel


@property (nonatomic, strong) RACSubject *refreshEndSubject;

@property (nonatomic, strong) RACSubject *refreshUI;

@property (nonatomic, strong) RACCommand *refreshDataCommand;

@property (nonatomic ,strong) HomeYouLikeViewModel *youLikeViewModel;

@property (nonatomic ,strong) HomeHeaderViewModel *headerViewModel;

@property (nonatomic, strong) NSArray *dataArray;

@property (nonatomic, strong) RACSubject *cellClickSubject;

@end
