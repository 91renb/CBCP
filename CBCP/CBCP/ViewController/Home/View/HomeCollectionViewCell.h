//
//  HomeCollectionViewCell.h
//  CBCP
//
//  Created by LC on 2017/5/17.
//  Copyright © 2017年 LC. All rights reserved.
//

#import "CBCollectionViewCell.h"

@class HomeListModel;

@interface HomeCollectionViewCell : CBCollectionViewCell

@property (nonatomic ,strong) HomeListModel *model;

@end
