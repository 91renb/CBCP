//
//  CircleDetailViewModel.m
//  CBCP
//
//  Created by LC on 2017/7/14.
//  Copyright © 2017年 LC. All rights reserved.
//

#import "CircleDetailViewModel.h"

@interface CircleDetailViewModel ()

@property (nonatomic ,copy) NSString *commentId;

@end

@implementation CircleDetailViewModel



- (void)cb_initialize
{
    @weakify(self);
    [self.refreshDataCommand.executionSignals.switchToLatest subscribeNext:^(NSDictionary *responseJSON) {
        @strongify(self);
        
        NSArray *array = [responseJSON objectForKey:@"posts"];
        NSMutableArray *resultArray = [NSMutableArray array];
//        for (NSDictionary *dic in array) {
//            CircleHotModel *model = [CircleHotModel new];
//            [model setValuesForKeysWithDictionary:dic];
//            
//            NSMutableArray *resultImageArray = [NSMutableArray array];
//            NSArray *imageArray = dic[@"imageList"];
//            for (NSDictionary *diction in imageArray) {
//                CircleHotImageModel *imageModel = [CircleHotImageModel new];
//                [imageModel setValuesForKeysWithDictionary:diction];
//                [resultImageArray addObject:imageModel];
//            }
//            
//            model.imageList = resultImageArray;
//            if ([model.showTag isEqualToString:@"0"]) {
//                [resultArray addObject:model];
//            }
//            self.lastPostId = model.postId;
//        }
//        
        self.dataArray = resultArray;

        [self.refreshUI sendNext:@(CBHeaderRefresh_HasMoreData)];
        DismissHud();
        
    }];
    
    [[[self.refreshDataCommand.executing skip:1] take:1] subscribeNext:^(id x) {
        
        if ([x isEqualToNumber:@(YES)]) {
            
            ShowMaskStatus(@"正在加载");
        }
    }];
    
    [self.nextPageCommand.executionSignals.switchToLatest subscribeNext:^(NSDictionary *responseJSON) {
        
        @strongify(self);
        
        NSArray *array = [responseJSON objectForKey:@"posts"];
        NSMutableArray *resultArray = [NSMutableArray arrayWithArray:self.dataArray];
//        for (NSDictionary *dic in array) {
//            CircleHotModel *model = [CircleHotModel new];
//            [model setValuesForKeysWithDictionary:dic];
//            
//            NSMutableArray *resultImageArray = [NSMutableArray array];
//            NSArray *imageArray = dic[@"imageList"];
//            for (NSDictionary *diction in imageArray) {
//                CircleHotImageModel *imageModel = [CircleHotImageModel new];
//                [imageModel setValuesForKeysWithDictionary:diction];
//                [resultImageArray addObject:imageModel];
//            }
//            
//            model.imageList = resultImageArray;
//            if ([model.showTag isEqualToString:@"0"]) {
//                [resultArray addObject:model];
//            }
//            self.lastPostId = model.postId;
//            
//        }
//        
        self.dataArray = resultArray;
        [self.refreshUI sendNext:@(CBFooterRefresh_HasMoreData)];
        DismissHud();
    }];
}


- (RACSubject *)refreshUI {
    
    if (!_refreshUI) {
        
        _refreshUI = [RACSubject subject];
    }
    
    return _refreshUI;
}


- (RACCommand *)refreshDataCommand {
    
    if (!_refreshDataCommand) {
        
        @weakify(self);
        _refreshDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            @strongify(self);
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                
                @strongify(self);
                
                [self.httpManager requestWithPath:K_URL_Circle_Detail_CommentList(self.postId) paramenters:@{} HttpRequestType:HttpRequestPost success:^(NSURLSessionDataTask *task, id responseObject) {
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

- (RACCommand *)nextPageCommand {
    
    if (!_nextPageCommand) {
        
        @weakify(self);
        _nextPageCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            @strongify(self);
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                
                @strongify(self);
                
                [self.httpManager requestWithPath:K_URL_Circle_Detail_CommentList_Next(self.commentId,self.postId) paramenters:@{} HttpRequestType:HttpRequestPost success:^(NSURLSessionDataTask *task, id responseObject) {
                    
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
    
    return _nextPageCommand;
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
