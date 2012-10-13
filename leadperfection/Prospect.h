//
//  Prospect.h
//  leadperfection
//
//  Created by Sejal Pandya on 10/12/12.
//
//

#import <Foundation/Foundation.h>

@interface Prospect : NSObject

@property (nonatomic, retain) NSString *prospectId;
@property (nonatomic, retain) NSString *description;
@property (nonatomic, retain) NSString *statValue;

-(id)initWithDescr:(NSString *)descr StateValue:(NSString*)value ForProspect:(NSString*)prospect;

@end
