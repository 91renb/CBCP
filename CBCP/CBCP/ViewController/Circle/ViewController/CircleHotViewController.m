//
//  CircleHotViewController.m
//  CBCP
//
//  Created by LC on 2017/5/20.
//  Copyright © 2017年 LC. All rights reserved.
//

#import "CircleHotViewController.h"
#import "CircleHotViewModel.h"
#import "CircleHotView.h"

@interface CircleHotViewController ()

@property (nonatomic ,strong) CircleHotViewModel *viewModel;
@property (nonatomic ,strong) CircleHotView *mainView;

@end

@implementation CircleHotViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (void)updateViewConstraints
{
    WS(weakSelf)
    
    [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(weakSelf.view);
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
    
}

- (void)cb_layoutNavigation
{
    [self.navigationV removeFromSuperview];
}

- (void)cb_getNewData
{
    
}





#pragma mark - layzLoad
- (CircleHotView *)mainView {
    
    if (!_mainView) {
        
        _mainView = [[CircleHotView alloc] initWithViewModel:self.viewModel];
    }
    
    return _mainView;
}

- (CircleHotViewModel *)viewModel {
    
    if (!_viewModel) {
        
        _viewModel = [[CircleHotViewModel alloc] init];
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
