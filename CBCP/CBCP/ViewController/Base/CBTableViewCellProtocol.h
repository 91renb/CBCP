//
//  CBTableViewCellProtocol.h
//  CBCP
//
//  Created by LC on 2017/5/16.
//  Copyright © 2017年 LC. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CBTableVIewCellProtocol <NSObject>
@optional

- (void)cb_setupViews;
- (void)cb_bindViewModel;

@end
