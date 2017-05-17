//
//  HomeYouLikeViewModel.h
//  CBCP
//
//  Created by LC on 2017/5/17.
//  Copyright © 2017年 LC. All rights reserved.
//

#import "CBViewModel.h"

@interface HomeYouLikeViewModel : CBViewModel

@property (nonatomic, copy) NSString *title;

@property (nonatomic, strong) NSArray *dataArray;

@property (nonatomic, strong) RACSubject *refreshUISubject;

@property (nonatomic, strong) RACSubject *cellClickSubject;

@end
