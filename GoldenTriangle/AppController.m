//
//  AppController.m
//  GoldenTriangle
//
//  Created by Skiv on 27.11.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AppController.h"
#import "MyOpenGLView.h"

@implementation AppController
@synthesize graphView = _graphView;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

-(IBAction) touchBulidGraphButton:(id)sender{
    [_graphView drawGamma];
}

@end
