//
//  CBSVProgressHUD.h
//  CBCP
//
//  Created by LC on 2017/5/17.
//  Copyright © 2017年 LC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CBSVProgressHUD : NSObject

extern void ShowSuccessStatus(NSString *statues);
extern void ShowErrorStatus(NSString *statues);
extern void ShowMaskStatus(NSString *statues);
extern void ShowMessage(NSString *statues);
extern void ShowProgress(CGFloat progress);
extern void DismissHud(void);

@end
