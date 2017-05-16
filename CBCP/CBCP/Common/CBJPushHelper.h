//
//  CBJPushHelper.h
//  CBCP
//
//  Created by LC on 2017/5/13.
//  Copyright © 2017年 LC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CBJPushHelper : NSObject


/**
 在应用启动的时候调用

 @param launchingOption <#launchingOption description#>
 @param appKey <#appKey description#>
 @param channel <#channel description#>
 @param isProduction <#isProduction description#>
 @param advertisingId <#advertisingId description#>
 */
+ (void)setupWithOption:(NSDictionary *)launchingOption
                 appKey:(NSString *)appKey
                channel:(NSString *)channel
       apsForProduction:(BOOL)isProduction
  advertisingIdentifier:(NSString *)advertisingId;


/**
 注册token--在appdelegate注册设备处调用

 @param deviceToken <#deviceToken description#>
 */
+ (void)registerDeviceToken:(NSData *)deviceToken;

// ios7以后，才有completion，否则传nil
+ (void)handleRemoteNotification:(NSDictionary *)userInfo completion:(void (^)(UIBackgroundFetchResult))completion;


/**
 设置标签和别名

 @param set <#set description#>
 @param alias <#alias description#>
 */
+ (void)JPushSetTags:(NSSet *)set Alias:(NSString *)alias;

@end
