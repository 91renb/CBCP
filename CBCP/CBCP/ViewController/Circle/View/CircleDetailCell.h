//
//  CircleDetailCell.h
//  CBCP
//
//  Created by LC on 2017/7/13.
//  Copyright © 2017年 LC. All rights reserved.
//

#import "CBTableViewCell.h"

@class CircleCommentModel;
@interface CircleDetailCell : CBTableViewCell

@property (nonatomic ,strong) CircleCommentModel *model;
@property (nonatomic ,strong) NSIndexPath *indexPath;

@end
