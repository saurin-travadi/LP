//
//  BaseUIViewController.m
//  leadperfection
//
//  Created by Saurin Travadi on 8/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BaseUIViewController.h"
#import "AppDelegate.h"
#import "SFHFKeychainUtils.h"
#import "LoginViewController.h"

@implementation BaseUIViewController

@synthesize baseUrl;

- (NSString *)filePath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"LocalSettings.plist"];
    return filePath;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization

    }
    return self;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadDefaults];
}

- (void)viewDidUnload {
    [super viewDidUnload];
    loadingOverlay = nil;
    errorOverlay = nil;
}

- (void)viewWillAppear:(BOOL)animated {
    errorOverlay.view.hidden = NO;
    loadingOverlay.view.hidden = NO;
    
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma -
#pragma mark - Activity Indicators

- (void)startActivityIndicator {
    [((AppDelegate *) [[UIApplication sharedApplication] delegate]).window addSubview:loadingOverlay.view];
    self.tabBarController.tabBar.userInteractionEnabled = NO;
}

- (void)stopActivityIndicator {
    [loadingOverlay.view removeFromSuperview];
    self.tabBarController.tabBar.userInteractionEnabled = YES;
}

#pragma -
#pragma mark - Error Overlay

- (void)setupDefaultError:(BOOL)delegate {
    [errorOverlay setText:@"Network Error" body:@"Unable to connect to server. Please check your network connection."];
    errorOverlay.currentTabBar = self.tabBarController.tabBar;
    
    if (delegate && [self respondsToSelector:@selector(ErrorOverlayDismissed)]) {
        [errorOverlay setDelegate:self];
    }
}

- (void)showError {
    [((AppDelegate *) [[UIApplication sharedApplication] delegate]).window addSubview:errorOverlay.view];
    self.tabBarController.tabBar.userInteractionEnabled = NO;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark -
#pragma mark MBProgressHUDDelegate methods

- (void)hudWasHidden:(MBProgressHUD *)hud {
    // Remove HUD from screen when the HUD was hidded
    [HUD removeFromSuperview];
	HUD = nil;
}

- (void)loadDefaults {
    
    NSString *errorDesc = nil;
    NSPropertyListFormat format;
    NSString *plistPath;
    NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                              NSUserDomainMask, YES) objectAtIndex:0];
    plistPath = [rootPath stringByAppendingPathComponent:@"LocalSettings.plist"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:plistPath]) {
        plistPath = [[NSBundle mainBundle] pathForResource:@"LocalSettings" ofType:@"plist"];
    }
    NSData *plistXML = [[NSFileManager defaultManager] contentsAtPath:plistPath];
    NSDictionary *temp = (NSDictionary *)[NSPropertyListSerialization
                                          propertyListFromData:plistXML
                                          mutabilityOption:NSPropertyListMutableContainersAndLeaves
                                          format:&format
                                          errorDescription:&errorDesc];
    if (!temp) {
        NSLog(@"Error reading plist: %@, format: %d", errorDesc, format);
    }
    baseUrl = [temp objectForKey:@"BaseUrl"];   
}

-(void)setUserInfo:(UserInfo*)userInfo {
    NSString *localSettingsPath = ((AppDelegate *) [[UIApplication sharedApplication] delegate]).localSettingsPath;
    
    // Save to keychain
    NSError *error = nil;
    [SFHFKeychainUtils storeUsername:userInfo.userName andPassword:userInfo.password forServiceName:@"leadperfection" updateExisting:TRUE error:&error];
    
    // Save UserName to local settings
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile: localSettingsPath];
    [data setObject:userInfo.userName forKey:@"UserName"];
    [data writeToFile: localSettingsPath atomically:YES];
}

-(UserInfo*)getUserInfo{
    
    NSString *localSettingsPath = ((AppDelegate *) [[UIApplication sharedApplication] delegate]).localSettingsPath;
    
    NSMutableDictionary *project = [[NSMutableDictionary alloc] initWithContentsOfFile: localSettingsPath];
    NSString *settingsUserName = [project objectForKey:@"UserName"];
    
    NSError *error = nil;
    NSString *savedPassword = [SFHFKeychainUtils getPasswordForUsername:settingsUserName andServiceName:@"leadperfection" error:&error]; 
    
    UserInfo* currentUserInfo = [[UserInfo alloc] initWithUserName:settingsUserName Password:savedPassword ClientID:@"" SiteURL:@""];
    currentUserInfo.userName = settingsUserName;
    currentUserInfo.password = savedPassword;
    
    return currentUserInfo;
}


@end
