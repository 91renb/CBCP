
//
//  CircleHotCell.m
//  CBCP
//
//  Created by LC on 2017/5/20.
//  Copyright © 2017年 LC. All rights reserved.
//

#import "CircleHotCell.h"
#import "CircleHotPhotoView.h"
#import "CircleHotView.h"
#import "CircleHotModel.h"

@interface CircleHotCell ()
{
    UIImageView *avatarImageView;
    UIButton *nameButton;
    UILabel *textLabel;
    UILabel *timeLabel;
    UIButton *likeButton;
    UILabel *likeNumLabel;
    UIButton *commentButton;
    UILabel *commentNumLabel;
    CircleHotPhotoView *phoneView;
}

@end

@implementation CircleHotCell

- (void)cb_setupViews
{
    //头像
    avatarImageView = [UIImageView new];
    avatarImageView.contentMode = UIViewContentModeScaleAspectFill;
    avatarImageView.clipsToBounds = YES;
    avatarImageView.userInteractionEnabled = YES;
    avatarImageView.layer.cornerRadius = 20;
    avatarImageView.clipsToBounds = YES;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] init];
    [[tapGesture rac_gestureSignal] subscribeNext:^(id x) {
        [self.nameClickSubject sendNext:self.indexPath];
    }];

    [avatarImageView addGestureRecognizer:tapGesture];
    
    //昵称
    nameButton = [UIButton new];
    [nameButton setTitleColor:Navi_Title_Color forState:UIControlStateNormal];
    [[nameButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [self.nameClickSubject sendNext:self.indexPath];

    }];
    
    nameButton.titleLabel.font = [UIFont systemFontOfSize:15];
    
    //发表内容
    textLabel = [UILabel new];
    textLabel.font = [UIFont systemFontOfSize:14];
    textLabel.numberOfLines = 0;
    
    //时间
    timeLabel = [UILabel new];
    timeLabel.font = [UIFont systemFontOfSize:12];
    timeLabel.textColor = [UIColor lightGrayColor];
    
    //点赞按钮
    likeButton = [UIButton new];
    [likeButton setImage:[UIImage imageNamed:@"like"] forState:UIControlStateNormal];
    [likeButton setImage:[UIImage imageNamed:@"like_select"] forState:UIControlStateSelected];
    [[likeButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [self.likeClickSubject sendNext:self.indexPath];
        
    }];
    
    //点赞人数
    likeNumLabel = [UILabel new];
    likeNumLabel.font = [UIFont systemFontOfSize:12];
    likeNumLabel.textColor = [UIColor blackColor];
    
    //评论按钮
    commentButton = [UIButton new];
    [commentButton setImage:[UIImage imageNamed:@"comment"] forState:UIControlStateNormal];
    [[commentButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [self.commentClickSubject sendNext:self.indexPath];
        
    }];
    commentNumLabel = [UILabel new];
    commentNumLabel.text = @"评论";
    commentNumLabel.font = [UIFont systemFontOfSize:12];
    commentNumLabel.textColor = [UIColor blackColor];
    commentNumLabel.userInteractionEnabled = YES;
    
    phoneView = [CircleHotPhotoView new];
    
    NSArray *array = @[avatarImageView,nameButton,textLabel,timeLabel,likeButton,likeNumLabel,commentButton,commentNumLabel,phoneView];
    [self.contentView sd_addSubviews:array];
    
    UIView *contentView = self.contentView;
    CGFloat margin = 10;
    avatarImageView.sd_layout
    .leftSpaceToView(contentView, margin*2)
    .topSpaceToView(contentView, margin*2)
    .widthIs(40)
    .heightIs(40);
    
    nameButton.sd_layout
    .leftSpaceToView(avatarImageView, margin)
    .topEqualToView(avatarImageView)
    .heightIs(20);
    [nameButton setSd_maxWidth:@300];
    
    
    textLabel.sd_layout
    .leftEqualToView(nameButton)
    .topSpaceToView(nameButton, margin)
    .rightSpaceToView(contentView, margin)
    .autoHeightRatio(0);
    
    phoneView.sd_layout
    .leftEqualToView(nameButton);
    
    timeLabel.sd_layout
    .leftEqualToView(nameButton)
    .topSpaceToView(phoneView, margin)
    .heightIs(20);
    [timeLabel setSingleLineAutoResizeWithMaxWidth:1000];
    
    commentNumLabel.sd_layout
    .rightSpaceToView(contentView, margin)
    .topEqualToView(timeLabel)
    .heightIs(20);
    [commentNumLabel setSingleLineAutoResizeWithMaxWidth:1000];
    
    commentButton.sd_layout
    .rightSpaceToView(commentNumLabel, margin)
    .topEqualToView(timeLabel)
    .heightIs(20)
    .widthIs(20);
    
    likeNumLabel.sd_layout
    .rightSpaceToView(commentButton, margin)
    .topEqualToView(timeLabel)
    .heightIs(20);
    [likeNumLabel setSingleLineAutoResizeWithMaxWidth:1000];
    
    likeButton.sd_layout
    .rightSpaceToView(likeNumLabel, margin)
    .topEqualToView(timeLabel)
    .heightIs(20)
    .widthIs(20);
}

- (void)setModel:(CircleHotModel *)model
{
    if (!model) {
        return;
    }
    _model = model;
    
    [avatarImageView sd_setImageWithURL:[NSURL URLWithString:model.avatarUrl] placeholderImage:[UIImage imageNamed:@"avatar"]];
    [nameButton setTitle:model.nickName forState:UIControlStateNormal];
    [nameButton sizeToFit];
    
    textLabel.text = model.text;
    
    if ([model.like intValue]) {
        likeButton.selected = YES;
    }else{
        likeButton.selected = NO;
    }
    
    likeNumLabel.text = model.likeCount;
    commentNumLabel.text = model.commentCount;
    timeLabel.text = model.createTime;
    
    phoneView.photoArray = model.imageList;
    CGFloat photoTopMargin = 0;
    if (model.imageList.count) {
        photoTopMargin = 10;
    }
    
    phoneView.sd_layout.topSpaceToView(textLabel, photoTopMargin);
    
    [self setupAutoHeightWithBottomView:timeLabel bottomMargin:15];
    
}

- (RACSubject *)nameClickSubject
{
    if (!_nameClickSubject) {
        _nameClickSubject = [RACSubject subject];
    }
    return _nameClickSubject;
}

- (RACSubject *)likeClickSubject
{
    if (!_likeClickSubject) {
        _likeClickSubject = [RACSubject subject];
    }
    return _likeClickSubject;
}

- (RACSubject *)commentClickSubject
{
    if (!_commentClickSubject) {
        _commentClickSubject = [RACSubject subject];
    }
    return _commentClickSubject;
}


@end
