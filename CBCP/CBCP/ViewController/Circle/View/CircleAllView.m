//
//  CircleAllView.m
//  CBCP
//
//  Created by LC on 2017/5/22.
//  Copyright © 2017年 LC. All rights reserved.
//

#import "CircleAllView.h"
#import "CircleAllViewModel.h"
#import "CircleAllCell.h"
#import "CircleAllModel.h"
#import "UIView+SDAutoLayout.h"
#import "UITableView+SDAutoTableViewCellHeight.h"

@interface CircleAllView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic ,strong) CircleAllViewModel *viewModel;

@property (nonatomic ,strong) UITableView *tableView;


@end

@implementation CircleAllView

- (instancetype)initWithViewModel:(id<CBViewModelProtocol>)viewModel
{
    self.viewModel = (CircleAllViewModel *)viewModel;
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

- (void)cb_setupViews
{
    [self addSubview:self.tableView];
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}



- (void)cb_bindViewModel
{
    [self.viewModel.refreshDataCommand execute:nil];
    
    @weakify(self);
    
    [self.viewModel.refreshUI subscribeNext:^(id x) {
        @strongify(self);
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView reloadData];

    }];
}

- (CircleAllViewModel *)viewModel
{
    if (!_viewModel) {
        _viewModel = [[CircleAllViewModel alloc] init];
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
        [_tableView registerClass:[CircleAllCell class] forCellReuseIdentifier:@"cell"];
        
        WS(weakSelf)
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            
            [weakSelf.viewModel.refreshDataCommand execute:nil];
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
    return self.viewModel.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CircleAllCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[CircleAllCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    
    CircleAllModel *model = self.viewModel.dataArray[indexPath.row];
    
    cell.model = model;
    [cell useCellFrameCacheWithIndexPath:indexPath tableView:tableView];
    
    return cell;
}




@end
