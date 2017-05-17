//
//  HomeHeaderModel.m
//  CBCP
//
//  Created by LC on 2017/5/17.
//  Copyright © 2017年 LC. All rights reserved.
//

#import "HomeHeaderModel.h"

@implementation HomeHeaderModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"newPicture"]) {
        self.nPicture = value;
    }
}

@end
