//
//  LoadingOverlay.m
//  leadperfection
//
//  Created by Saurin Travadi on 8/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "LoadingOverlay.h"

@implementation LoadingOverlay

@synthesize backdrop, loadingLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    backdrop.layer.cornerRadius = 25;
    backdrop.backgroundColor = [UIColor darkGrayColor];
    loadingLabel.textColor = [UIColor whiteColor];
}

- (void)viewDidUnload
{
    backdrop = nil;
    loadingLabel = nil;
    [super viewDidUnload];
    
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
