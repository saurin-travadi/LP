//
//  ServiceConsumer.m
//  leadperfection
//
//  Created by Saurin Travadi on 8/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ServiceConsumer.h"
#import "Customer.h"
#import "JSON.h"
#import "Utility.h"

@implementation ServiceConsumer {
    NSString *baseURL;
}

-(id)init {
    self = [super init];
    if (self) {
        
        baseURL = [Utility retrieveFromUserDefaults:@"baseurl_preference"];
        if([baseURL isEqualToString:@""]) {
            [self missingBaseUrl];
            return nil;
        }
        
        return self;
    }
    return nil;
}

-(void)getEmployees:(UserInfo *)userInfo :(void (^)(bool*))Success {
    
    _OnLoginSuccess = [Success copy];
    
    NSString *soapMsg = @"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><GetEmployees xmlns=\"http://webservice.leadperfection.com/\" /></soap:Body></soap:Envelope>";
    
    NSURL *url = [NSURL URLWithString: baseURL];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url];
    
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMsg length]];
    [req addValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [req addValue:@"http://webservice.leadperfection.com/GetEmployees" forHTTPHeaderField:@"SOAPAction"];
    [req addValue:msgLength forHTTPHeaderField:@"Content-Length"];
    [req setHTTPMethod:@"POST"];
    [req setHTTPBody: [soapMsg dataUsingEncoding:NSUTF8StringEncoding]];
    
    [self getDataForElement:@"GetEmployeesResult" Request:req :^(id json) {
        NSLog(@"%@",[json description]);
        
        bool success = true;
        _OnLoginSuccess(&success);
    } :^(NSError *error) {
        
        bool success = false;
        _OnLoginSuccess(&success);
    }];    
}


-(void)performLogin:(UserInfo *)userInfo :(void (^)(bool*))Success {
    
    _OnLoginSuccess = [Success copy];
    
    NSString *soapMsg = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?> <soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"> <soap:Body> <ValidateLogin xmlns=\"http://webservice.leadperfection.com/\"> <clientid>%@</clientid> <username>%@</username> <password>%@</password> </ValidateLogin> </soap:Body> </soap:Envelope>",userInfo.clientID,userInfo.userName,userInfo.password];
    
    NSURL *url = [NSURL URLWithString: baseURL];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url];
    
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMsg length]];
    [req addValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [req addValue:@"http://webservice.leadperfection.com/ValidateLogin" forHTTPHeaderField:@"SOAPAction"];
    [req addValue:msgLength forHTTPHeaderField:@"Content-Length"];
    [req setHTTPMethod:@"POST"];
    [req setHTTPBody: [soapMsg dataUsingEncoding:NSUTF8StringEncoding]];
    
    [self getDataForElement:@"ValidateLoginResult" Request:req :^(id json) {
        NSString* result = [NSString stringWithFormat:@"%@",[json description]];
        
        bool success = true;
        if([result isEqualToString:@"\"NOT VALID USER\""])
            success=false;
        
        _OnLoginSuccess(&success);
    } :^(NSError *error) {

        bool success = false;
        _OnLoginSuccess(&success);
    }];    
}


-(void)getCustomersByLastName:(NSString*)lastName withUserInfo:(UserInfo *)userInfo :(void (^)(id))Success {
    
    _OnSearchSuccess = [Success copy];

    NSString *soapMsg = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body>  <GetCustomers xmlns=\"http://webservice.leadperfection.com/\"> <lastname>%@</lastname> <clientid>%@</clientid> <username>%@</username>  <password>%@</password>  </GetCustomers>  </soap:Body>  </soap:Envelope>", lastName, userInfo.clientID,userInfo.userName,userInfo.password];
    
    
    NSURL *url = [NSURL URLWithString: baseURL];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url];
    
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMsg length]];
    [req addValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [req addValue:@"http://webservice.leadperfection.com/GetCustomers" forHTTPHeaderField:@"SOAPAction"];
    [req addValue:msgLength forHTTPHeaderField:@"Content-Length"];
    [req setHTTPMethod:@"POST"];
    [req setHTTPBody: [soapMsg dataUsingEncoding:NSUTF8StringEncoding]];

    [self getDataForElement:@"GetCustomersResult" Request:req :^(id json) {
        NSLog(@"%@",[json description]);

        NSMutableArray *customers = [[NSMutableArray alloc] init];
        
        NSArray *result = [json JSONValue];
        for (id obj in result) {
            
            Customer *cust = [[Customer alloc] initWithName:[NSString stringWithFormat:@"%@, %@",[obj valueForKey:@"LastName"], [obj valueForKey:@"FirstName"]] Phone:[obj valueForKey:@"Phone"] Address:[obj valueForKey:@"Address"] City:[obj valueForKey:@"City"] State:[obj valueForKey:@"State"] Zip:[obj valueForKey:@"Zip"] Job:[obj valueForKey:@"Job"] Contract:[obj valueForKey:@"Contract"] Prospect:[[obj valueForKey:@"ProspectID"] stringValue]];

            [customers addObject:cust];
        }
        
        _OnSearchSuccess(customers);
    } :^(NSError *error) {
        
        _OnSearchSuccess(nil);
    }]; 
}

- (void)missingBaseUrl
{
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:@""
                                                      message:@"The Base URL has not been set. Please assign a value in your iPhone Settings."
                                                     delegate:self
                                            cancelButtonTitle:@"Exit"
                                            otherButtonTitles:nil];
    [message show];
}

@end
