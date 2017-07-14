//
//  CircleDetailViewController.m
//  CBCP
//
//  Created by LC on 2017/7/13.
//  Copyright © 2017年 LC. All rights reserved.
//

#import "CircleDetailViewController.h"
#import "CircleDetailView.h"
#import "CircleDetailViewModel.h"
#import "CircleHotModel.h"

@interface CircleDetailViewController ()

@property (nonatomic ,strong) CircleDetailView *mainView;

@property (nonatomic ,strong) CircleDetailViewModel *viewModel;

@end

@implementation CircleDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (void)updateViewConstraints
{
    [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.top.mas_equalTo(64);
    }];
    [super updateViewConstraints];
}

- (void)cb_layoutNavigation
{
    
}

- (void)cb_getNewData
{
    
}

- (void)cb_addSubviews
{
    [self.view addSubview:self.mainView];
    
    [self.view setNeedsUpdateConstraints];
    [self.view updateConstraintsIfNeeded];
}

- (void)cb_bindViewModel
{
    
}





- (CircleDetailView *)mainView
{
    if (!_mainView) {
        _mainView = [[CircleDetailView alloc] initWithViewModel:self.viewModel];
        _mainView.model = self.model;
    }
    return _mainView;
}

- (CircleDetailViewModel *)viewModel
{
    if (!_viewModel) {
        _viewModel = [[CircleDetailViewModel alloc] init];
        _viewModel.postId = self.model.postId;
        NSLog(@"self.model.postId == %@",self.model.postId);
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
