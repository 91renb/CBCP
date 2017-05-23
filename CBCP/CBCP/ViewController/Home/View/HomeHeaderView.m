//
//  HomeHeaderView.m
//  CBCP
//
//  Created by LC on 2017/5/19.
//  Copyright © 2017年 LC. All rights reserved.
//

#import "HomeHeaderView.h"
#import "HomeHeaderViewModel.h"
#import "SDCycleScrollView.h"
#import "HomeHeaderModel.h"

#define CycleHeight SCREEN_WIDTH/2

@interface HomeHeaderView ()<SDCycleScrollViewDelegate>
{
    UILabel *titleLabel;
}
@property (strong, nonatomic) HomeHeaderViewModel *viewModel;

@property (nonatomic ,strong) SDCycleScrollView *cycleScrollView;

@property (nonatomic ,strong) UIView *linView;
@property (nonatomic ,strong) UIButton *likeButton;

@end

@implementation HomeHeaderView

- (instancetype)initWithViewModel:(id<CBViewModelProtocol>)viewModel
{
    self.viewModel = (HomeHeaderViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}

- (void)updateConstraints
{
    WS(weakSelf);
    [self.cycleScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(@0);
        make.height.offset(CycleHeight);
    }];
    
    [self.linView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.top.equalTo(weakSelf.cycleScrollView).offset(0);
        make.height.offset(20);
    }];
    
    [self.likeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.linView).offset(0);
        make.left.right.equalTo(0);
        make.bottom.equalTo(@10);
    }];
    
    
    [super updateConstraints];
}


- (void)cb_setupViews
{
    [self addSubview:self.cycleScrollView];
    [self addSubview:self.linView];
    [self addSubview:self.likeButton];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraints];
}

- (void)cb_bindViewModel
{
    
    
}


- (SDCycleScrollView *)cycleScrollView
{
    if (!_cycleScrollView) {
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, CycleHeight) imageURLStringsGroup:nil];
        _cycleScrollView.infiniteLoop = YES;
        _cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
        _cycleScrollView.delegate = self;
        _cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
        _cycleScrollView.autoScrollTimeInterval = 2.5; // 轮播时间间隔，默认1.0秒，可自定义
        _cycleScrollView.pageDotColor = CB_rgb(255, 255, 255);
        _cycleScrollView.currentPageDotColor = CB_rgb(15,136,235);
        _cycleScrollView.titleLabelHeight = 24;
        _cycleScrollView.titleLabelTextFont = [UIFont systemFontOfSize:15];
        _cycleScrollView.titleLabelBackgroundColor = CB_rgb(0, 0, 0);
        _cycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
        
        NSMutableArray *images = [NSMutableArray array];
        
        for (HomeHeaderModel *model in self.viewModel.dataArray) {
            [images addObject:model.picture];
        }
        _cycleScrollView.imageURLStringsGroup = images;
        
    }
    return _cycleScrollView;
}


- (UIView *)linView
{
    if (!_linView) {
        _linView = [[UIView alloc] init];
        _linView.backgroundColor = white_color;
        
        UIView *redView = [[UIView alloc] init];
        [redView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@10);
            make.top.bottom.equalTo(@0);
            make.width.offset(10);
        }];
        
        titleLabel = [[UILabel alloc] init];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(redView).offset(10);
            make.top.bottom.equalTo(@0);
            make.right.equalTo(@(SCREEN_WIDTH - 30));
        }];
        titleLabel.text = self.viewModel.likeModel.title;

        
    }
    return _linView;
}

- (UIButton *)likeButton
{
    if (!_likeButton) {
        _likeButton = [[UIButton alloc] init];
        _likeButton.backgroundColor = white_color;
        [_likeButton addTarget:self action:@selector(touchLikeButton:) forControlEvents:UIControlEventTouchUpInside];
        [_likeButton setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.viewModel.likeModel.imageUrl]]] forState:UIControlStateNormal];

    }
    return _likeButton;
}

- (void)touchLikeButton:(UIButton *)button
{
    
}

@end
