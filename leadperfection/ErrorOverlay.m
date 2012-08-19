//
//  ErrorOverlay.m
//  leadperfection
//
//  Created by Saurin Travadi on 8/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "ErrorOverlay.h"

@implementation ErrorOverlay

@synthesize currentTabBar, delegate, backdrop, errorText, errorTitle, okButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    backdrop.layer.cornerRadius = 25;
    backdrop.backgroundColor = [UIColor grayColor];
    errorTitle.textColor = [UIColor whiteColor];
    errorText.textColor = [UIColor whiteColor];
}

- (void)viewDidUnload
{
    backdrop = nil;
    errorText = nil;
    errorTitle = nil;
    currentTabBar = nil;
    okButton = nil;
    [super viewDidUnload];
}

- (void) viewWillAppear:(BOOL)animated
{
    if(errorText.contentSize.height > 121)
    {
        CGFloat diff = errorText.contentSize.height - 121;
        
        CGRect rect = errorText.frame;
        rect.size.height += diff;
        errorText.frame = rect;
        
        rect = okButton.frame;
        rect.origin.y += diff;
        okButton.frame = rect;
        
        rect = backdrop.frame;
        rect.size.height += diff;
        backdrop.frame = rect;
    }
    
    [super viewWillAppear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void) setText:(NSString*)title body:(NSString*)error
{
    errorTitle.text = title;
    errorText.text = error;
}

- (IBAction) okPressed:(id)sender
{
    [self.view removeFromSuperview];
    currentTabBar.userInteractionEnabled = YES;
    
    if([self.delegate respondsToSelector:@selector(ErrorOverlayDismissed)])
    {
        [self.delegate ErrorOverlayDismissed];
    }
}

@end
