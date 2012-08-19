//
//  Customer.m
//  leadperfection
//
//  Created by Saurin Travadi on 8/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Customer.h"

@implementation Customer

@synthesize name=_name;
@synthesize phone=_phone;
@synthesize address=_address;
@synthesize city=_city;
@synthesize state=_state;
@synthesize zip=_zip;
@synthesize job=_job;
@synthesize contract=_contract;
@synthesize prospect=_prospect;

-(id)initWithName:(NSString *)name Phone:(NSString*)phone Address:(NSString*)address City:(NSString*)city State:(NSString*)state Zip:(NSString*)zip Job:(NSString*)job Contract:(NSString*)contract Prospect:(NSString*)prospect{
    
    self = [super init];
    if (self) {
        _name=name;
        _phone=phone;
        _address=address;
        _city=city;
        _state=state;
        _zip=zip;
        _job=job;
        _contract=contract;
        _prospect=prospect;
        
        return self;
    }
    return nil;
    
}

@end
