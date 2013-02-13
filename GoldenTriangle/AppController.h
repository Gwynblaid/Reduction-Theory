//
//  AppController.h
//  GoldenTriangle
//
//  Created by Skiv on 27.11.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CustomTextField.h"

@class MyOpenGLView;
@class StepperController;
@class CoefficientsOfPreparing;

@interface AppController : NSObject<NSComboBoxDelegate, NSTextFieldDelegate>{
    
    NSView* _mainWindow;
    
    MyOpenGLView* _graphView;
    MyOpenGLView* _graph2View;
    StepperController* _numGraphsStepperController;
    NSComboBox* _selectedGraph;
    NSComboBox* _selectedDistribution2;
    NSTextField* _parametr1;
    NSTextField* _parametr2;
    NSTextField* _parametr2_1;
    NSTextField* _parametr2_2;
    NSButton* _writeToFileCheckBox;
    NSTextField* _fileNameTextField;
    CoefficientsOfPreparing* _calculationCoeffModule;
    
    NSTextField* _parametrX;
    NSTextField* _parametrT;
    
}

@property (retain) IBOutlet NSView* mainWindow;

@property (retain) IBOutlet MyOpenGLView* graphView;
@property (retain) IBOutlet MyOpenGLView* graph2View;
@property (retain) IBOutlet StepperController* numGraphsStepperController;
@property (retain) IBOutlet NSComboBox* selectedGraph;
@property (retain) IBOutlet NSComboBox* selectedDistribution2;

@property (retain) IBOutlet NSTextField* parametr1;
@property (retain) IBOutlet NSTextField* parametr2;

@property (retain) IBOutlet NSTextField* parametr2_1;
@property (retain) IBOutlet NSTextField* parametr2_2;

@property (retain) IBOutlet NSButton* writeToFileCheckBox;
@property (retain) IBOutlet NSTextField* fileNameTextField;

@property (retain) IBOutlet NSTextField* parametrX;
@property (retain) IBOutlet NSTextField* parametrT;

@property (retain) IBOutlet CoefficientsOfPreparing* calculationCoeffModule;

-(IBAction) touchBulidGraphButton:(id)sender;
-(IBAction) touchCleanButton:(id)sender;
-(IBAction) clickWriteToFileCheckBox:(id)sender;
-(IBAction) clickCalculateButton:(id)sender;

@end
