//
//  AppController.h
//  GoldenTriangle
//
//  Created by Skiv on 27.11.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MyOpenGLView;
@class StepperController;

@interface AppController : NSObject{
    MyOpenGLView* _graphView;
    StepperController* _numGraphsStepperController;
    NSComboBox* _selectedGraph;
}

@property (retain) IBOutlet MyOpenGLView* graphView;
@property (retain) IBOutlet StepperController* numGraphsStepperController;
@property (retain) IBOutlet NSComboBox* selectedGraph;

-(IBAction) touchBulidGraphButton:(id)sender;

@end
