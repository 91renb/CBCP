//
//  CBCustomNavigationView.m
//  CBCP
//
//  Created by LC on 2017/5/16.
//  Copyright © 2017年 LC. All rights reserved.
//

#import "CBCustomNavigationView.h"

@implementation CBCustomNavigationView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self  addUIView];
    }
    return self;
}


- (void)addUIView
{
    self.backImageView = [[UIImageView  alloc] initWithFrame:self.bounds];
    self.backImageView.image = ImageNamed(@"navi_background");
    [self  addSubview:self.backImageView];
    [self  addSubview:self.backBtn];
    [self  addSubview:self.backMoreBtn];
    [self  addSubview:self.titleLable];
    [self  addSubview:self.rightImgBtn
     
     
     ];
    self.backgroundColor = [UIColor  whiteColor];
}

- (UIButton *)backBtn
{
    if (_backBtn == nil) {
        _backBtn =  [[UIButton  alloc] initWithFrame:CGRectMake(20, 32,12,19)];
        [_backBtn  setImage:ImageNamed(@"Arrow_blue") forState:UIControlStateNormal];
    }
    return _backBtn;
}

- (UIButton *)backMoreBtn
{
    if (_backMoreBtn == nil) {
        _backMoreBtn = [[UIButton  alloc] initWithFrame:CGRectMake(32, 32, 40, 20)];
    }
    return _backMoreBtn;
}

- (UILabel *)_TitleLable
{
    if (_titleLable == nil) {
        _titleLable = [[UILabel  alloc] initWithFrame:CGRectMake(60, 33, SCREEN_WIDTH - 120, 19)];
        _titleLable.textColor = [UIColor whiteColor];
        _titleLable.font = [UIFont  systemFontOfSize:18];
        _titleLable.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLable;
}

- (UIButton *)rightTextBtn
{
    if (_rightTextBtn == nil) {
        _rightTextBtn = [[UIButton  alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-70, 20, 70, 44)];
        _rightTextBtn.titleLabel.textAlignment = NSTextAlignmentRight;
        _rightTextBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _rightTextBtn;
}

- (UIButton *)rightImgBtn
{
    if (_rightImgBtn == nil) {
        _rightImgBtn = [[UIButton  alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-54, 20, 44, 44)];
    }
    return _rightImgBtn;
}



@end
