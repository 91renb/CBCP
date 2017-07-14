//
//  CircleDetailView.m
//  CBCP
//
//  Created by LC on 2017/7/13.
//  Copyright © 2017年 LC. All rights reserved.
//

#import "CircleDetailView.h"
#import "CircleDetailCell.h"
#import "CircleDetailViewModel.h"
#import "CircleCommentModel.h"
#import "CircleHotModel.h"
#import "CircleHotCell.h"

@interface CircleDetailView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic ,strong) UITableView *tableView;

@property (nonatomic ,strong) CircleDetailViewModel *viewModel;

@end

@implementation CircleDetailView

- (instancetype)initWithViewModel:(id<CBViewModelProtocol>)viewModel
{
    self.viewModel = (CircleDetailViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}

- (void)updateConstraints
{
    WS(weakSelf)
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(weakSelf);
        
    }];
    
    [super updateConstraints];
}

- (void)cb_bindViewModel
{
    [self.viewModel.refreshDataCommand execute:nil];
    
    @weakify(self);
    
    [self.viewModel.refreshUI subscribeNext:^(id x) {
        @strongify(self);
        
        
        [self.tableView reloadData];
        
        switch ([x integerValue]) {
            case CBHeaderRefresh_HasMoreData: {
                
                [self.tableView.mj_header endRefreshing];
                
                if (self.tableView.mj_footer == nil) {
                    
                    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
                        @strongify(self);
                        [self.viewModel.nextPageCommand execute:nil];
                    }];
                }
            }
                break;
            case CBHeaderRefresh_HasNoMoreData: {
                
                [self.tableView.mj_header endRefreshing];
                self.tableView.mj_footer = nil;
            }
                break;
            case CBFooterRefresh_HasMoreData: {
                
                [self.tableView.mj_header endRefreshing];
                [self.tableView.mj_footer resetNoMoreData];
                [self.tableView.mj_footer endRefreshing];
            }
                break;
            case CBFooterRefresh_HasNoMoreData: {
                
                [self.tableView.mj_header endRefreshing];
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }
                break;
            case CBRefreshError: {
                
                [self.tableView.mj_footer endRefreshing];
                [self.tableView.mj_header endRefreshing];
            }
                break;
                
            default:
                break;
        }
    }];
}

- (void)cb_setupViews
{
    [self addSubview:self.tableView];
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

- (void)cb_addReturnKeyBoard
{
    
}

- (CircleDetailViewModel *)viewModel
{
    if (!_viewModel) {
        _viewModel = [[CircleDetailViewModel alloc] init];
    }
    return _viewModel;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectZero];
        [_tableView registerClass:[CircleDetailCell class] forCellReuseIdentifier:@"detailCell"];
        [_tableView registerClass:[CircleHotCell class] forCellReuseIdentifier:@"hotCell"];
        
        WS(weakSelf)
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            
            [weakSelf.viewModel.refreshDataCommand execute:nil];
        }];
        _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            
            [weakSelf.viewModel.nextPageCommand execute:nil];
        }];
        
    }
    return _tableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }else {
        
        return self.viewModel.dataArray.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        return [self.tableView cellHeightForIndexPath:indexPath model:self.model keyPath:@"model" cellClass:[CircleHotCell class] contentViewWidth:SCREEN_WIDTH];
    }else{
        CircleCommentModel *model = self.viewModel.dataArray[indexPath.row];
        return [self.tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[CircleDetailCell class] contentViewWidth:SCREEN_WIDTH];

    }

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        CircleHotCell *cell = [tableView dequeueReusableCellWithIdentifier:@"hotCell"];
        if (cell == nil) {
            cell = [[CircleHotCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"hotCell"];
        }
        
        cell.model = self.model;
        [cell useCellFrameCacheWithIndexPath:indexPath tableView:tableView];
        
        return cell;
        
    }else{
        
        CircleDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"detailCell"];
        if (cell == nil) {
            cell = [[CircleDetailCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"detailCell"];
        }
        
        CircleCommentModel *model = self.viewModel.dataArray[indexPath.row];
        cell.indexPath = indexPath;
        cell.model = model;
        [cell useCellFrameCacheWithIndexPath:indexPath tableView:tableView];
        
        return cell;
        
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.viewModel.cellClickSubject sendNext:@(indexPath.row)];
}



- (void)didClickLikeButtonInCell:(UITableViewCell *)cell
{
    NSIndexPath *index = [self.tableView indexPathForCell:cell];
    __block CircleHotModel *model = self.viewModel.dataArray[index.row];
    
    NSInteger count = [model.likeCount integerValue];
    
    if (!model.like.length) {
        count++;
        model.like = @"1";
    } else {
        if (count > 0) {
            count--;
        }
        model.like = @"";
    }
    model.likeCount = [NSString stringWithFormat:@"%ld",count];
    [self.tableView reloadRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationNone];
    
}


@end
