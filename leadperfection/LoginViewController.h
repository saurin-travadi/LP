//
//  LoginViewController.h
//  leadperfection
//
//  Created by Saurin Travadi on 8/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserInfo.h"
#import "SFHFKeychainUtils.h"
#import "BaseUIViewController.h"

@protocol LoginDelegate

@required
- (void)successfullyLoggedIn;
@end

@interface LoginViewController : BaseUIViewController <ErrorOverlayDelegate> {
    
    
}

@property (nonatomic, assign) NSObject <LoginDelegate> *delegate;
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (strong, nonatomic) IBOutlet UIButton *logOnButton;

- (IBAction)login:(id)sender;

@end
