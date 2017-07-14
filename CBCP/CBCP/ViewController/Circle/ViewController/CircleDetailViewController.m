//
//  CircleDetailViewController.m
//  CBCP
//
//  Created by LC on 2017/7/13.
//  Copyright © 2017年 LC. All rights reserved.
//

#import "CircleDetailViewController.h"
#import "CircleDetailView.h"

@interface CircleDetailViewController ()

@property (nonatomic ,strong) CircleDetailView *mainView;

@end

@implementation CircleDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (void)updateViewConstraints
{
    
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
    
}

- (void)cb_bindViewModel
{
    
}





- (CircleDetailView *)mainView
{
    if (!_mainView) {
        _mainView = [[CircleDetailView alloc] init];
    }
    return _mainView;
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
