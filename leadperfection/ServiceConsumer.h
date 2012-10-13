//
//  ServiceConsumer.h
//  leadperfection
//
//  Created by Saurin Travadi on 8/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Consumer.h"
#import "UserInfo.h"

@interface ServiceConsumer : Consumer {
    
    void (^_OnLoginSuccess)(bool*);
    void (^_OnSearchSuccess)(id);
}

-(void)getEmployees:(UserInfo *)userInfo :(void (^)(bool*))Success;                     //test method

-(void)performLogin:(UserInfo *)userInfo :(void (^)(bool*))Success;                     //validate username and password

-(void)getCustomersByLastName:(NSString*)lastName withUserInfo:(UserInfo *)userInfo :(void (^)(id))Success;

-(void)getLeadInfoByProspectId:(NSString*)prospectid withUserInfo:(UserInfo *)userInfo :(void (^)(id))Success;

@end
