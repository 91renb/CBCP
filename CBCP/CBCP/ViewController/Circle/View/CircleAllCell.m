//
//  CircleAllCell.m
//  CBCP
//
//  Created by LC on 2017/5/22.
//  Copyright © 2017年 LC. All rights reserved.
//

#import "CircleAllCell.h"

@interface CircleAllCell ()

@property (nonatomic ,strong) UIImageView *iconImageView;

@property (nonatomic ,strong) UILabel *titleLabel;

@property (nonatomic ,strong) UILabel *peopleNumLabel;

@property (nonatomic ,strong) UILabel *postsNumLabel;

@end

@implementation CircleAllCell

- (void)cb_setupViews
{
    [self.contentView addSubview:self.iconImageView];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.peopleNumLabel];
    [self.contentView addSubview:self.postsNumLabel];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

- (void)updateConstraints {
    
    WS(weakSelf)
    CGFloat paddingEdge = 10;
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.left.equalTo(weakSelf.contentView).offset(10);
        make.height.width.offset(50);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakSelf.iconImageView);
        make.left.equalTo(weakSelf.iconImageView.mas_right).offset(paddingEdge);
        make.right.equalTo(weakSelf.contentView).offset(paddingEdge);
        make.height.offset(20);
    }];
    
    [self.peopleNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.titleLabel);
        make.top.equalTo(weakSelf.titleLabel.mas_bottom).offset(paddingEdge);
        make.height.offset(20);
    }];
    
    [self.postsNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.peopleNumLabel.mas_right).offset(paddingEdge);
        make.top.equalTo(weakSelf.peopleNumLabel);
        make.height.equalTo(weakSelf.peopleNumLabel);
    }];
    
    [super updateConstraints];
}





- (void)setModel:(CircleAllModel *)model
{
    _model = model;
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.boardIconUrl] placeholderImage:[UIImage imageNamed:@""]];
    self.titleLabel.text = model.boardName;
    self.peopleNumLabel.text = [NSString stringWithFormat:@"人数：%@",model.peopleNum];
    self.postsNumLabel.text = [NSString stringWithFormat:@"帖子：%@",model.postsNum];
}


- (UIImageView *)iconImageView
{
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] init];
        _iconImageView.layer.cornerRadius = 25;
        _iconImageView.clipsToBounds = YES;
        
    }
    return _iconImageView;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = CB_rgb_51;
        _titleLabel.font = H18;
    }
    return _titleLabel;
}

- (UILabel *)peopleNumLabel
{
    if (!_peopleNumLabel) {
        _peopleNumLabel = [[UILabel alloc] init];
        _peopleNumLabel.textColor = CB_rgb_81;
        _peopleNumLabel.font = H13;
    }
    return _peopleNumLabel;
}

- (UILabel *)postsNumLabel
{
    if (!_postsNumLabel) {
        _postsNumLabel = [[UILabel alloc] init];
        _postsNumLabel.textColor = CB_rgb_81;
        _postsNumLabel.font = H13;
    }
    return _postsNumLabel;
}



@end
