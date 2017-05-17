//
//  HomeViewController.m
//  CBCP
//
//  Created by LC on 2017/5/16.
//  Copyright © 2017年 LC. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeListViewModel.h"
#import "HomeListView.h"

@interface HomeViewController ()

@property (nonatomic ,strong) HomeListViewModel *viewModel;
@property (nonatomic ,strong) HomeListView *listView;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)updateViewConstraints
{
    WS(weakSelf)
    
    [self.listView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(weakSelf.view);
    }];
    
    [super updateViewConstraints];

}


- (void)cb_bindViewModel
{
    @weakify(self);
    [[self.viewModel.cellClickSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id x) {
        
        @strongify(self);
//        YDViewController *circleMainVC = [[YDViewController alloc] init];
//        [self.navigationController pushViewController:circleMainVC animated:YES];
    }];
}

- (void)cb_addSubviews
{
    [self.view addSubview:self.listView];

}

- (void)cb_layoutNavigation
{
    self.navigationV.backBtn.hidden = YES;
    self.Title = @"首页";

}



- (HomeListView *)listView
{
    if (!_listView) {
        _listView = [[HomeListView alloc] initWithViewModel:self.viewModel];
    }
    return _listView;
}


- (HomeListViewModel *)viewModel
{
    if (!_viewModel) {
        _viewModel = [[HomeListViewModel alloc] init];
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
