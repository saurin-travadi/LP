//
//  LoadingOverlay.h
//  leadperfection
//
//  Created by Saurin Travadi on 8/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoadingOverlay : UIViewController
{
}

@property (nonatomic, retain, readonly) IBOutlet UIView* backdrop;
@property (nonatomic, retain, readonly) IBOutlet UILabel* loadingLabel;

@end
