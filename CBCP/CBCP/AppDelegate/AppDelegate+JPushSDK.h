//
//  AppDelegate+JPushSDK.h
//  CBCP
//
//  Created by LC on 2017/5/13.
//  Copyright © 2017年 LC. All rights reserved.
//

#import "AppDelegate.h"
#import "JPUSHService.h"
#import <UserNotifications/UserNotifications.h>

@interface AppDelegate (JPushSDK)<JPUSHRegisterDelegate,UNUserNotificationCenterDelegate>
-(void)JPushApplication:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;
@end


