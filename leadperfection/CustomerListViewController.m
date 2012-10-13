//
//  CustomerListViewController.m
//  leadperfection
//
//  Created by Saurin Travadi on 8/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CustomerListViewController.h"
#import "ServiceConsumer.h"
#import "Customer.h"
#import "LeadInfoViewController.h"

@implementation CustomerListViewController{
    NSMutableArray *customers;    
}

@synthesize customers;
@synthesize tableViewCustomer;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self.tableViewCustomer reloadData];
}

- (void)viewDidUnload
{
    [self setTableViewCustomer:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [customers count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"customerCell";
    
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...    
    Customer *cust = [customers objectAtIndex:[indexPath row]];
    UILabel *name = (UILabel*)[cell viewWithTag:1];
    name.text = cust.name;

    UILabel *address = (UILabel*)[cell viewWithTag:2];
    address.text = cust.address;

    UILabel *city = (UILabel*)[cell viewWithTag:3];
    city.text = cust.city;

    UILabel *phone = (UILabel*)[cell viewWithTag:4];
    phone.text = cust.phone;

    UILabel *prospect = (UILabel*)[cell viewWithTag:5];
    prospect.text = cust.prospect;
    
    return cell;
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ( [segue.identifier isEqualToString:@"infoSegue"]) {
        
        [HUD hide:YES];
        Customer *cust = [customers objectAtIndex:self.tableViewCustomer.indexPathForSelectedRow.row];
        [[segue destinationViewController] setProspectID:cust.prospect];
    }
}


@end
