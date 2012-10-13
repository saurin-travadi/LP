//
//  LeadInfoViewController.h
//  leadperfection
//
//  Created by Sejal Pandya on 10/12/12.
//
//

#import <UIKit/UIKit.h>
#import "BaseUIViewController.h"

@interface LeadInfoViewController : BaseUIViewController

@property(nonatomic, retain) NSString *prospectID;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@end
