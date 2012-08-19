//
//  BaseUIViewController.h
//  leadperfection
//
//  Created by Saurin Travadi on 8/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoadingOverlay.h"
#import "ErrorOverlay.h"
#import "MBProgressHUD.h"
#import "UserInfo.h"

@interface BaseUIViewController : UIViewController <ErrorOverlayDelegate,MBProgressHUDDelegate> {
    LoadingOverlay *loadingOverlay;
    ErrorOverlay *errorOverlay;
    MBProgressHUD *HUD;
}

@property (nonatomic,retain) NSString *baseUrl;

-(void)setUserInfo:(UserInfo*)userInfo;
-(UserInfo*)getUserInfo;

- (void)startActivityIndicator;
- (void)stopActivityIndicator;
- (void)setupDefaultError:(BOOL)delegate;
- (void)showError;
- (void)loadDefaults;

@end
