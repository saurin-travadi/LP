//
//  CustomerListViewController.h
//  leadperfection
//
//  Created by Saurin Travadi on 8/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseUIViewController.h"

@interface CustomerListViewController : BaseUIViewController

@property (nonatomic, strong) NSMutableArray *customers;
@property (strong, nonatomic) IBOutlet UITableView *tableViewCustomer;

@end
