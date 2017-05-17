//
//  AppDelegate.m
//  CBCP
//
//  Created by LC on 2017/5/13.
//  Copyright © 2017年 LC. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegate+JPushSDK.h"
#import "CBJPushHelper.h"
#import "LaunchViewController.h"
#import "ViewController.h"
#import "MainViewController.h"
#import "LoginViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    //注册极光推送
    [self JPushApplication:application didFinishLaunchingWithOptions:launchOptions];
    [CBJPushHelper JPushSetTags:[NSSet set] Alias:@"caibao"];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(changeRootViewController:)
                                                 name:K_Notification_Login
                                               object:nil];
    
    LaunchViewController *viewController = [LaunchViewController new];
    viewController.callBack = ^(BOOL isSuccess, NSString *urlStr) {
        if (isSuccess) {
            ViewController *view = [[ViewController alloc] init];
            view.urlStr = urlStr;
            self.window.rootViewController = view;
        }else{
            [self changeRootViewController:nil];
        }
    };
    
    self.window.rootViewController = viewController;
    
    return YES;
}

- (void)changeRootViewController:(NSNotification *)sender
{
//    if (sender.userInfo) {
//        
        self.window.rootViewController = [[MainViewController alloc] init];
//
//    }else{
//        self.window.rootViewController = [LoginViewController new];
//    }
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
