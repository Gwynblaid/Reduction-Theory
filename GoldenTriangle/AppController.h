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
    NSTextField* _parametr1;
    NSTextField* _parametr2;
}

@property (retain) IBOutlet MyOpenGLView* graphView;
@property (retain) IBOutlet StepperController* numGraphsStepperController;
@property (retain) IBOutlet NSComboBox* selectedGraph;

@property (retain) IBOutlet NSTextField* parametr1;
@property (retain) IBOutlet NSTextField* parametr2;

-(IBAction) touchBulidGraphButton:(id)sender;
-(IBAction) touchCleanButton:(id)sender;

@end
