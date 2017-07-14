//
//  CircleCommentModel.h
//  CBCP
//
//  Created by LC on 2017/7/14.
//  Copyright © 2017年 LC. All rights reserved.
//

#import "CBModel.h"

@interface CircleCommentModel : CBModel

@property (nonatomic ,copy) NSString *replyerNickName;
@property (nonatomic ,copy) NSString *replyerAvatarUrl;
@property (nonatomic ,copy) NSString *replyerUserId;
@property (nonatomic ,copy) NSString *createTime;
@property (nonatomic ,copy) NSString *text;
@property (nonatomic ,copy) NSString *commentId;

@end
