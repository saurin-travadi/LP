//
//  SearchViewController.h
//  leadperfection
//
//  Created by Saurin Travadi on 8/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseUIViewController.h"

@interface SearchViewController : BaseUIViewController

@property (strong, nonatomic) IBOutlet UIButton *btnGo;
@property (strong, nonatomic) IBOutlet UITextField *phone;
@property (strong, nonatomic) IBOutlet UITextField *lastName;
@property (strong, nonatomic) IBOutlet UITextField *prospect;
@property (strong, nonatomic) IBOutlet UITextField *job;

- (IBAction)search:(id)sender;

@end
