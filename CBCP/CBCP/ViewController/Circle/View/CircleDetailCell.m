//
//  CircleDetailCell.m
//  CBCP
//
//  Created by LC on 2017/7/13.
//  Copyright © 2017年 LC. All rights reserved.
//

#import "CircleDetailCell.h"
#import "CircleCommentModel.h"

@interface CircleDetailCell ()
{
    UIImageView *avatarImageView;
    UILabel *nameLabel;
    UILabel *textLabel;
    UILabel *timeLabel;
    UILabel *levelLabel;
}
@end

@implementation CircleDetailCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createView];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)createView
{
    //头像
    avatarImageView = [UIImageView new];
    avatarImageView.contentMode = UIViewContentModeScaleAspectFill;
    avatarImageView.clipsToBounds = YES;
    avatarImageView.userInteractionEnabled = YES;
    avatarImageView.layer.cornerRadius = 20;
    avatarImageView.clipsToBounds = YES;
    
    nameLabel = [UILabel new];
    nameLabel.textColor = Navi_Title_Color;
    nameLabel.font = [UIFont systemFontOfSize:15];
    
    timeLabel = [UILabel new];
    timeLabel.font = [UIFont systemFontOfSize:13];
    timeLabel.textColor = [UIColor lightGrayColor];
    
    textLabel = [UILabel new];
    textLabel.font = [UIFont systemFontOfSize:14];
    textLabel.numberOfLines = 0;
    
    levelLabel = [UILabel new];
    levelLabel.font = [UIFont systemFontOfSize:14];
    levelLabel.textAlignment = NSTextAlignmentRight;
    
    NSArray *array = @[avatarImageView,nameLabel,timeLabel,textLabel,levelLabel];
    [self.contentView sd_addSubviews:array];
    
    UIView *contentView = self.contentView;
    CGFloat margin = 10;
    
    avatarImageView.sd_layout
    .leftSpaceToView(contentView, margin)
    .topSpaceToView(contentView, margin)
    .widthIs(40)
    .heightIs(40);
    
    nameLabel.sd_layout
    .leftSpaceToView(avatarImageView, margin)
    .topEqualToView(avatarImageView)
    .heightIs(20);
    [nameLabel setSingleLineAutoResizeWithMaxWidth:1000];
    
    timeLabel.sd_layout
    .leftEqualToView(nameLabel)
    .topSpaceToView(nameLabel, margin*0.5)
    .heightIs(20);
    [timeLabel setSingleLineAutoResizeWithMaxWidth:1000];
    
    levelLabel.sd_layout
    .rightSpaceToView(contentView, margin * 2)
    .topEqualToView(nameLabel)
    .heightIs(20)
    .widthIs(60);
    
    textLabel.sd_layout
    .leftEqualToView(nameLabel)
    .topSpaceToView(timeLabel, margin)
    .rightSpaceToView(contentView, margin)
    .autoHeightRatio(0);
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
}

- (void)setModel:(CircleCommentModel *)model
{
    _model = model;
    
    [avatarImageView sd_setImageWithURL:[NSURL URLWithString:model.replyerAvatarUrl] placeholderImage:[UIImage imageNamed:@"avatar"]];
    nameLabel.text = model.replyerNickName;
    timeLabel.text = model.createTime;
    textLabel.text = model.text;
    levelLabel.text = [NSString stringWithFormat:@"%ld楼",self.indexPath.row + 2];
    [self setupAutoHeightWithBottomView:textLabel bottomMargin:5];
}

@end
