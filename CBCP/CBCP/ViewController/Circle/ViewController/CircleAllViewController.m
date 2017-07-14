//
//  CircleAllViewController.m
//  CBCP
//
//  Created by LC on 2017/5/20.
//  Copyright © 2017年 LC. All rights reserved.
//

#import "CircleAllViewController.h"
#import "CircleAllViewModel.h"
#import "CircleAllView.h"
#import "CircleAllModel.h"
#import "CircleHotViewController.h"
#import "HomeViewController.h"
@interface CircleAllViewController ()

@property (nonatomic ,strong) CircleAllViewModel *viewModel;

@property (nonatomic ,strong) CircleAllView *mainView;

@end

@implementation CircleAllViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)updateViewConstraints
{
    WS(weakSelf);
    [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(weakSelf.view);
    }];
    
    [super updateViewConstraints];
}

- (void)cb_addSubviews
{
    [self.view addSubview:self.mainView];

    [self.view setNeedsUpdateConstraints];
    [self.view updateConstraintsIfNeeded];
}

- (void)cb_bindViewModel
{
    [self.viewModel.cellClickSubject subscribeNext:^(id x) {
        NSInteger index = [x integerValue];
        CircleAllModel *model = [self.viewModel.dataArray objectAtIndex:index];
        
        CircleHotViewController *detail = [[CircleHotViewController alloc] init];
        detail.boardId = model.boardId;
        detail.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:detail animated:YES];
        
    }];
}


- (void)cb_layoutNavigation
{
    [self.navigationV removeFromSuperview];
}



- (CircleAllView *)mainView
{
    if (!_mainView) {
        _mainView = [[CircleAllView alloc] initWithViewModel:self.viewModel];
    }
    return _mainView;
}

- (CircleAllViewModel *)viewModel
{
    if (!_viewModel) {
        _viewModel = [[CircleAllViewModel alloc] init];
    }
    return _viewModel;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
