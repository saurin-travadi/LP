//
//  BaseUIViewController.h
//  leadperfection
//
//  Created by Saurin Travadi on 8/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>  
#import "MBProgressHUD.h"
#import "UserInfo.h"
#import "JTRevealSidebarV2Delegate.h"
#import "SidebarViewController.h"

@class SidebarViewController;

@interface BaseUIViewController : UIViewController <MBProgressHUDDelegate,UITableViewDataSource, UITableViewDelegate, JTRevealSidebarV2Delegate, SidebarViewControllerDelegate> {
    MBProgressHUD *HUD;
}

@property (nonatomic,retain) NSString *baseUrl;

-(void)setUserInfo:(UserInfo*)userInfo;
-(UserInfo*)getUserInfo;
- (void)loadDefaults;

@property (nonatomic, strong) SidebarViewController *leftSidebarViewController;

@end
