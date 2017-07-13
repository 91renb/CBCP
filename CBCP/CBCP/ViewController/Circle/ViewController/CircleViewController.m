//
//  CircleViewController.m
//  CBCP
//
//  Created by LC on 2017/5/16.
//  Copyright © 2017年 LC. All rights reserved.
//

#import "CircleViewController.h"
#import "CircleHotViewController.h"
#import "CircleAllViewController.h"

@interface CircleViewController ()
{
    UIButton *button_hot;
    UIButton *button_all;
    CBViewController *currentVC;
}
@property (nonatomic ,strong) UIView *titleView;
@property (nonatomic ,strong) CircleHotViewController *hotViewController;
@property (nonatomic ,strong) CircleAllViewController *allViewController;



@end

@implementation CircleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationV.backBtn.hidden = YES;

}


- (void)updateViewConstraints
{
    WS(weakSelf)
    
    [self.titleView mas_makeConstraints:^(MASConstraintMaker *make) {
    
        make.top.equalTo(weakSelf.navigationV).offset(27);
        make.centerX.mas_equalTo(weakSelf.navigationV);
        make.width.offset(120);
        make.height.offset(30);
        
    }];
    [button_hot mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.titleView);
        make.top.bottom.mas_equalTo(weakSelf.titleView);
        make.width.offset(60);
    }];
    [button_all mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(weakSelf.titleView);
        make.top.bottom.mas_equalTo(weakSelf.titleView);
        make.width.offset(60);
    }];
    [self.hotViewController.view mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.mas_equalTo(weakSelf.view);
        make.top.mas_equalTo(64);
        make.bottom.mas_equalTo(-49);
        
    }];
    
//
    
    [super updateViewConstraints];
}


- (void)cb_addSubviews
{

    [self addChildViewController:self.hotViewController];
    [self addChildViewController:self.allViewController];
    
    currentVC = self.hotViewController;
    [self.view addSubview:self.hotViewController.view];
    
}

- (void)cb_layoutNavigation
{
    [self.navigationV addSubview:self.titleView];
    [self.navigationV.titleLable removeFromSuperview];
}

- (void)cb_bindViewModel
{
    
}



- (void)touchButtonHot:(UIButton *)button
{
    button_hot.userInteractionEnabled = NO;
    button_all.userInteractionEnabled = YES;
    
    button_all.backgroundColor = Navi_Title_Color;
    [button_all setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    
    button_hot.backgroundColor = [UIColor whiteColor];
    [button_hot setTitleColor:Navi_Title_Color forState:UIControlStateNormal];
    
    
    [self transitionFromOldViewController:currentVC toNewViewController:self.hotViewController];
    WS(weakSelf)
    [self.hotViewController.view mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.mas_equalTo(weakSelf.view);
        make.top.mas_equalTo(64);
        make.bottom.mas_equalTo(-49);
        
    }];
}


- (void)touchButtonAll:(UIButton *)button
{
    button_all.userInteractionEnabled = NO;
    button_hot.userInteractionEnabled = YES;
    
    
    button_hot.backgroundColor = Navi_Title_Color;
    [button_hot setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    
    button_all.backgroundColor = [UIColor whiteColor];
    [button_all setTitleColor:Navi_Title_Color forState:UIControlStateNormal];
    
    
    [self transitionFromOldViewController:currentVC toNewViewController:self.allViewController];
    
    WS(weakSelf)
    [self.allViewController.view mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.mas_equalTo(weakSelf.view);
        make.top.mas_equalTo(64);
        make.bottom.mas_equalTo(-49);
    }];
}



//转换子视图控制器
- (void)transitionFromOldViewController:(CBViewController *)oldViewController toNewViewController:(CBViewController *)newViewController{
    [self transitionFromViewController:oldViewController toViewController:newViewController duration:0.25 options:UIViewAnimationOptionTransitionNone animations:nil completion:^(BOOL finished) {
        
        
        
        if (finished) {
            [newViewController didMoveToParentViewController:self];
            currentVC = newViewController;
        }else{
            currentVC = oldViewController;
        }
        
        
    }];
}


- (CircleHotViewController *)hotViewController
{
    if (!_hotViewController) {
        _hotViewController = [[CircleHotViewController alloc] init];
        _hotViewController.isChridController = @"1";
        
    }
    return _hotViewController;
}

- (CircleAllViewController *)allViewController
{
    if (!_allViewController) {
        _allViewController = [[CircleAllViewController alloc] init];
        
    }
    return _allViewController;
}


- (UIView *)titleView
{
    if (!_titleView) {
        _titleView = [[UIView alloc] init];
        
        button_hot = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [button_hot setTitle:@"热帖" forState:UIControlStateNormal];
        [button_hot setTitleColor:Navi_Title_Color forState:UIControlStateNormal];
        button_hot.layer.borderWidth = 1;
        button_hot.layer.borderColor = white_color.CGColor;
        button_hot.backgroundColor = white_color;
        [button_hot addTarget:self action:@selector(touchButtonHot:) forControlEvents:UIControlEventTouchUpInside];
        button_hot.titleLabel.font = [UIFont systemFontOfSize:14];
        
        button_all = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [button_all setTitle:@"圈子" forState:UIControlStateNormal];
        [button_all setTitleColor:white_color forState:UIControlStateNormal];
        button_all.layer.borderWidth = 1;
        button_all.layer.borderColor = white_color.CGColor;
        button_all.backgroundColor = Navi_Title_Color;
        [button_all addTarget:self action:@selector(touchButtonAll:) forControlEvents:UIControlEventTouchUpInside];
        button_all.titleLabel.font = [UIFont systemFontOfSize:14];
        
        button_hot.userInteractionEnabled = NO;
        button_all.userInteractionEnabled = YES;

        
        [_titleView addSubview:button_hot];
        [_titleView addSubview:button_all];
    }
    return _titleView;
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
