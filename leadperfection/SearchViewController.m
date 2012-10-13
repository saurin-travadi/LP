//
//  SearchViewController.m
//  leadperfection
//
//  Created by Saurin Travadi on 8/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

  
#import "SearchViewController.h"
#import "CustomerListViewController.h"
#import "ServiceConsumer.h"

@implementation SearchViewController{
    NSMutableArray *_customers;
}
@synthesize phone, lastName, prospect, job, btnGo;

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
    
     self.btnGo.layer.cornerRadius = 8.0;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ( [segue.identifier isEqualToString:@"searchSegue"]) {

        [HUD hide:YES];
        [[segue destinationViewController] setCustomers:_customers];
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event 
{
    [phone resignFirstResponder];
    [lastName resignFirstResponder];
    [job resignFirstResponder];
    [prospect resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField 
{
    BOOL didResign = [textField resignFirstResponder];
    if (!didResign) return NO;
    
    [self search:textField];
    
    return YES;
}


- (IBAction)search:(id)sender{
    //perform additional logic
    
    if(![lastName.text isEqualToString:@""])
    {
        HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        HUD.dimBackground = YES;
        
        [[[ServiceConsumer alloc] init] getCustomersByLastName:lastName.text withUserInfo:[super getUserInfo] :^(id json) {
            
            if([json count]==0){
                [HUD hide:YES];
                
                UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Search"
                                                                  message:@"The system was not able to find any customers."
                                                                 delegate:nil
                                                        cancelButtonTitle:@"OK"
                                                        otherButtonTitles:nil];
                [message show];
            }
            else {
                
                _customers = json;
                [self performSegueWithIdentifier:@"searchSegue" sender:self];
            }
        }];
    }
}

@end
