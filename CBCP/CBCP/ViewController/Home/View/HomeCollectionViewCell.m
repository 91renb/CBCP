//
//  HomeCollectionViewCell.m
//  CBCP
//
//  Created by LC on 2017/5/17.
//  Copyright © 2017年 LC. All rights reserved.
//

#import "HomeCollectionViewCell.h"
#import "HomeListModel.h"

@interface HomeCollectionViewCell ()

@property (nonatomic ,strong) UIImageView *itemImageView;
@property (nonatomic ,strong) UILabel *itemTitleLabel;
@property (nonatomic ,strong) UILabel *itemDescLabel;

@end

@implementation HomeCollectionViewCell


- (void)cb_setupViews
{
    [self addSubview:self.itemImageView];
    [self addSubview:self.itemTitleLabel];
    [self addSubview:self.itemDescLabel];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

- (void)updateConstraints
{
    WS(weakSelf);
    
    [self.itemImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(@10);
        make.width.height.equalTo(@40);
    }];
    
    [self.itemTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.itemImageView.mas_right).offset(10);
        make.top.right.equalTo(@10);
    }];
    
    [self.itemDescLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.itemTitleLabel.mas_left);
        make.right.equalTo(@10);
        make.top.equalTo(weakSelf.itemTitleLabel.mas_bottom).offset(10);
    }];
    
    
    [super updateConstraints];
}


- (void)setModel:(HomeListModel *)model
{
    _model = model;
    
    [self.itemImageView sd_setImageWithURL:[NSURL URLWithString:model.badgeIcon] placeholderImage:[UIImage imageNamed:@""]];
    self.itemTitleLabel.text = model.gameCn;
    self.itemDescLabel.text = model.gameDesc;
}


- (UIImageView *)itemImageView
{
    if (!_itemImageView) {
        _itemImageView = [[UIImageView alloc] init];
        _itemImageView.layer.cornerRadius = 20;
        _itemImageView.clipsToBounds = YES;
    }
    return _itemImageView;
}

- (UILabel *)itemTitleLabel
{
    if (!_itemTitleLabel) {
        _itemTitleLabel = [[UILabel alloc] init];
        _itemTitleLabel.font = H16;
    }
    return _itemTitleLabel;
}

- (UILabel *)itemDescLabel
{
    if (!_itemDescLabel) {
        _itemDescLabel = [[UILabel alloc] init];
        _itemDescLabel.font = H14;
        _itemDescLabel.textColor = CB_rgb(81, 81, 81);
    }
    return _itemDescLabel;
}

@end
