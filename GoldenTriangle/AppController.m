//
//  AppController.m
//  GoldenTriangle
//
//  Created by Skiv on 27.11.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AppController.h"
#import "MyOpenGLView.h"
#import "StepperController.h"

@implementation AppController
@synthesize graphView = _graphView;
@synthesize numGraphsStepperController = _numGraphsStepperController;
@synthesize selectedGraph = _selectedGraph;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

-(void)awakeFromNib{
    [_selectedGraph selectItemAtIndex:0];
}

-(IBAction) touchBulidGraphButton:(id)sender{
    [_graphView drawGrawWithGraphType:[_selectedGraph indexOfSelectedItem] andGraphCount:_numGraphsStepperController.stepperValue];
}

@end
