//
//  HomeListView.m
//  CBCP
//
//  Created by LC on 2017/5/17.
//  Copyright © 2017年 LC. All rights reserved.
//

#import "HomeListView.h"
#import "HomeListViewModel.h"

@interface HomeListView ()

@property (strong, nonatomic) HomeListViewModel *viewModel;


@end

@implementation HomeListView

- (instancetype)initWithViewModel:(id<CBViewModelProtocol>)viewModel
{
    self.viewModel = (HomeListViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}

- (void)updateConstraints
{
    
    [super updateConstraints];
}

- (void)cb_setupViews
{
    
}

- (void)cb_bindViewModel
{
    [self.viewModel.refreshDataCommand execute:nil];
}

- (void)cb_addReturnKeyBoard
{
    
}



- (HomeListViewModel *)viewModel {
    
    if (!_viewModel) {
        
        _viewModel = [[HomeListViewModel alloc] init];
    }
    
    return _viewModel;
}

@end
