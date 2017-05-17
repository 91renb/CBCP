//
//  MainViewController.h
//  CBCP
//
//  Created by LC on 2017/5/16.
//  Copyright © 2017年 LC. All rights reserved.
//

#import "CBNavigationController.h"
#import "CBCustomTabbar.h"
#import "CBViewController.h"

typedef NS_ENUM(NSInteger, LBMainTabbarIndex) {
    kLBMainTabbarIndexHome = 0,
    kLBMainTabbarIndexNew,
    kLBMainTabbarIndexDiscovery,
    kLBMainTabbarIndexCircle
};

@interface MainViewController : CBNavigationController

@property (nonatomic) CBCustomTabbar *tabBar;
@property (nonatomic) CBViewController *currentViewController;
- (CBViewController *)viewControllerForTabbarIndex:(NSInteger)index;


@end
