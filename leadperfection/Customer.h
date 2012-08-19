//
//  Customer.h
//  leadperfection
//
//  Created by Saurin Travadi on 8/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Consumer.h"

@interface Customer : Consumer

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *phone;
@property (nonatomic, retain) NSString *address;
@property (nonatomic, retain) NSString *city;
@property (nonatomic, retain) NSString *state;
@property (nonatomic, retain) NSString *zip;
@property (nonatomic, retain) NSString *job;
@property (nonatomic, retain) NSString *contract;
@property (nonatomic, retain) NSString *prospect;

-(id)initWithName:(NSString *)name Phone:(NSString*)phone Address:(NSString*)address City:(NSString*)city State:(NSString*)state Zip:(NSString*)zip Job:(NSString*)job Contract:(NSString*)contract Prospect:(NSString*)prospect;

@end
