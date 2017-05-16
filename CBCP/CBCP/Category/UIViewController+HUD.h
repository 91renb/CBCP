/************************************************************
  *  * EaseMob CONFIDENTIAL 
  * __________________ 
  * Copyright (C) 2013-2014 EaseMob Technologies. All rights reserved. 
  *  
  * NOTICE: All information contained herein is, and remains 
  * the property of EaseMob Technologies.
  * Dissemination of this information or reproduction of this material 
  * is strictly forbidden unless prior written permission is obtained
  * from EaseMob Technologies.
  */

#import <UIKit/UIKit.h>

@interface UIViewController (HUD)


/**
 有选择菊花提醒

 @param view <#view description#>
 @param hint <#hint description#>
 */
- (void)showHudInView:(UIView *)view hint:(NSString *)hint;


/**
 隐藏有菊花提醒
 */
- (void)hideHud;


/**
 纯文本提醒

 @param hint <#hint description#>
 */
- (void)showHint:(NSString *)hint;


/**
 从默认(showHint:)显示的位置再往上(下)yOffset

 @param hint <#hint description#>
 @param yOffset <#yOffset description#>
 */
- (void)showHint:(NSString *)hint yOffset:(float)yOffset;

@end
