//
//  CircleHotCell.h
//  CBCP
//
//  Created by LC on 2017/5/20.
//  Copyright © 2017年 LC. All rights reserved.
//

#import "CBTableViewCell.h"

@protocol CircleDetailDelegate <NSObject>

//点赞
- (void)didClickLikeButtonInCell:(UITableViewCell *)cell;
//评论
- (void)didClickCommentButtonInCell:(UITableViewCell *)cell;
//用户
- (void)didClickUserNameInCell:(UITableViewCell *)cell;


@end

@class CircleHotModel;
@interface CircleHotCell : CBTableViewCell

@property (nonatomic ,strong) CircleHotModel *model;

@property (nonatomic ,weak) id<CircleDetailDelegate> delegate;

@end
