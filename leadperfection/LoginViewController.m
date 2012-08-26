//
//  LoginViewController.m
//  leadperfection
//
//  Created by Saurin Travadi on 8/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LoginViewController.h"
#import "NextUITextField.h"
#import "AppDelegate.h"
#import "ServiceConsumer.h"

@implementation LoginViewController

@synthesize logOnButton;
@synthesize userName, password, delegate;
NSString *localSettingsPath;

- (id) init {
    
    self = [super init];
    if (self) {
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
 
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

    password.secureTextEntry = YES;

    UserInfo* user = [super getUserInfo];
    userName.text = user.userName;
    if (user.password != NULL){
        password.text = user.password;

        [self performSelector:@selector(performLogin) withObject:nil afterDelay:0.1];
    }
    
    logOnButton.layer.cornerRadius = 8.0;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidUnload
{
    [self setUserName:nil];
    [self setPassword:nil];
    [self setLogOnButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event 
{
    [password resignFirstResponder];
    [userName resignFirstResponder];
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ( [segue.identifier isEqualToString:@"homeSegue"]) {
        //default route
    }
}

-(void) performLogin{
    [self login:self];
}

- (IBAction)login:(id)sender {

    HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.dimBackground = YES;

    [password resignFirstResponder];
    [userName resignFirstResponder];     
    
    UserInfo *info = [[UserInfo alloc] initWithUserName:userName.text Password:password.text ClientID:@"" SiteURL:@"" ];
    [[[ServiceConsumer alloc] init] performLogin:info :^(bool* success) {

        if(*success){
            
            [super setUserInfo:info];
            [self performSegueWithIdentifier:@"homeSegue" sender:self];
        }
        else {
            [HUD hide:YES];
            
            UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Logon Failed"
                                                              message:@"The system was not able to log you on. Please check your User ID and Password and try again."
                                                             delegate:nil
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles:nil];
            [message show];
        }
    }];
}        

- (void)missingBaseUrl
{
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Logon Failed"
                                                      message:@"The Base URL has not been set. Please assign a value in your iPhone Settings."
                                                     delegate:nil
                                            cancelButtonTitle:@"OK"
                                            otherButtonTitles:nil];
    [message show];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField 
{
    BOOL didResign = [textField resignFirstResponder];
    if (!didResign) return NO;
    
    if ([textField isKindOfClass:[NextUITextField class]]) {
        if (((NextUITextField *) textField).nextField != nil)
            [((NextUITextField *) textField).nextField becomeFirstResponder];
        else {
            [self login:nil];
        }
    }
    
    return YES;
 
}


@end
