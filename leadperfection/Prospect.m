//
//  Prospect.m
//  leadperfection
//
//  Created by Sejal Pandya on 10/12/12.
//
//

#import "Prospect.h"

@implementation Prospect

@synthesize prospectId=_prospectId;
@synthesize description=_description;
@synthesize statValue=_statValue;

-(id)initWithDescr:(NSString *)descr StateValue:(NSString*)value ForProspect:(NSString*)prospect {

    self = [super init];
    if (self) {
        
        _prospectId=prospect;
        _description=descr;
        _statValue=value;
        
        return self;
    }
    return nil;
}

@end
