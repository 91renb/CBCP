//
//  CBViewController.h
//  CaiBao
//
//  Created by LC on 2017/4/8.
//  Copyright © 2017年 LC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CBViewControllerProtocol.h"
#import "CBCustomNavigationView.h"

@interface CBViewController : UIViewController<CBViewControllerProtocol>


/**
 **自定义导航栏
 */
@property (nonatomic, strong) CBCustomNavigationView *navigationV;

/**
 **导航栏
 */
@property(nonatomic,copy) NSString *Title;


/**
 * 功能：设置修改StatusBar
 * 参数：（1）StatusBar样式：statusBarStyle
 *      （2）是否隐藏StatusBar：statusBarHidden
 *      （3）是否动画过渡：animated
 */

-(void)changeStatusBarStyle:(UIStatusBarStyle)statusBarStyle
            statusBarHidden:(BOOL)statusBarHidden
    changeStatusBarAnimated:(BOOL)animated;

/**
 * 功能：隐藏显示导航栏
 * 参数：（1）是否隐藏导航栏：isHide
 *      （2）是否有动画过渡：animated
 */
-(void)hideNavigationBar:(BOOL)isHide
                animated:(BOOL)animated;

/**
 * 功能： 布局导航栏界面
 * 参数：（1）导航栏背景：backGroundImage
 *      （2）导航栏标题颜色：titleColor
 *      （3）导航栏标题字体：titleFont
 *      （4）导航栏左侧按钮：leftItem
 *      （5）导航栏右侧按钮：rightItem
 */
-(void)layoutNavigationBar:(UIImage*)backGroundImage
                titleColor:(UIColor*)titleColor
                 titleFont:(UIFont*)titleFont
         leftBarButtonItem:(UIBarButtonItem*)leftItem
        rightBarButtonItem:(UIBarButtonItem*)rightItem;

/**
 ***
 ***返回按钮
 */
- (void)goBackViewController;

/**
 ***
 ***右边按钮点击
 */
- (void)RightBtnEvent;

/**
 ** 导航栏右边是文字
 ** RightText：文字
 ** textFloat:文字大小
 ** color:文字颜色
 */

- (void)navigationRightText:(NSString *)rightText;

/**
 ***
 ***导航栏右边是图片
 */

- (void)navigationImgView:(NSString *)imageName;

@end
