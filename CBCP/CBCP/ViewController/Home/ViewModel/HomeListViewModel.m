//
//  HomeListViewModel.m
//  CBCP
//
//  Created by LC on 2017/5/17.
//  Copyright © 2017年 LC. All rights reserved.
//

#import "HomeListViewModel.h"
#import "HomeHeaderModel.h"
#import "HomeYouLikeModel.h"
#import "HomeListModel.h"
@implementation HomeListViewModel

- (void)cb_initialize
{
    @weakify(self);
    [self.refreshDataCommand.executionSignals.switchToLatest subscribeNext:^(id data) {
        @strongify(self);
        NSDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        NSLog(@"%@",responseJSON);

        NSMutableArray *headerArray = [NSMutableArray new];
        NSArray *headArr = [responseJSON objectForKey:@"adInfo"];
        for (NSDictionary *dic in headArr) {
            HomeHeaderModel *model = [[HomeHeaderModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [headerArray addObject:model];
        }
        self.headerViewModel.dataArray = headerArray;
        
        
        HomeYouLikeModel *likeModel = [[HomeYouLikeModel alloc] init];
        likeModel.imageUrl = @"http://pimg1.126.net/caipiao_info/images/headFigure/newAppHall/1494937371917_1.jpg";
        likeModel.linkUrl = @"https://caipiao.163.com/nfop/88hb/index.htm";
        self.youLikeViewModel.dataArray = @[likeModel];
        
        
        NSMutableArray *listArray = [NSMutableArray new];
        NSArray *listArr = [[responseJSON objectForKey:@"card"] objectForKey:@"cardList"];
        for (NSDictionary *dic in listArr) {
            HomeListModel *model = [[HomeListModel alloc] init];
            [model setValuesForKeysWithDictionary:[dic objectForKey:@"attribute"]];
            [headerArray addObject:model];
        }
        self.dataArray = listArray;
        
        [self.headerViewModel.refreshUISubject sendNext:nil];
        [self.youLikeViewModel.refreshUISubject sendNext:nil];
        
        DismissHud();
    }];
    
    [[[self.refreshDataCommand.executing skip:1] take:1] subscribeNext:^(id x) {
        
        if ([x isEqualToNumber:@(YES)]) {
            
            ShowMaskStatus(@"正在加载");
        }
    }];
    
    
    
}

- (RACSubject *)refreshUI {
    
    if (!_refreshUI) {
        
        _refreshUI = [RACSubject subject];
    }
    
    return _refreshUI;
}

- (RACSubject *)refreshEndSubject {
    
    if (!_refreshEndSubject) {
        
        _refreshEndSubject = [RACSubject subject];
    }
    
    return _refreshEndSubject;
}


- (RACCommand *)refreshDataCommand
{
    if (!_refreshDataCommand) {
        
        @weakify(self);

        _refreshDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            @strongify(self);
            
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                
                @strongify(self);

                [self.httpManager requestWithPath:K_URL_Home paramenters:@{} HttpRequestType:HttpRequestPost success:^(NSURLSessionDataTask *task, id responseObject) {
                    
                    [subscriber sendNext:responseObject];
                    [subscriber sendCompleted];
                    
                } failure:^(NSURLSessionDataTask *task, NSError *error) {
                    
                    ShowErrorStatus(@"网络连接失败");
                    [subscriber sendCompleted];
                    
                } netWork:^(BOOL netWork) {
                    
                    ShowErrorStatus(@"暂无网络");
                    [subscriber sendCompleted];
                    
                }];
                return nil;

            }];
            
        }];
    }
    return _refreshDataCommand;
}


- (HomeHeaderViewModel *)headerViewModel
{
    if (!_headerViewModel) {
        _headerViewModel = [[HomeHeaderViewModel alloc] init];
        _headerViewModel.cellClickSubject = self.cellClickSubject;
    }
    return _headerViewModel;
}

- (HomeYouLikeViewModel *)youLikeViewModel
{
    if (!_youLikeViewModel) {
        _youLikeViewModel = [[HomeYouLikeViewModel alloc] init];
        _youLikeViewModel.title = @"猜你喜欢";
        _youLikeViewModel.cellClickSubject = self.cellClickSubject;
    }
    return _youLikeViewModel;
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
