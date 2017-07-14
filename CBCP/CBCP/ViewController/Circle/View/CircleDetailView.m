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
        [_tableView registerClass:[CircleDetailCell class] forCellReuseIdentifier:@"cell"];
        
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
//    return self.viewModel.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CircleHotModel *model = self.viewModel.dataArray[indexPath.row];
    return [self.tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[CircleHotCell class] contentViewWidth:SCREEN_WIDTH];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CircleHotCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[CircleHotCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    
    CircleHotModel *model = self.viewModel.dataArray[indexPath.row];
    
    cell.model = model;
    [cell useCellFrameCacheWithIndexPath:indexPath tableView:tableView];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.viewModel.cellClickSubject sendNext:@(indexPath.row)];
    //    CircleHotModel *model = self.viewModel.dataArray[indexPath.row];
    //    OneCircleViewController *circle = [OneCircleViewController new];
    //    circle.listModel = model;
    //    [self.navigationController pushViewController:circle animated:YES];
}

#pragma mark - CircleDetailDelegate
- (void)didClickUserNameInCell:(UITableViewCell *)cell
{
    //    NSIndexPath *index = [self.tableView indexPathForCell:cell];
    //    CircleListModel *model = self.dataSource[index.row];
    //    OneCircleViewController *circle = [OneCircleViewController new];
    //    circle.listModel = model;
    //    [self.navigationController pushViewController:circle animated:YES];
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

- (void)didClickCommentButtonInCell:(UITableViewCell *)cell
{
    //    NSIndexPath *index = [self.tableView indexPathForCell:cell];
    //    CircleListModel *model = self.dataSource[index.row];
    //    OneCircleViewController *circle = [OneCircleViewController new];
    //    circle.listModel = model;
    //    [self.navigationController pushViewController:circle animated:YES];
}


@end