//
//  LeadInfoViewController.m
//  leadperfection
//
//  Created by Sejal Pandya on 10/12/12.
//
//

#import "LeadInfoViewController.h"
#import "ServiceConsumer.h"
#import "Prospect.h"


@implementation LeadInfoViewController {
    NSMutableArray *prospects;
}
@synthesize prospectID;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.dimBackground = YES;
    
    [super viewWillAppear:animated];
	// Do any additional setup after loading the view.
    
    [[[ServiceConsumer alloc] init] getLeadInfoByProspectId:self.prospectID withUserInfo:[super getUserInfo] :^(id json) {
        
        [HUD hide:YES];
        
        if([json count]==0){

            
            UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Search"
                                                              message:@"No information available."
                                                             delegate:nil
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles:nil];
            [message show];
        }
        else {
            prospects  = json;
            [self.tableView reloadData];
        }
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [prospects count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cell";
    
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    Prospect *pros = [prospects objectAtIndex:indexPath.row];
    cell.textLabel.text = pros.description;
    cell.detailTextLabel.text = pros.statValue;
    
    return cell;
}



@end
