//
//  CircleAllViewModel.m
//  CBCP
//
//  Created by LC on 2017/5/20.
//  Copyright © 2017年 LC. All rights reserved.
//

#import "CircleAllViewModel.h"
#import "CircleAllModel.h"

@implementation CircleAllViewModel

- (void)cb_initialize
{
    @weakify(self);

    [self.refreshDataCommand.executionSignals.switchToLatest subscribeNext:^(NSDictionary *responseJSON) {
        @strongify(self);

        NSArray *array = [responseJSON objectForKey:@"boards"];
        NSMutableArray *resultArray = [NSMutableArray array];
        for (NSDictionary *dic in array) {
            CircleAllModel *model = [CircleAllModel new];
            [model setValuesForKeysWithDictionary:dic];
            if ([model.boardName isEqualToString:model.desc]) {
                [resultArray addObject:model];
            }
        }
        self.dataArray = resultArray;
        [self.refreshUI sendNext:@(CBHeaderRefresh_HasNoMoreData)];
        DismissHud();
        
    }];
    
    [[[self.refreshDataCommand.executing skip:1] take:1] subscribeNext:^(id x) {
        
        if ([x isEqualToNumber:@(YES)]) {
            
            ShowMaskStatus(@"正在加载");
        }
    }];
}


- (RACCommand *)refreshDataCommand
{
    if (!_refreshDataCommand) {
        @weakify(self);

        _refreshDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self);

            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                @strongify(self);
                [self.httpManager requestWithPath:K_URL_Circlr_List_title paramenters:@{} HttpRequestType:HttpRequestPost success:^(NSURLSessionDataTask *task, id responseObject) {
                    NSDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
                    [subscriber sendNext:responseJSON];
                    [subscriber sendCompleted];
                } failure:^(NSURLSessionDataTask *task, NSError *error) {
                    ShowErrorStatus(@"网络连接失败");
                    [subscriber sendCompleted];
                } netWork:^(BOOL netWork) {
                    
                }];
                return nil;
            }];
        }];
    }
    return _refreshDataCommand;
}


- (RACSubject *)refreshUI {
    
    if (!_refreshUI) {
        
        _refreshUI = [RACSubject subject];
    }
    
    return _refreshUI;
}

- (NSArray *)dataArray {
    
    if (!_dataArray) {
        
        _dataArray = [[NSArray alloc] init];
    }
    
    return _dataArray;
}

- (RACSubject *)cellClickSubject {
    
    if (!_cellClickSubject) {
        
        _cellClickSubject = [RACSubject subject];
    }
    
    return _cellClickSubject;
}

@end
