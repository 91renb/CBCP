//
//  CircleHotCell.h
//  CBCP
//
//  Created by LC on 2017/5/20.
//  Copyright © 2017年 LC. All rights reserved.
//

#import "CBTableViewCell.h"

@class CircleHotModel;
@interface CircleHotCell : CBTableViewCell

@property (nonatomic ,strong) CircleHotModel *model;
@property (nonatomic ,strong) NSIndexPath *indexPath;
@property (nonatomic ,strong) RACSubject *nameClickSubject;
@property (nonatomic ,strong) RACSubject *likeClickSubject;
@property (nonatomic ,strong) RACSubject *commentClickSubject;
@end
