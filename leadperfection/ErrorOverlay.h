//
//  ErrorOverlay.h
//  leadperfection
//
//  Created by Saurin Travadi on 8/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ErrorOverlayDelegate

@required
- (void)ErrorOverlayDismissed;

@end


@interface ErrorOverlay : UIViewController {
    IBOutlet UIView *backdrop;
    IBOutlet UILabel *errorTitle;
    IBOutlet UITextView *errorText;
}

@property(nonatomic, retain) UITabBar *currentTabBar;
@property(nonatomic, assign) NSObject <ErrorOverlayDelegate> *delegate;

@property(nonatomic, retain, readonly) IBOutlet UIView *backdrop;
@property(nonatomic, retain, readonly) IBOutlet UILabel *errorTitle;
@property(nonatomic, retain, readonly) IBOutlet UIButton *okButton;
@property(nonatomic, retain, readonly) IBOutlet UITextView *errorText;

- (void)setText:(NSString *)title body:(NSString *)error;

- (IBAction)okPressed:(id)sender;

@end
