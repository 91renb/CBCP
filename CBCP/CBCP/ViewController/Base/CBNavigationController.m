//
//  CBNavigationController.m
//  CaiBao
//
//  Created by LC on 2017/4/8.
//  Copyright © 2017年 LC. All rights reserved.
//

#import "CBNavigationController.h"

@interface CBNavigationController ()

@end

@implementation CBNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotate {
    
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    
    return [self.viewControllers.lastObject supportedInterfaceOrientations];
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    
    return [self.viewControllers.lastObject preferredInterfaceOrientationForPresentation];
}

- (UIViewController *)childViewControllerForStatusBarStyle{
    
    return self.topViewController;
}


//FIXME:这样做防止主界面卡顿时，导致一个ViewController被push多次
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.childViewControllers.count > 0) {
        if ([[self.childViewControllers lastObject] isKindOfClass:[viewController class]]) {
            return;
        }
    }
    
    [super pushViewController:viewController animated:animated];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
