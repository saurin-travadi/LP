//
//  Consumer.m
//  leadperfection
//
//  Created by Saurin Travadi on 8/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Consumer.h"

@implementation Consumer{
    bool elementFound;
    NSMutableString *soapResults;
    
    NSString* _element;
}


-(void)getDataForElement:(NSString*)element Request:(NSMutableURLRequest *)req :(void (^)(id))Success :(void(^)(NSError *))Failure {
    
    _element=element;  
    
    _OnSuccess = [Success copy];
    _OnFailure = [Failure copy]; 
    
    conn = [[NSURLConnection alloc] initWithRequest:req delegate:self startImmediately:YES];
    webData = [NSMutableData data];
}

-(void) connection:(NSURLConnection *) connection didReceiveResponse:(NSURLResponse *) response {
    [webData setLength: 0];
}

-(void) connection:(NSURLConnection *) connection didReceiveData:(NSData *) data {
    [webData appendData:data];
}

-(void) connection:(NSURLConnection *) connection didFailWithError:(NSError *) error {
    _OnFailure(error);
}

-(void) connectionDidFinishLoading:(NSURLConnection *) connection {
    [self parse];
}

-(void)parse{
    if (xmlParser){
        xmlParser = nil;
    }
    
    soapResults = [[NSMutableString alloc] init];
    xmlParser = [[NSXMLParser alloc] initWithData: webData];
    
    [xmlParser setDelegate: self];
    [xmlParser setShouldResolveExternalEntities:YES];
    [xmlParser parse];
}

-(void) parser:(NSXMLParser *) parser didStartElement:(NSString *) elementName namespaceURI:(NSString *) namespaceURI qualifiedName:(NSString *) qName attributes:(NSDictionary *) attributeDict {
    if( [elementName isEqualToString:_element]){
        elementFound = YES;
    }
}
-(void)parser:(NSXMLParser *) parser foundCharacters:(NSString *)string
{
    if (elementFound){
        [soapResults appendString: string];
    }
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if ([elementName isEqualToString:_element]){
        _OnSuccess(soapResults);
    } 
}

@end




